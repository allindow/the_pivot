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

  def activate
    update_attribute(:retired, false)
  end

  def has_funds?
    amount_received.to_i != 0
  end

  def self.active_only
    all.select do |recipient|
      recipient.organization.status == "active"
    end
  end

  def toggle_status
    self.retired ? self.activate : self.retire
  end

  def status_message
    self.retired ? inactive_message : reactivated_message
  end

  private
    def generate_slug
      self.slug = name.parameterize
    end

    def inactive_message
      "#{self.name} is inactive"
    end

    def reactivated_message
      "#{self.name} has been reactivated"
    end
end
