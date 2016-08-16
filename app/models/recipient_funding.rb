class CreaturesOrder < ActiveRecord::Base
  belongs_to :creature
  belongs_to :order
end