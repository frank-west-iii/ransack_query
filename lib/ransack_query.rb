require 'ransack_query/version'
require 'grouping'
require 'condition'
require 'json'
require 'securerandom'

module RansackQuery

  def self.build
    grouping = Grouping.new do |new_grouping|
      yield new_grouping
    end
    grouping.ransackify.to_json
  end

  def self.generate_id
    SecureRandom.hex
  end

end
