require 'ransack_query/version'
require 'grouping'

module RansackQuery

  def self.build
    yield Grouping.new if block_given?
  end

end
