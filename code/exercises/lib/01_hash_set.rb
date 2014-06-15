class ArraySet
  def initialize
    self.store = []
  end

  def include?(target_item)
    # Using each to emphasize O(n) time complexity.
    self.store.each do |item|
      return true if item == target_item
    end

    false
  end

  # return true if item is added
  def insert(item)
    return false if self.include?(item)

    self.store << item
    true
  end

  # return true if item was present
  def remove(target_item)
    # again iterating to emphasize O(n) time complexity.
    self.store.each_with_index do |item, idx|
      next unless item == target_item

      self.store.delete_at(idx)
      return true
    end

    false
  end

  protected
  attr_accessor :store
end

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
  DEFAULT_SIZE = 8
  MAX_LOAD = 1.00

  attr_reader :count

  def initialize
    @buckets = Array.new(DEFAULT_SIZE) { [] }
    @count = 0
  end

  def include?(value)
    bucket_for(value).include?(value)
  end

  def insert(value)
    return if include?(value)

    # Resize if we would exceed max load.
    self.resize! if (count + 1).fdiv(num_buckets) > MAX_LOAD

    bucket_for(value) << value
    @count += 1
  end

  def remove(value)
    return unless include?(value)
    bucket_for(value).delete(value)
    @count -= 1
  end

  protected
  def bucket_for(value, buckets = @buckets)
    buckets[value_hash(value) % buckets.length]
  end

  def value_hash(value)
    value
  end

  def num_buckets
    @buckets.length
  end

  def resize!
    new_buckets = Array.new(num_buckets * 2) { [] }
    # Takes O(n) time despite double loops.
    self.buckets.each do |bucket|
      bucket.each do |item|
        bucket_for(item, new_buckets) << item
      end
    end

    @buckets = new_buckets
  end
end

class HashSet < IntHashSet
  protected
  def value_hash(value)
    value.hash
  end
end
