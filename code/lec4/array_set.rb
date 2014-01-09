class ArraySet
  def initialize
    self.store = []
  end

  def include?(target_item)
    # Using each to emphasize O(n) time complexity.
    self.store.each do |item|
      return true if item == target_item
    end

    false
  end

  # return true if item is added
  def insert(item)
    return false if self.include?(item)

    self.store << item
    true
  end

  # return true if item was present
  def remove(target_item)
    # again iterating to emphasize O(n) time complexity.
    self.store.each_with_index do |item, idx|
      next unless item == target_item

      self.store.delete_at(idx)
      return true
    end

    false
  end

  protected
  attr_accessor :store
end
