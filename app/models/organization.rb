class Type < ActiveRecord::Base
  has_many :recipients
  validates :name, presence: true, uniqueness: true
end