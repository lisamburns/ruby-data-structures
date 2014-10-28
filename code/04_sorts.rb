require_relative '03_heap'

class Array
  # Uses O(n) memory. Always takes O(nlogn) time.
  def merge_sort
    return self.dup if self.length < 2

    left_size = self.length / 2
    merge(
      self.take(left_size).merge_sort,
      self.drop(left_size).merge_sort
    )
  end

  protected
  def merge(left, right)
    merged = []

    # Note how I carefully avoid shifting out of left or right. That's
    # an O(n) operation and doing it n times would make merge O(n**2).
    left_idx, right_idx = 0, 0
    until (left_idx == left.length) && (right_idx == right.length)
      if (left_idx == left.length)
        # used everything on the left; only stuff on the right remains
        merged << right[right_idx]
        right_idx += 1
      elsif right_idx == right.length
        # used everything on the right; only stuff on the left remains
        merged << left[left_idx]
        left_idx += 1
      elsif left[left_idx] <= right[right_idx]
        merged << left[left_idx]
        left_idx += 1
      else
        merged << right[right_idx]
        right_idx += 1
      end
    end

    merged
  end
end

fail unless [5, 3, 4, 2, 1, 6].merge_sort == [1, 2, 3, 4, 5, 6]

class Array
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def quick_sort1
    return self if self.empty?

    pivot = self[0]

    left = self.select { |el| pivot > el }
    middle = self.select { |el| pivot == el }
    right = self.select { |el| pivot < el }

    (left.quick_sort1) + middle + (right.quick_sort1)
  end

  # In-place. Uses O(log(n)) space for recursion.
  def quick_sort2!(left = 0, right = self.length)
    return self if left == right

    pivot_idx, pivot = left, self[left]
    ((left + 1)...right).each do |idx|
      val = self[idx]
      if (val >= pivot)
        # bigger than pivot, leave where it is.
      else
        # Three-way shuffle: pivot_idx + 1 => idx, pivot_idx =>
        # pivot_idx + 1, idx => pivot_idx.

        # move self[pivot_idx + 1] to idx, which keeps this bigger item
        # to the right of the pivot.
        self[idx] = self[pivot_idx + 1]
        # move the pivot forward one, to where the larger item used to live.
        self[pivot_idx + 1] = pivot
        # move the smaller item to one to the left of the pivot.
        self[pivot_idx] = val

        pivot_idx += 1
      end
    end

    self.quick_sort2!(left, pivot_idx)
    self.quick_sort2!(pivot_idx + 1, right)

    self
  end
end

fail unless [5, 3, 4, 2, 1, 6].quick_sort1 == [1, 2, 3, 4, 5, 6]
fail unless [5, 3, 4, 2, 1, 6].quick_sort2! == [1, 2, 3, 4, 5, 6]

class HeapSorter < BinaryMinHeap
  attr_reader :count

  def initialize(array)
    @store = array
    @count = 0
  end

  def run
    @store.length.times { self.push }
    @store.length.times { self.pop }
  end

  protected
  def push
    @count += 1
    heapify_up(count - 1)
  end

  def pop
    popped_value = @store[0]
    @store[0] = @store[self.count - 1]
    @count -= 1
    heapify_down(0)

    @store[self.count] = popped_value
  end
end

class Array
  def heap_sort!
    HeapSorter.new(self).run
    self.reverse!
  end
end
