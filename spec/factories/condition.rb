# encoding: utf-8
FactoryGirl.define do

  factory :condition do
    id 1
    attribute 'attribute'
    value 'value'

    trait :first_name do
      id 2
      attribute 'first_name'
      value 'Bob'
    end

    trait :last_name do
      id 3
      attribute 'last_name'
      value 'Smith'
    end
  end

end