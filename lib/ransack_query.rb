require 'ransack_query/version'
require 'grouping'
require 'condition'

module RansackQuery

  def self.build
    yield Grouping.new if block_given?
  end

  def self.generate_id
    (Time.now.to_f * 1000).to_i
  end

end
