require 'faker'


FactoryGirl.define do
  factory :user_role do
    user nil
    role nil
  end
  factory :role do
    name "MyString"
  end

  factory :user do
    username
    password "MyString"
  end

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

  factory :funding do
    total_price 25
    user
  end

  factory :recipient_funding do
    recipient
    funding
    microloan_amount 25
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

  sequence :username do |n|
    "myString#{n}@example.com"
  end
end
