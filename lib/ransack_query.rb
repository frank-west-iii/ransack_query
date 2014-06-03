require 'ransack_query/version'
require 'grouping'
require 'condition'
require 'json'
require 'securerandom'

module RansackQuery

  def self.build(options = {})
    grouping = Grouping.new do |new_grouping|
      yield new_grouping
    end
    ransack_hash = grouping.ransackify
    ransack_hash = {options[:prefix] => ransack_hash} if options[:prefix]
    ransack_hash.to_json.gsub(/"ransack_group.*?"/, '"g"')
  end

  def self.generate_id
    SecureRandom.hex
  end

end
