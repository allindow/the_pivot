class CreaturesOrder < ActiveRecord::Base
  belongs_to :creature
  belongs_to :funding
end
