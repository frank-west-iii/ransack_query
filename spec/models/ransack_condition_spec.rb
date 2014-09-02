require 'spec_helper'

describe RansackCondition do
  let(:condition) { FactoryGirl.build(:ransack_condition) }
  let(:condition_hash) { FactoryGirl.build(:condition_hash) }

  it 'should have an id' do
    expect(subject.id).to_not be_nil
  end

  it 'should have a default predicate of eq' do
    expect(subject.predicate).to eq :eq
  end

  it 'should accept a predicate' do
    expect(lambda { subject.predicate = :eq }).to_not raise_error
  end

  it 'should accept an attribute' do
    expect(lambda { subject.attribute = 'attribute' }).to_not raise_error
  end

  it 'should accept a value' do
    expect(lambda { subject.value = 'value' }).to_not raise_error
  end

  it 'should accept setting the attribute via the initializer' do
    expect(RansackCondition.new(attribute: 'new_attribute').attribute).to eq 'new_attribute'
  end

  it 'should accept setting the value via the initializer' do
    expect(RansackCondition.new(value: 'new_value').value).to eq 'new_value'
  end

  it 'should accept setting the predicate via the initializer' do
    expect(RansackCondition.new(predicate: 'new_predicate').predicate).to eq 'new_predicate'
  end

  it 'should allow initializing via a block' do
    id = nil
    new_condition = RansackCondition.new do |condition|
      id = condition.id
    end
    expect(id).to eq new_condition.id
  end

  it 'should build a ransack hash' do
    expect(condition.ransackify).to eq condition_hash
  end
end
