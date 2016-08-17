class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true, email: { strict_mode: true }
  has_many :fundings
  belongs_to :organization, -> { where role: 3 }

  enum role: %w(default platform_admin organization_admin)

  def to_param
  end
end
