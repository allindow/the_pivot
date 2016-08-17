require 'faker'

FactoryGirl.define do
  factory :organization do
    name "Hope for Veterans"
    description "At Hope for Veterans, we strive to make the transition from military life to civilian life as smooth as possible. We help veterans from militaries across the world discover their passions and achieve their dreams by providing resources for them to receive funding for their new life ventures."
  end

  factory :recipient do
    name "Joe Jones"
    amount_received 25.00
    description "Joe needs help in the transition from military to civilian life"
    country "USA"
  end
end
#   factory :user do
#     username "MyString"
#     password "MyString"
#   end
  # factory :order do
  #
  # end
  #
  # creature_names = ["Unicorn", "Centaur", "Alicorn"]
  # creature_prices = [200.00, 300.00, 100.00]
  # creature_description = Faker::Hipster.paragraphs(1)
  # type_names = ["Terrestrial", "Aquatic", "Aerial"]
  #
  # factory :creature do
  #   name creature_names.sample
  #   price creature_prices.sample
  #   description creature_description
  # end
  #
  # factory :type do
  #   name type_names.sample
  # end

# end
