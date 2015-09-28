require '02a_link'

class SentinelNode < Link
  def initialize(type)
    super(type)
  end

end

class LinkedList # A class that does NOT use sentinel nodes, hence O(n) push and pop
  attr_accessor :first, :last

  def initialize
    @first = SentinelNode.new(:first) # points to first
    @last = SentinelNode.new(:last) # points to last
    @first.insert_right(@last)
  end

  def empty?
    @first.next == @last
  end

  def push_link(link) # O(1) operation
    self.last.insert_left(link)
    return link
  end

  def push(val) # O(1)
    self.push_link( Link.new(val))
  end

  def pop_link #O(1)
    raise "can't pop from empty link" if self.empty?
    link = self.last.prev
    link.remove
  end

  def pop
    pop_link.val
  end

  def unshift_link(link) #O(1)
    self.first.insert_right(link)
  end

  def unshift(val) #O(1)
    self.unshift_link(Link.new(val))
  end

  def shift_link #O(1)
    link = self.first.next
    link.remove
  end

  def shift
    shift_link.val
  end

  def [](idx) #O(n)
    i = 0
    curr_link = @first.next
    while i < idx
       raise 'index out of bounds' if curr_link.next == self.last
       curr_link = curr_link.next
       i += 1
    end
    curr_link
  end

end


class LinkedListBasic # A class that does NOT use sentinel nodes, hence O(n) push and pop
  attr_accessor :head
  def initialize
    @head = nil
  end

  def push_link(link) # O(n) operation
    if @head.nil?
      self.head = link
      return
    end

    curr_link = @head
    until curr_link.next.nil?
      curr_link = curr_link.next
    end
    curr_link.insert_right(link)
  end

  def push(val) # O(n)
    link = Link.new(val)
    self.push_link( link)
    return link
  end

  def pop_link #O(n)
    curr = self.head
    until curr.next.nil?
      curr = curr.next
    end
    curr.remove
    return curr
  end

  def pop
    pop_link.val
  end

  def unshift_link(link) #O(1)
    if self.head.nil?
      self.head = link
      return
    end
    self.head.insert_left(link)
    self.head = self.head.prev
    return link
  end

  def unshift(val) #O(1)
    link = Link.new(val)
    self.unshift_link(link)
    return link
  end

  def shift_link #O(1)
    link = self.head
    self.head = self.head.next
    link.remove
  end

  def shift
    shift_link.val
  end

  def [](idx) #O(n)
    i = 0
    curr_link = @head
    while i < idx
       curr_link = curr_link.next
       raise 'index out of bounds' if curr_link.nil?
       i += 1
    end
    curr_link
  end

end
