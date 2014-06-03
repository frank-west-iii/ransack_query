require 'ransack_query/version'
require 'grouping'
require 'condition'
require 'json'
require 'securerandom'

module RansackQuery

  def self.build(prefix = nil)
    grouping = Grouping.new do |new_grouping|
      yield new_grouping
    end
    ransack_hash = grouping.ransackify
    ransack_hash = {prefix => ransack_hash} unless prefix.nil?
    ransack_hash.to_json
  end

  def self.generate_id
    SecureRandom.hex
  end

end
