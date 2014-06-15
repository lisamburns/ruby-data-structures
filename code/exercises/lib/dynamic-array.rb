class StaticArray
  def initialize(length)
    @store = Array.new(length, nil)
  end

  def [](index)
    return @store[index]
  end

  def []=(index, value)
    @store[index] = value
  end

  def length
    @store.length
  end
end

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
  end

  def [](index)
    check_index
    @store[index]
  end

  def []=(index, value)
    check_index
    @store[index] = value
  end

  def pop(index)
    raise "index out of bounds!" unless (length > 0)

    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  def push(val)
    resize if length == store_size

    # Add to @length to pass length check in `#[]=`.
    @length += 1
    self[length] = val

    nil
  end

  def shift
    raise "index out of bounds!" if (length == 0)

    val = self[0]
    (1...length) { |i| self[i - 1] = self[i] }
    @length -= 1

    val
  end

  def unshift(val)
    resize if length == store_size

    @length += 1
    (0...length) { |i| self[i + 1] = self[i] }
    self[0] = val
  end

  protected
  def check_index(index)
    unless (index >= 0) && (index < self.length)
      raise "index out of bounds!"
    end
  end

  def resize
    new_store = StaticArray.new(store_size * 2)
    length.times { |i| new_store[i] = @store[i] }
    @store = new_store
  end

  def store_size
    @store.length
  end
end

class CircularBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @start_idx = 0
    @length = 0
  end

  def [](index)
    check_index(index)
    @store[(@start_idx + index) % store_size]
  end

  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % store_size] = val
  end

  def pop
    raise "index out of bounds!" if (length == 0)

    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  def push(val)
    resize if (length == store_size)

    @length += 1
    self[length] = val
  end

  def shift
    raise "index out of bounds!" if (length == 0)

    val, self[0] = self[0], nil
    @start_idx = (@start_idx + 1) % store_size

    val
  end

  def unshift(val)
    resize if (length == store_size)

    @start_idx = (@start_idx - 1) % store_size
    self[0] = val
  end

  protected
  def check_index(index)
    unless (index >= 0) && (index < self.length)
      raise "index out of bounds!"
    end
  end

  def store_size
    @store.length
  end
end
