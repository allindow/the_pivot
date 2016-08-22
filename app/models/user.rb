class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 1 }, allow_nil: true
  validates :username, presence: true, uniqueness: true, email: { strict_mode: true }
  has_many :fundings
  belongs_to :organization
  has_many :user_roles
  has_many :roles, through: :user_roles

  def to_param
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def org_admin?
    roles.exists?(name: "org_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
