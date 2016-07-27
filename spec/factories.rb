require 'faker'

FactoryGirl.define do
  factory :order do
    
  end
  
  creature_names = ["Unicorn", "Centaur", "Alicorn"]
  creature_prices = [200.00, 300.00, 100.00]
  creature_description = Faker::Hipster.paragraphs(1)
  type_names = ["Terrestrial", "Aquatic", "Aerial"]

  factory :creature do
    name creature_names.sample
    price creature_prices.sample
    description creature_description
  end

  factory :type do
    name type_names.sample
  end

end
