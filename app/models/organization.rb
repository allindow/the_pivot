class Organization < ActiveRecord::Base
  has_many :recipients
  validates :name, presence: true, uniqueness: true
  
  #need to set status 
  def change_organization_status
    organization.update_attributes(status: "active")
  end
end
