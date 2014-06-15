class MaxIntSet
  def initialize(max_value)
    @store = Array.new(max_value, false)
  end

  def include?(value)
    @store[value]
  end

  def insert(value)
    @store[value] = true
  end

  def remove(value)
    @store[value] = false
  end
end

class IntHashSet
  def initialize
    @buckets = Array.new(8) { [] }
  end

  def include?(value)
    bucket_for(value).include?(value)
  end

  def insert(value)
    return if include?(value)
    bucket_for(value) << value
  end

  def remove(value)
    return unless include?(value)
    bucket_for(value).delete(value)
  end

  protected
  def bucket_for(value)
    @buckets[value % num_buckets]
  end

  def num_buckets
    @buckets.length
  end
end

class HashSet < IntHashSet
  protected
  def bucket_for(value)
    @buckets[value.hash % num_buckets]
  end
end
