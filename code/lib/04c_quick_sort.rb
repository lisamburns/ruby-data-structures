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
