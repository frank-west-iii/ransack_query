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
    ransack_hash = {'g' => grouping.ransackify}
    ransack_hash = {options[:prefix] => ransack_hash} if options[:prefix]
    ransack_hash = ransack_hash.to_json if options[:format] == :json
    ransack_hash
  end

  def self.generate_id
    SecureRandom.hex
  end

  def self.sample
    build do |grouping|
      grouping.combinator = :or
      grouping.add_grouping do |new_grouping|
        new_grouping.add_condition(Condition.new(attribute: 'document_number', value: '111'))
        new_grouping.add_condition(Condition.new(attribute: 'driver_name', value: '222'))
      end
      grouping.add_grouping do |new_grouping|
        new_grouping.add_condition(Condition.new(attribute: 'document_number', value: '333'))
        new_grouping.add_condition(Condition.new(attribute: 'driver_name', value: '444'))
      end
    end
  end

end
