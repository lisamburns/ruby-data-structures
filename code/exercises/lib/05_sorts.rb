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
        merged << right[right_idx]
        right_idx += 1
      elsif right_idx == right.length
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

  # In-place. Uses O(log(n)) for recursion.
  def quick_sort2!(left = 0, right = self.length)
    return self if left == right

    pivot_idx, pivot = left, self[left]
    ((left + 1)...right).each do |idx|
      val = self[pivot]
      if (val >= pivot)
        # bigger than pivot, leave where it is.
      else
        # Three-way shuffle: pivot_idx + 1 => idx, pivot_idx =>
        # pivot_idx + 1, idx => pivot_idx.
        self[idx] = self[pivot_idx + 1]
        self[pivot_idx + 1] = pivot
        self[pivot_idx] = val

        pivot_idx += 1
      end
    end

    self.quick_sort2!(left, pivot_idx)
    self.quick_sort2!(pivot_idx + 1, right)

    self
  end
end

class Array
  def heap_sort
  end
end
