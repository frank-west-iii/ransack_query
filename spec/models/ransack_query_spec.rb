require 'spec_helper'

describe RansackQuery do
  it 'should not build without a block' do
    expect(lambda { RansackQuery.build }).to raise_error
  end

  it 'should return a grouping to build off' do
    klass = nil
    RansackQuery.build do |grouping|
      klass = grouping.class
    end
    expect(klass).to eq RansackGrouping
  end

  it 'should return a hash' do
    result = RansackQuery.build do |grouping|
      grouping.id = 'id1'
      grouping.add_condition do |condition|
        condition.id = 'id2'
        condition.attribute = 'attribute'
        condition.value = 'value'
      end
    end
    expect(result).to eq({'g' => {'id1' => {'m' => 'and', 'c' => {'id2' => {'a' => {'0' => {'name' => 'attribute'}}, 'p' => 'eq', 'v' => {'0' => {'value' => 'value'}}}}}}})
  end

  it 'should return a json string if specified' do
    result = RansackQuery.build(format: :json) do |grouping|
      grouping.id = 'id1'
      grouping.add_condition do |condition|
        condition.id = 'id2'
        condition.attribute = 'attribute'
        condition.value = 'value'
      end
    end
    expect(result).to eq "{\"g\":{\"id1\":{\"m\":\"and\",\"c\":{\"id2\":{\"a\":{\"0\":{\"name\":\"attribute\"}},\"p\":\"eq\",\"v\":{\"0\":{\"value\":\"value\"}}}}}}}"
  end

  it 'should allow a prefix to be passed in' do
    result = RansackQuery.build(prefix: 'q') do |grouping|
      grouping.id = 'id1'
      grouping.add_condition do |condition|
        condition.id = 'id2'
        condition.attribute = 'attribute'
        condition.value = 'value'
      end
    end
    expect(result).to eq({'q' => {'g' => {'id1' => {'m' => 'and', 'c' => {'id2' => {'a' => {'0' => {'name' => 'attribute'}}, 'p' => 'eq', 'v' => {'0' => {'value' => 'value'}}}}}}}})
  end
end
