require 'faker'


FactoryGirl.define do

  # factory :user do
  #   username "MyString"
  #   password "MyString"
  # end

  factory :organization do
    name
    description "At Hope for Veterans, we strive to make the transition from military life to civilian life as smooth as possible. We help veterans from militaries across the world discover their passions and achieve their dreams by providing resources for them to receive funding for their new life ventures."
  end

  factory :country do
    name
  end

  factory :recipient do
    name
    amount_received 25.00
    description
    organization
    country
  end

  sequence :description do |n|
    "Description_#{n}"
  end

  sequence :organization do |n|
    "Organization_#{n}"
  end

  sequence :name do |n|
    "Name_#{n}"
  end
end
