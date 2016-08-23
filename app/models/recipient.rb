class Recipient < ActiveRecord::Base
  before_validation :generate_slug
  validates_presence_of :slug
  validates :name, presence: true, uniqueness: true
  validates :organization, presence: true
  validates :description, presence: true
  validates :country, presence: true
  belongs_to :organization
  belongs_to :country
  has_many :recipient_fundings
  has_many :fundings, through: :recipient_fundings


  def retire
    update_attribute(:retired, true)
  end

  def has_funds?
    amount_received.to_i != 0
  end

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
