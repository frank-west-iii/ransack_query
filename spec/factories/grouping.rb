# encoding: utf-8
FactoryGirl.define do

  factory :grouping do
    id 1

    trait :complex do
      combinator :or
      after(:build) do |obj|
        obj.add_grouping(FactoryGirl.build(:grouping, :with_conditions))
      end
    end

    trait :with_conditions do
      id 2
      after(:build) do |obj|
        obj.add_condition FactoryGirl.build(:condition, :first_name)
        obj.add_condition FactoryGirl.build(:condition, :last_name)
      end
    end

  end

end