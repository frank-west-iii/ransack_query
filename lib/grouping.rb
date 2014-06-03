class Grouping
  attr_accessor :id, :combinator
  attr_reader :conditions, :groupings

  def initialize
    @id = RansackQuery.generate_id
    @combinator = :and
    @conditions = []
    @groupings = []
    yield self if block_given?
  end

  def add_condition(condition=nil)
    if block_given?
      condition = Condition.new do |new_condition|
        yield new_condition
      end
    end
    conditions << condition
    self
  end

  def add_grouping(grouping=nil)
    if block_given?
      grouping = Grouping.new do |new_grouping|
        yield new_grouping
      end
    end
    groupings << grouping
    self
  end

  def add_conditions(conditions)
    @conditions += conditions
    self
  end

  def add_groupings(groupings)
    @groupings += groupings
    self
  end

  def ransackify
    ransack_hash = {
        @id => {
            'm' => @combinator.to_s
        }
    }
    ransackify_conditions(ransack_hash)
    ransackify_groupings(ransack_hash)
    ransack_hash
  end

  private

  def ransackify_conditions(ransack_hash)
    return if conditions.empty?
    ransack_hash[@id].merge!({'c' => conditions.reduce({}) { |result, condition| result.merge! condition.ransackify }})
  end

  def ransackify_groupings(ransack_hash)
    return if groupings.empty?
    ransack_hash[@id].merge!({'g' => {}})
    groupings.each { |grouping| ransack_hash[@id]['g'].merge!(grouping.ransackify) }
  end

end
