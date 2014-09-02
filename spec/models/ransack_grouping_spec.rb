require 'spec_helper'

describe RansackGrouping do
  subject { FactoryGirl.build(:ransack_grouping) }
  let(:complex) { FactoryGirl.build(:ransack_grouping, :complex) }
  let(:with_conditions) { FactoryGirl.build(:grouping, :with_conditions) }

  it 'should have an id' do
    expect(subject.id).to_not be_nil
  end

  it 'should have a default combinator of and' do
    expect(subject.combinator).to eq :and
  end

  it 'should return a accept setting combinator' do
    expect(lambda { subject.combinator = :and }).to_not raise_error
  end

  it 'should allow you to add a condition' do
    subject.add_condition(RansackCondition.new({attribute: 'location_code', value: '001', predicate: 'eq'}))
    expect(subject.conditions.size).to eq 1
  end

  it 'should allow adding conditions through chaining' do
    subject.add_condition(RansackCondition.new(attribute: 'location_code', value: '001', predicate: 'eq')).
        add_condition(RansackCondition.new(attribute: 'location_code', value: '002', predicate: 'eq'))
    expect(subject.conditions.size).to eq 2
  end

  it 'should allow adding groupings' do
    subject.add_grouping(RansackGrouping.new)
    expect(subject.groupings.size).to eq 1
  end

  it 'should allow adding groupings through chaining' do
    subject.add_grouping(RansackGrouping.new).
        add_grouping(RansackGrouping.new)
    expect(subject.groupings.size).to eq 2
  end

  it 'should allow adding groupings without chaining' do
    subject.add_grouping(RansackGrouping.new)
    subject.add_grouping(RansackGrouping.new)
    expect(subject.groupings.size).to eq 2
  end

  it 'should allow building a group via a block' do
    g = RansackGrouping.new do |grouping|
      grouping.combinator = :or
      grouping.add_grouping do |new_grouping|
        new_grouping.add_condition(RansackCondition.new(attribute: 'ItemNumber', value: 'RC')).
            add_condition(RansackCondition.new(attribute: 'LocationCode', value: '002'))
      end
      grouping.add_grouping do |new_grouping|
        new_grouping.add_condition(RansackCondition.new(attribute: 'ItemNumber', value: 'RC')).
            add_condition(RansackCondition.new(attribute: 'LocationCode', value: '001'))
      end
    end

    expect(g.groupings.size).to eq 2
  end

  it 'should allow adding conditions en masse' do
    subject.add_conditions(
        [RansackCondition.new(attribute: 'location_code', value: '001', predicate: 'eq'),
         RansackCondition.new(attribute: 'location_code', value: '001', predicate: 'eq')])
    expect(subject.conditions.size).to eq 2
  end

  it 'should allow adding groupings en masse' do
    subject.add_groupings([RansackGrouping.new, RansackGrouping.new])
    expect(subject.groupings.size).to eq 2
  end

  it 'should allow adding a condition via a block' do
    klass = nil
    subject.add_condition do |condition|
      klass = condition.class
    end
    expect(klass).to eq RansackCondition
  end

  it 'should allow adding a group via a block' do
    klass = nil
    subject.add_grouping do |grouping|
      klass = grouping.class
    end
    expect(klass).to eq RansackGrouping
  end

  it 'should allow initializing via a block' do
    id = nil
    grouping = RansackGrouping.new do |grp|
      id = grp.id
    end
    expect(id).to eq grouping.id
  end

  it 'should build a complex ransack hash' do
    expect(complex.ransackify).to eq FactoryGirl.build(:grouping_hash)
  end

end
