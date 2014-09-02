require 'ransack_query/version'
require 'ransack_grouping'
require 'ransack_condition'
require 'json'
require 'securerandom'

module RansackQuery

  def self.build(options = {})
    grouping = RansackGrouping.new do |new_grouping|
      yield new_grouping
    end
    ransack_hash = {'g' => grouping.ransackify}
    ransack_hash = {options[:prefix] => ransack_hash} if options[:prefix]
    ransack_hash = ransack_hash.to_json if options[:format] == :json
    ransack_hash
  end

  def self.generate_id
    SecureRandom.hex
  end

end
