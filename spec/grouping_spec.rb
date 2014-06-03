require 'spec_helper'

describe Grouping do
  before do
    @grouping = Grouping.new
  end

  it 'should have an id' do
    @grouping.id.should_not be nil
  end

  it 'should have a default combinator of and' do
    @grouping.combinator.should eq :and
  end

  it 'should return a accept setting combinator' do
    lambda { @grouping.combinator = :and }.should_not raise_error
  end

  it 'should allow you to add a condition' do
    @grouping.add_condition({attribute: 'location_code', value: '001', predicate: 'eq'})
    @grouping.conditions.size.should eq 1
  end

  it 'should allow adding conditions through chaining' do
    @grouping.add_condition(Condition.new(attribute: 'location_code', value: '001', predicate: 'eq')).
        add_condition(Condition.new(attribute: 'location_code', value: '002', predicate: 'eq'))
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

  it 'should allow adding conditions en masse' do
    @grouping.add_conditions(
        [Condition.new(attribute: 'location_code', value: '001', predicate: 'eq'),
         Condition.new(attribute: 'location_code', value: '001', predicate: 'eq')])
    @grouping.conditions.size.should eq 2
  end

  it 'should allow adding groupings en masse' do
    @grouping.add_groupings([Grouping.new, Grouping.new])
    @grouping.groupings.size.should eq 2
  end

  it 'should allow adding a condition via a block' do
    klass = nil
    @grouping.add_condition do |condition|
      klass = condition.class
    end
    klass.should eq Condition
  end

  it 'should allow adding a group via a block' do
    klass = nil
    @grouping.add_grouping do |grouping|
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
    results = {
        'g' => {
            'id1' => {
                'm' => 'or',
                'g' => {
                    'id2' => {
                        'm' => 'and',
                        'c' => {
                            'id3' => {
                                'a' => {
                                    '0' => {
                                        'name' => 'ItemNumber'
                                    }
                                },
                                'p' => 'eq',
                                'v' => {
                                    '0' => {
                                        'value' => 'RC'
                                    }
                                }
                            },
                            'id4' => {
                                'a' => {
                                    '0' => {
                                        'name' => 'LocationCode'
                                    }
                                },
                                'p' => 'eq',
                                'v' => {
                                    '0' => {
                                        'value' => '002'
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @grouping.id = 'id1'
    @grouping.combinator = :or

    @grouping.add_grouping do |grouping|
      grouping.id = 'id2'
      grouping.combinator = :and

      grouping.add_condition do |condition|
        condition.id = 'id3'
        condition.attribute = 'ItemNumber'
        condition.value = 'RC'
      end

      grouping.add_condition do |condition|
        condition.id = 'id4'
        condition.attribute = 'LocationCode'
        condition.value = '002'
      end
    end

    @grouping.ransackify.should eq results

  end

end