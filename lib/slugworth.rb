require "slugworth/version"

module Slugworth
  extend ActiveSupport::Concern

  included do
    cattr_accessor :slug_attribute, :slug_scope, :slug_incremental, :slug_updatable
    before_validation(:add_slug)
  end

  module ClassMethods
    def slugged_with(slug_attribute, opts = {})
      self.slug_attribute   = slug_attribute
      self.slug_scope       = opts.delete(:scope)
      self.slug_incremental = opts.delete(:incremental)
      self.slug_updatable   = opts.delete(:updatable)
      validates_uniqueness_of :slug, scope: slug_scope
    end

    def find_by_slug!(slug)
      find_by!(slug: slug)
    end

    def find_by_slug(slug)
      find_by(slug: slug)
    end
  end

  def to_param; slug; end

  private

  def add_slug
    self.slug = processed_slug if generate_slug?
  end

  def generate_slug?
    !slug.present? || slug_updatable && changes[slug_attribute].present?
  end

  def processed_slug
    slug_incremental ? process_incremental_slug : parameterized_slug
  end

  def parameterized_slug
    public_send(slug_attribute).parameterize
  end

  def process_incremental_slug
    slugs = matching_slugs
    if slugs.include?(parameterized_slug)
      (1..slugs.size).each do |i|
        incremented_slug = "#{parameterized_slug}-#{i}"
        return incremented_slug unless slugs.include?(incremented_slug)
      end
    else
      parameterized_slug
    end
  end

  def matching_slugs
    table = self.class.arel_table
    primary_key = self.class.primary_key
    query = table[:slug].matches("#{parameterized_slug}%")
    query = query.and(table[primary_key].not_eq(read_attribute(primary_key))) unless new_record?
    Array.wrap(slug_scope).each do |scope|
      query = query.and(table[scope].eq(read_attribute(scope)))
    end
    self.class.where(query).pluck(:slug)
  end
end
