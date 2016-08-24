class Organization < ActiveRecord::Base
  before_validation :generate_slug
  has_many :recipients
  has_many :users
  validates :name, presence: true, uniqueness: true
  enum status: %w(pending active inactive denied)

  def activate_organization_status
    update_attributes(status: 1)
  end

  def deactivate_organization_status
    update_attributes(status: 2)
  end

  def deny_organization_status
    update_attributes(status: 3)
  end

  def self.active_only
    where(status: 1)
  end

  def funds_raised
    recipients.sum(:amount_received).to_i
  end
  
  def update_status(status)
    if status == "activated"
      activate_organization_status
      users.first.roles << Role.find_by(name: "org_admin") if users.first
    elsif status == "denied"
      deny_organization_status
    elsif status == "deactivated"
      deactivate_organization_status
    end
  end

  private
    def generate_slug
      self.slug = name.parameterize
    end
end
