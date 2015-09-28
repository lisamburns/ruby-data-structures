require 'byebug'
class BinaryMinHeap
  attr_accessor :store, :idx, :prc

  def initialize(&prc)
    @store = []
    @idx = 0
    @prc ||= Proc.new { |a, b| a <=> b }
  end

  def self.child_indices(len, idx)
    [2*idx + 1, 2*idx + 2].select {|i| i < len }
  end

  def peek
    self.store[0]
  end

  def self.parent_index(idx)
    raise "root has no parent" if idx == 0
    return (idx - 1)/2
  end

  def push(num)
    self.store.push(num)
    self.store = BinaryMinHeap.heapify_up(self.store, self.idx, &self.prc)
    self.idx += 1
  end

  def extract()
    raise "nothing to extract " if self.store.length <= 0
    return self.store.pop if self.store.length == 1

    value = self.store[0]
    self.store[0] = self.store.pop
    self.store = BinaryMinHeap.heapify_down(self.store, 0, self.store.length, &self.prc)
    return value
  end

  def self.heapify_up(arr, idx, &prc)
    prc ||= Proc.new {|a, b| a <=> b}
    item = arr[idx]
    return arr if idx <= 0
    parent_idx = parent_index(idx)

    parent = arr[parent_idx]
    if prc.call(parent, item) > 0#parent > item
      arr[idx], arr[parent_idx] = arr[parent_idx], arr[idx]
      return self.heapify_up(arr, parent_index(idx), &prc)
    end
    return arr
  end

  def self.heapify_down(arr, idx, length=arr.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b }
    return arr if idx >= length -1
    children = {}
    indices = child_indices(length, idx)
    indices.each {|idx| children[idx] = arr[idx] }
    el = arr[idx]
    return arr if children.none? {|idx, child| prc.call(child, el) < 0 } # Return array if no children < element
    if indices.count == 1
      swap_i = indices[0]
    else # Swap with the smaller of the two elements.
      left = indices[0]
      right = indices[1]
      swap_i = ( prc.call(children[left], children[right]) < 0) ? left : right
    end

    arr[swap_i], arr[idx] = arr[idx], arr[swap_i]
    return heapify_down(arr, swap_i, &prc)
  end

end
