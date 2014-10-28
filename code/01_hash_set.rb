class ArraySet
  def initialize
    @store = []
  end

  # O(n)
  def include?(target_item)
    # Using each to emphasize O(n) time complexity.
    @store.each do |item|
      return true if item == target_item
    end

    false
  end

  # O(n)
  def insert(item)
    return false if include?(item)

    @store << item
    # return true if item is added
    true
  end

  # O(n)
  def remove(target_item)
    # again iterating to emphasize O(n) time complexity.
    @store.each_with_index do |item, idx|
      next unless item == target_item

      @store.delete_at(idx)
      return true
    end

    false
  end
end

s = ArraySet.new
(0...100).to_a.shuffle!.each { |el| s.insert(el) if el.odd? }
(0...100).each do |el|
  if el.odd?
    fail unless s.include?(el)
  else
    fail if s.include?(el)
  end
end

class MaxIntSet
  # Uses memory proportional to size of max value, not the number of
  # elements.
  def initialize(max_value)
    @store = Array.new(max_value, false)
  end

  # O(1)
  def include?(value)
    @store[value]
  end

  # O(1)
  def insert(value)
    return false if include?(value)
    @store[value] = true

    true
  end

  # O(1)
  def remove(value)
    return false unless include?(value)
    @store[value] = false

    true
  end
end

s = MaxIntSet.new(100)
(0...100).to_a.shuffle!.each { |el| s.insert(el) if el.odd? }
(0...100).each do |el|
  if el.odd?
    fail unless s.include?(el)
  else
    fail if s.include?(el)
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

  # O(1) randomized; assumes buckets don't grow to large.
  def include?(value)
    bucket_for(value).include?(value)
  end

  # O(1) amortized
  def insert(value)
    # This takes O(1) randomized
    return false if include?(value)

    # Resize if we would exceed max load. Is O(n), but happens
    # infrequently.
    self.resize! if (count + 1).fdiv(buckets.length) > MAX_LOAD

    # DynamicArray push is O(1) amortized
    bucket_for(value) << value
    @count += 1

    true
  end

  # O(1) amortized
  def remove(value)
    # This takes O(1) amortized
    return unless include?(value)
    # delete is linear in the size of the bucket, but we said that was
    # supposed to be bounded by a constant. Therefore this is O(1)
    # randomized.
    bucket_for(value).delete(value)
    @count -= 1
  end

  protected
  attr_reader :buckets

  def bucket_for(value, buckets = @buckets)
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

    @buckets = new_buckets
  end
end

s = IntHashSet.new
(0...100).to_a.shuffle!.each { |el| s.insert(el) if el.odd? }
(0...100).each do |el|
  if el.odd?
    fail unless s.include?(el)
  else
    fail if s.include?(el)
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
