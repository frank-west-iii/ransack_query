# encoding: utf-8
FactoryGirl.define do

  factory :grouping do
    id 1

    trait :or_grouping do
      combinator :or
    end
  end

end