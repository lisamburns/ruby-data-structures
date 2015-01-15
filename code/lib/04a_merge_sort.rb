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
