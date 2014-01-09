class HashSet
  DEFAULT_SIZE = 10
  MAX_LOAD = 0.75

  def initialize
    self.buckets = Array.new(DEFAULT_SIZE) { [] }
    self.num_elements = 0
  end

  def include?(item)
    # go to the correct bucket, then iterate through the items.
    self.bucket_for(item).include?(item)
  end

  def insert(item)
    return false if self.include?(item)

    # keep average bucket size < 0.75
    self.resize_buckets if self.at_max_load?

    self.bucket_for(item) << item
    self.num_elements += 1

    true
  end

  def remove(item)
    return false unless self.include?(item)

    self.bucket_for(item).delete(item)
    self.num_elements -= 1

    true
  end

  protected
  attr_accessor :buckets
  attr_accessor :num_elements

  def at_max_load?
    self.num_elements >= (MAX_LOAD * self.buckets.count)
  end

  def bucket_for(item, buckets = self.buckets)
    buckets[self.hash(item) % buckets.count]
  end

  def hash(item)
    item.hash
  end

  def resize_buckets
    new_buckets = Array.new(self.buckets.count * 2) { [] }

    self.buckets.each do |bucket|
      bucket.each do |item|
        bucket_for(item, new_buckets) << item
      end
    end

    self.buckets = new_buckets
  end
end
