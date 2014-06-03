# encoding: utf-8
FactoryGirl.define do

  factory :condition do
    id 1
    attribute 'attribute'
    value 'value'

    trait :document_number do
      id 2
      attribute 'document_number'
      value '111'
    end

    trait :driver_name do
      id 3
      attribute 'driver_name'
      value '222'
    end
  end

end