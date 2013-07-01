require "sluggle/version"

module Sluggle
  extend ActiveSupport::Concern

  included do
    cattr_accessor :slug_attribute
    before_validation(:add_slug)
    validates_uniqueness_of :slug
  end

  module ClassMethods
    def slugged_with(slug_attribute)
      self.slug_attribute = slug_attribute
    end

    def find_by_slug(slug)
      find_by!(slug: slug)
    end
  end

  def to_param; slug; end

  private
  def add_slug
    self.slug = processed_slug unless slug.present?
  end

  def processed_slug
    send(slug_attribute).parameterize
  end
end
