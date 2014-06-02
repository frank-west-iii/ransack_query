require 'spec_helper'

describe RansackQuery do
  it 'should build' do
    RansackQuery.build.should_not raise_error
  end

  it 'should return a grouping to build off' do
    RansackQuery.build do |group|
      group.class.should equal Grouping
    end
  end

end