require 'byebug'
class BinaryMinHeap
  attr_accessor :store, :idx

  def initialize(&prc)
    @store = []
    @idx = 0
  end

  def self.child_indices(len, idx)
    [2*idx + 1, 2*idx + 2].select {|i| i < len }
  end

  def self.parent_index(idx)
    raise "root has no parent" if idx == 0
    return (idx - 1)/2
  end

  def push(num)
    @store.push(num)
  end

  def extract()
    @store.shift
  end

  def self.heapify_up(arr, idx, &prc)
    prc ||= Proc.new {|a, b| a > b}
    item = arr[idx]
    return arr if idx <= 0
    parent_idx = parent_index(idx)

    parent = arr[parent_idx]
    if prc.call(parent, item)#parent > item
      arr[idx], arr[parent_idx] = arr[parent_idx], arr[idx]
      return self.heapify_up(arr, parent_index(idx), &prc)
    end
    return arr
  end

  def self.heapify_down(arr, idx, length=arr.length, &prc)
    return arr if idx >= length -1
    left_i, right_i = child_indices(length, idx)
    el = arr[idx]
    left = arr[left_i]
    right = arr[right_i]
    return arr if el < left && el < right
    if left < right
      arr[left_i], arr[idx] = arr[idx], arr[left_i]
      return heapify_down(arr, left_i, &prc)
    else
      arr[right_i], arr[idx] = arr[idx], arr[right_i]
      return heapify_down(arr, right_i, &prc)
    end

  end

  def self.swap!(arr, idx1, idx2)
    swap = arr[idx1]
    arr[idx1] = arr[]
  end

  def heapify_down
  end

end
