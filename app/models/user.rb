class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true
  has_many :fundings

  def to_param
  end
end
