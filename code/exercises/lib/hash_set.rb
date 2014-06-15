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
