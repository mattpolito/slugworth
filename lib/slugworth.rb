require "slugworth/version"

module Slugworth
  extend ActiveSupport::Concern

  included do
    cattr_accessor :slug_attribute, :slug_scope
    before_validation(:add_slug)
  end

  module ClassMethods
    def slugged_with(slug_attribute, opts={})
      self.slug_attribute = slug_attribute
      self.slug_scope = opts.delete(:scope)
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
    self.slug = processed_slug unless slug.present?
  end

  def processed_slug
    public_send(slug_attribute).parameterize
  end
end
