class StaticArray
  def initialize(length)
    @store = Array.new(length, nil)
  end

  # O(1)
  def [](index)
    return @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end
end

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds!" unless (length > 0)

    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity

    # Add to @length to pass length check in `#[]=`.
    @length += 1
    self[length - 1] = val

    nil
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds!" if (length == 0)

    val = self[0]
    (1...length).each { |i| self[i - 1] = self[i] }
    @length -= 1

    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity

    @length += 1
    (length - 2).downto(0).each { |i| self[i + 1] = self[i] }
    self[0] = val

    nil
  end

  protected
  attr_reader :capacity

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds!"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    @capacity = new_capacity
    @store = new_store
  end
end

darr = DynamicArray.new
100.times { |i| darr.push(i) }
arr = []
while darr.length > 0
  arr << darr.pop
end
fail unless arr == (0...100).to_a.reverse!

darr = DynamicArray.new
100.times { |i| darr.unshift(i) }
arr = []
while darr.length > 0
  arr << darr.shift
end
fail unless arr == (0...100).to_a.reverse!

class CircularBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds!" if (length == 0)

    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  # O(1) ammortized
  def push(val)
    resize! if (length == capacity)

    @length += 1
    self[length - 1] = val

    nil
  end

  # O(1)
  def shift
    raise "index out of bounds!" if (length == 0)

    val, self[0] = self[0], nil
    @start_idx = (@start_idx + 1) % capacity
    @length -= 1

    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if (length == capacity)

    @start_idx = (@start_idx - 1) % capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_reader :capacity

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds!"
    end
  end

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    @capacity = new_capacity
    @store = new_store
    @start_idx = 0
  end
end

carr = CircularBuffer.new
100.times { |i| carr.push(i) }
arr = []
while carr.length > 0
  arr << carr.pop
end
fail unless arr == (0...100).to_a.reverse!

carr = CircularBuffer.new
100.times { |i| carr.unshift(i) }
arr = []
while carr.length > 0
  arr << carr.shift
end
fail unless arr == (0...100).to_a.reverse!
