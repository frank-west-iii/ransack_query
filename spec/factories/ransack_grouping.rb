# encoding: utf-8
FactoryGirl.define do

  factory :ransack_grouping do
    id 1

    trait :complex do
      combinator :or
      after(:build) do |obj|
        grouping = FactoryGirl.build(:ransack_grouping, :with_conditions)
        grouping.id = 2
        obj.add_grouping(grouping)
        grouping = FactoryGirl.build(:ransack_grouping, :with_conditions)
        grouping.id = 3
        obj.add_grouping(grouping)
      end
    end

    trait :with_conditions do
      id 2
      after(:build) do |obj|
        obj.add_condition FactoryGirl.build(:ransack_condition, :document_number)
        obj.add_condition FactoryGirl.build(:ransack_condition, :driver_name)
      end
    end

  end

end
