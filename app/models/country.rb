class Country < ActiveRecord::Base
  has_many :recipients
  before_validation :generate_slug
  validates_presence_of :slug

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
