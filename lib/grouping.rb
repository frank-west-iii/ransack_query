class Grouping
  attr_accessor :id, :combinator, :conditions, :groupings

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
        'g' => {
            @id => {
                'm' => @combinator.to_s
            }
        }
    }
    ransackify_conditions(ransack_hash)
    ransackify_groupings(ransack_hash)
    ransack_hash
  end

  private

  def ransackify_conditions(ransack_hash)
    return if conditions.empty?
    ransack_hash['g'][@id].merge!({'c' => conditions.reduce({}) {|result, condition| result.merge! condition.ransackify}})
  end

  def ransackify_groupings(ransack_hash)
    return if groupings.empty?
    groupings.each {|grouping| ransack_hash['g'][@id].merge!(grouping.ransackify)}
  end

end
