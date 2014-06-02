require 'id_generator'
class Grouping
  attr_accessor :id, :combinator, :conditions, :groupings

  def initialize
    @id = IdGenerator.generate
    @combinator = :and
    @conditions = []
    @groupings = []
  end

  def add_condition(condition=nil)
    if block_given?
      condition = yield Condition.new
    end
    conditions << condition
    self
  end

  def add_grouping(grouping=nil)
    if block_given?
      grouping = yield Grouping.new
    end
    groupings << grouping
    self
  end

  def add_conditions(conditions)
    @conditions += conditions
  end

  def add_groupings(groupings)
    @groupings += groupings
  end

end
