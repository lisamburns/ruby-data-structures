require 'byebug'
class QuickSort
  def self.partition(arr, pivot, len, &prc)
    prc ||= Proc.new {|a, b| a <=>b }
    idx = pivot + 1
    last_idx = pivot + len

    while idx < last_idx
      if prc.call(arr[idx], arr[pivot]) < 0 # double-swap in place!
        arr[idx], arr[pivot + 1] = arr[pivot + 1], arr[idx]
        arr[pivot], arr[pivot + 1] = arr[pivot + 1], arr[pivot]
        pivot = pivot + 1
      end
      idx += 1
    end
    return pivot
  end

  def self.sort2!(arr, start = 0, len = arr.length, &prc)
    return arr if len <=1
    pivot_idx = QuickSort.partition(arr, start, len, &prc)
    left_length = pivot_idx - start
    right_length = len - left_length - 1

    QuickSort.sort2!(arr, 0, left_length, &prc)
    QuickSort.sort2!(arr, pivot_idx + 1, right_length, &prc)
    return arr
  end

end
