require 'spec_helper'

describe Grouping do
  subject { FactoryGirl.build(:grouping) }
  let(:complex) { FactoryGirl.build(:grouping, :complex) }
  let(:with_conditions) { FactoryGirl.build(:grouping, :with_conditions) }

  it 'should have an id' do
    subject.id.should_not be nil
  end

  it 'should have a default combinator of and' do
    subject.combinator.should eq :and
  end

  it 'should return a accept setting combinator' do
    lambda { subject.combinator = :and }.should_not raise_error
  end

  it 'should allow you to add a condition' do
    subject.add_condition({attribute: 'location_code', value: '001', predicate: 'eq'})
    subject.conditions.size.should eq 1
  end

  it 'should allow adding conditions through chaining' do
    subject.add_condition(Condition.new(attribute: 'location_code', value: '001', predicate: 'eq')).
        add_condition(Condition.new(attribute: 'location_code', value: '002', predicate: 'eq'))
    subject.conditions.size.should eq 2
  end

  it 'should allow adding groupings' do
    subject.add_grouping(Grouping.new)
    subject.groupings.size.should eq 1
  end

  it 'should allow adding groupings through chaining' do
    subject.add_grouping(Grouping.new).
        add_grouping(Grouping.new)
    subject.groupings.size.should eq 2
  end

  it 'should allow adding conditions en masse' do
    subject.add_conditions(
        [Condition.new(attribute: 'location_code', value: '001', predicate: 'eq'),
         Condition.new(attribute: 'location_code', value: '001', predicate: 'eq')])
    subject.conditions.size.should eq 2
  end

  it 'should allow adding groupings en masse' do
    subject.add_groupings([Grouping.new, Grouping.new])
    subject.groupings.size.should eq 2
  end

  it 'should allow adding a condition via a block' do
    klass = nil
    subject.add_condition do |condition|
      klass = condition.class
    end
    klass.should eq Condition
  end

  it 'should allow adding a group via a block' do
    klass = nil
    subject.add_grouping do |grouping|
      klass = grouping.class
    end
    klass.should eq Grouping
  end

  it 'should allow initializing via a block' do
    id = nil
    grouping = Grouping.new do |grouping|
      id = grouping.id
    end
    id.should eq grouping.id
  end

  it 'should build a ransack hash' do
    complex.ransackify.should eq FactoryGirl.build(:grouping_hash)
  end

end