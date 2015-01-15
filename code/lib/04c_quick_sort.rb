class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?

    pivot = array[0]

    left = array.select { |el| pivot > el }
    middle = array.select { |el| pivot == el }
    right = array.select { |el| pivot < el }

    sort1(left) + middle + sort1(right)
  end

  # In-place. Uses O(log(n)) space for recursion.
  def self.sort2!(array, start = 0, length = array.length)
    return array if length < 2

    pivot_idx = partition(array, start, length)

    sort2!(array, start, pivot_idx - start)
    sort2!(array, pivot_idx + 1, length - (pivot_idx + 1))

    array
  end

  def self.partition(array, start, length)
    pivot_idx, pivot = start, array[start]
    ((start + 1)...(start + length)).each do |idx|
      val = array[idx]
      if (val >= pivot)
        # bigger than pivot, leave where it is.
      else
        # Three-way shuffle: pivot_idx + 1 => idx, pivot_idx =>
        # pivot_idx + 1, idx => pivot_idx.

        # move self[pivot_idx + 1] to idx, which keeps this bigger item
        # to the right of the pivot.
        array[idx] = array[pivot_idx + 1]
        # move the pivot forward one, to where the larger item used to live.
        array[pivot_idx + 1] = pivot
        # move the smaller item to one to the left of the pivot.
        array[pivot_idx] = val

        pivot_idx += 1
      end
    end

    pivot_idx
  end
end

fail unless QuickSort.sort1([5, 3, 4, 2, 1, 6]) == [1, 2, 3, 4, 5, 6]
fail unless QuickSort.sort2!([5, 3, 4, 2, 1, 6]) == [1, 2, 3, 4, 5, 6]
