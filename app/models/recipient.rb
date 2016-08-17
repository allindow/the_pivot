class Recipient < ActiveRecord::Base
  before_validation :generate_slug
  validates_presence_of :slug
  validates :name, presence: true, uniqueness: true
  belongs_to :organization
  belongs_to :country
  # validates :organization, presence: true
  has_many :recipient_fundings
  has_many :fundings, through: :recipient_fundings

  def retire
    update_attribute(:retired, true)
  end

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
