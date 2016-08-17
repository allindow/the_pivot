require 'faker'


FactoryGirl.define do

  # factory :user do
  #   username "MyString"
  #   password "MyString"
  # end

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
