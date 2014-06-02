require 'spec_helper'

describe Condition do
  before do
    @condition = Condition.new
  end

  it 'should have an id' do
    @condition.id.should_not be nil
  end

  it 'should have a default predicate of eq' do
    @condition.predicate.should eq :eq
  end

  it 'should accept a predicate' do
    lambda {@condition.predicate = :eq}.should_not raise_error
  end

  it 'should accept an attribute' do
    lambda {@condition.attribute = 'attribute'}.should_not raise_error
  end

  it 'should accept a value' do
    lambda {@condition.value = 'value'}.should_not raise_error
  end

  it 'should accept setting the attribute via the initializer' do
    condition = Condition.new(attribute: 'attribute')
    condition.attribute.should eq 'attribute'
  end

  it 'should accept setting the value via the initializer' do
    condition = Condition.new(value: 'value')
    condition.value.should eq 'value'
  end

  it 'should accept setting the predicate via the initializer' do
    condition = Condition.new(predicate: 'predicate')
    condition.predicate.should eq 'predicate'
  end

  it 'should build a ransack hash' do
    result = {
        'c' => {
            'id' => {
                'a' => {
                    '0' => {
                        'name' => 'attribute'
                    }
                },
                'p' => 'eq',
                'v' => {
                    '0' => {
                        'value' => 'value1'
                    },
                    '1' => {
                        'value' => 'value2'
                    }
                }
            }
        }
    }
    @condition.id = 'id'
    @condition.predicate = :eq
    @condition.attribute = 'attribute'
    @condition.value = %w{value1 value2}
    ransack_hash = @condition.ransackify
    ransack_hash.should eq result
  end

end