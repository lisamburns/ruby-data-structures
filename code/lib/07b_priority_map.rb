require_relative '07a_heap2'

class KVPair
  attr_accessor :key, :value

  def initialize(key, value)
    self.key, self.value = key, value
  end
end

class PriorityMap
  def initialize(&prc)
    self.map = {}
    self.queue = BinaryMinHeap.new do |kvpair1, kvpair2|
      prc.call(kvpair1.value, kvpair2.value)
    end
  end

  def [](key)
    return nil unless self.map.has_key?(key)
    self.map[key].value
  end

  def insert(key, value)
    kv_pair = KVPair.new(key, value)
    self.map[key] = kv_pair
    self.queue.push(kv_pair)

    nil
  end

  def extract
    kv_pair = self.queue.extract
    self.map.delete(kv_pair.value)

    [kv_pair.key, kv_pair.value]
  end

  def update(key, new_value)
    kv_pair = self.map[key]
    kv_pair.value = new_value

    self.queue.reduce!(kv_pair)
  end

  protected
  attr_accessor :map, :queue
end

# TESTING

def main
  pm = PriorityMap.new { |value1, value2| value1 <=> value2 }
  pm.insert("A", 10)
  pm.insert("B", 15)
  pm.update("B", 5)

  p pm
end

main if __FILE__ == $PROGRAM_NAME
