class Condition
  attr_accessor :id, :predicate, :attribute, :value

  def initialize(attributes={})
    @id = RansackQuery.generate_id
    @predicate = attributes[:predicate] || :eq
    @attribute = attributes[:attribute]
    @value = attributes[:value]
    yield self if block_given?
  end

  def ransackify
    {
        @id => {
            'a' => build_ransack_array(@attribute, 'name'),
            'p' => @predicate.to_s,
            'v' => build_ransack_array(@value, 'value')
        }
    }
  end

  def to_condition
    self
  end

  private
  def build_ransack_array(array, hash_key)
    counter = -1
    [array].flatten.reduce({}) do |result, attribute|
      counter += 1
      result.merge({
                       counter.to_s => {
                           hash_key => attribute
                       }
                   })
    end
  end

end
