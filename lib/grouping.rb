class Grouping
  attr_accessor :combinator, :conditions, :groupings

  def initialize
    @conditions = []
    @groupings = []
  end

  def add_condition(condition)
    conditions << condition
    self
  end

  def add_grouping(grouping)
    groupings << grouping
    self
  end

end
