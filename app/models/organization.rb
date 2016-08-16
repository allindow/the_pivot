class Type < ActiveRecord::Base
  has_many :creatures
  validates :name, presence: true, uniqueness: true
end