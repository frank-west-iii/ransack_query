require 'spec_helper'

describe RansackQuery do
  it 'should build' do
    RansackQuery.build.should_not raise_error
  end

  it 'should return a grouping to build off' do
    klass = nil
    RansackQuery.build do |group|
      klass = group.class
    end
    klass.should equal Grouping
  end

end