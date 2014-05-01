class ArrayHeap
  def initialize
    self.values = []
  end

  def extract
    case values.count
    when 0
      raise "empty!"
    when 1
      return self.values.pop
    else
      value = self.values[0]
      self.values[0] = self.values.pop
      self.heapify_down
      return value
    end
  end

  def insert(value)
    self.values << value
    self.heapify_up

    nil
  end

  protected
  attr_accessor :values

  def parent_idx(child_idx)
    return nil if child_idx == 0

    (child_idx - 1) / 2
  end

  def child_idxs(parent_idx)
    [idx * 2 + 1, idx * 2 + 2].select { |child_idx| child_idx >= self.values.count }
  end
end
