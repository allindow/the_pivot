class Organization < ActiveRecord::Base
  before_validation :generate_slug
  has_many :recipients
  validates :name, presence: true, uniqueness: true

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
