require 'id_generator'

class Condition
  attr_accessor :id, :predicate, :attribute, :value

  def initialize(attributes={})
    @id = IdGenerator.generate
    @attribute = attributes[:attribute]
    @value = attributes[:value]
  end

end