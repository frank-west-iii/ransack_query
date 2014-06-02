require 'id_generator'
class Grouping
  attr_accessor :id, :combinator, :conditions, :groupings

  def initialize
    @id = IdGenerator.generate
    @combinator = :and
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
