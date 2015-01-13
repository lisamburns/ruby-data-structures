class ArraySet
  attr_reader :count

  def initialize
    self.count, self.store = 0, []
  end

  # O(n)
  def include?(target_item)
    # Using each to emphasize O(n) time complexity.
    store.each do |item|
      return true if item == target_item
    end

    false
  end

  # O(n)
  def insert(item)
    return false if include?(item)

    store << item
    self.count += 1
    # return true if item is added
    true
  end

  # O(n)
  def remove(target_item)
    # again iterating to emphasize O(n) time complexity.
    store.each_with_index do |item, idx|
      next unless item == target_item

      store.delete_at(idx)
      self.count -= 1
      return true
    end

    false
  end

  protected
  attr_accessor :store
  attr_writer :count
end

class MaxIntSet
  attr_reader :count

  # Uses memory proportional to size of max value, not the number of
  # elements.
  def initialize(max_value)
    self.count, self.store = 0, Array.new(max_value, false)
  end

  # O(1)
  def include?(value)
    store[value]
  end

  # O(1)
  def insert(value)
    return false if include?(value)

    store[value] = true
    self.count += 1

    true
  end

  # O(1)
  def remove(value)
    return false unless include?(value)

    store[value] = false
    self.count -= 1

    true
  end

  protected
  attr_accessor :store
  attr_writer :count
end

class IntHashSet
  DEFAULT_SIZE = 8
  MAX_LOAD = 1.00

  attr_reader :count

  def initialize
    self.buckets = Array.new(DEFAULT_SIZE) { [] }
    self.count = 0
  end

  # O(1) randomized
  def include?(value)
    # include is linear time, but if bucket size is constant if data
    # is randomly distributed, then this is O(1) randomized.
    bucket_for(value).include?(value)
  end

  # O(1) randomized, amortized
  def insert(value)
    # This takes O(1) randomized
    return false if include?(value)

    # Resize if we would exceed max load. Is O(n), but happens
    # infrequently, so amoritzed O(1)
    self.resize! if (count + 1).fdiv(buckets.length) > MAX_LOAD

    # DynamicArray push is O(1) amortized
    bucket_for(value) << value
    self.count += 1

    true
  end

  # O(1) randomized
  def remove(value)
    # This takes O(1) randomized
    return unless include?(value)

    # delete is linear time, but if bucket size is constant if data
    # is randomly distributed, then this is O(1) randomized.
    bucket_for(value).delete(value)
    self.count -= 1
  end

  protected
  attr_accessor :buckets
  attr_writer :count

  def bucket_for(value, buckets = self.buckets)
    buckets[value_hash(value) % buckets.length]
  end

  def value_hash(value)
    value
  end

  def resize!
    new_buckets = Array.new(buckets.length * 2) { [] }
    # Takes O(n) time despite double loops.
    buckets.each do |bucket|
      bucket.each do |item|
        bucket_for(item, new_buckets) << item
      end
    end

    self.buckets = new_buckets
  end
end

class HashSet < IntHashSet
  protected
  def value_hash(value)
    # Simply start using the appropriate hash method for everything to
    # work with arbitrary object types!
    value.hash
  end
end
