require 'spec_helper'

describe Grouping do
  before do
    @grouping = Grouping.new
  end

  it 'should return a accept setting combinator' do
    (@grouping.combinator = :and).should_not raise_error
  end

  it 'should allow you to add a condition' do
    @grouping.add_condition({attribute: 'location_code', value: '001', predicate: 'eq'})
    @grouping.conditions.size.should eq 1
  end

  it 'should allow adding conditions through chaining' do
    @grouping.add_condition({attribute: 'location_code', value: '001', predicate: 'eq'}).
        add_condition({attribute: 'location_code', value: '002', predicate: 'eq'})
    @grouping.conditions.size.should eq 2
  end

  it 'should allow adding groupings' do
    @grouping.add_grouping(Grouping.new)
    @grouping.groupings.size.should eq 1
  end

  it 'should allow adding groupings through chaining' do
    @grouping.add_grouping(Grouping.new).
        add_grouping(Grouping.new)
    @grouping.groupings.size.should eq 2
  end

end