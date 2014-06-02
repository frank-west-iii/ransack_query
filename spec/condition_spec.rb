require 'spec_helper'

describe Condition do
  before do
    @condition = Condition.new
  end

  it 'should have an id' do
    @condition.id.should_not be nil
  end


  it 'should accept a predicate' do
    (@condition.predicate = :eq).should_not raise_error
  end

  it 'should accept an attribute' do
    (@condition.attribute = 'attribute').should_not raise_error
  end

  it 'should accept a value' do
    (@condition.value = 'value').should_not raise_error
  end

  it 'should accept setting the attribute via the initializer' do
    condition = Condition.new(attribute: 'attribute')
    condition.attribute.should eq 'attribute'
  end

  it 'should accept setting the value via the initializer' do
    condition = Condition.new(value: 'value')
    condition.value.should eq 'value'
  end

end