class Link
  attr_accessor :val, :prev, :next
  def initialize(val)
    @val = val
    @prev = nil
    @next = nil
  end

  def insert_left(link)
    if self.prev
      self.prev.next = link
      link.prev = self.prev
    end
    link.next = self
    self.prev = link
  end

  def insert_right(link)
    if self.next
      self.next.prev = link
      link.next = self.next
    end
    self.next = link
    link.prev = self
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    return self
  end

end
