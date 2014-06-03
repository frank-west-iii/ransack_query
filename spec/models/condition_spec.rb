require 'spec_helper'

describe Condition do

  it 'should have an id' do
    subject.id.should_not be nil
  end

  it 'should have a default predicate of eq' do
    subject.predicate.should eq :eq
  end

  it 'should accept a predicate' do
    lambda { subject.predicate = :eq }.should_not raise_error
  end

  it 'should accept an attribute' do
    lambda { subject.attribute = 'attribute' }.should_not raise_error
  end

  it 'should accept a value' do
    lambda { subject.value = 'value' }.should_not raise_error
  end

  it 'should accept setting the attribute via the initializer' do
    condition = Condition.new(attribute: 'new_attribute')
    condition.attribute.should eq 'new_attribute'
  end

  it 'should accept setting the value via the initializer' do
    condition = Condition.new(value: 'new_value')
    condition.value.should eq 'new_value'
  end

  it 'should accept setting the predicate via the initializer' do
    condition = Condition.new(predicate: 'new_predicate')
    condition.predicate.should eq 'new_predicate'
  end

  it 'should allow initializing via a block' do
    id = nil
    condition = Condition.new do |condition|
      id = condition.id
    end
    id.should eq condition.id
  end

  it 'should build a ransack hash' do
    condition = FactoryGirl.build(:condition)
    condition.ransackify.should eq FactoryGirl.build(:condition_hash)
  end

end