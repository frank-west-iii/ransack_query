require 'spec_helper'

describe RansackQuery do
  it 'should not build without a block' do
    lambda { RansackQuery.build }.should raise_error
  end

  it 'should return a grouping to build off' do
    klass = nil
    RansackQuery.build do |grouping|
      klass = grouping.class
    end
    klass.should equal Grouping
  end

  it 'should return a json string' do
    RansackQuery.build do |grouping|
      grouping.id = 'id1'
      grouping.add_condition do |condition|
        condition.id = 'id2'
        condition.attribute = 'attribute'
        condition.value = 'value'
      end
    end.should eq "{\"g\":{\"id1\":{\"m\":\"and\",\"c\":{\"id2\":{\"a\":{\"0\":{\"name\":\"attribute\"}},\"p\":\"eq\",\"v\":{\"0\":{\"value\":\"value\"}}}}}}}"
  end

  it 'should allow a prefix to be passed in' do
    RansackQuery.build('q') do |grouping|
      grouping.id = 'id1'
      grouping.add_condition do |condition|
        condition.id = 'id2'
        condition.attribute = 'attribute'
        condition.value = 'value'
      end
    end.should eq "{\"q\":{\"g\":{\"id1\":{\"m\":\"and\",\"c\":{\"id2\":{\"a\":{\"0\":{\"name\":\"attribute\"}},\"p\":\"eq\",\"v\":{\"0\":{\"value\":\"value\"}}}}}}}}"
  end

end