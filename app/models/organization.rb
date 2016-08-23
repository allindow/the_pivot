class Organization < ActiveRecord::Base
  before_validation :generate_slug
  has_many :recipients
  has_many :users
  validates :name, presence: true, uniqueness: true
  enum status: %w(pending active inactive denied)

  def activate_organization_status
    organization.update_attributes(status: 1)
  end

  def inactivate_organization_status
    organization.update_attributes(status: 2)
  end

  def deny_organization_status
    organization.update_attributes(status: 3)
  end

  def self.active_only
    where(status: 1)
  end

  def funds_raised
    recipients.sum(:amount_received).to_i
  end

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
