require '02a_link'

class LinkedList
  attr_accessor :head
  def initialize
    @head = nil
  end

  def push_link(link)
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

  def push(val)
    link = Link.new(val)
    self.push_link( link)
    return link
  end

  def pop_link
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

  def unshift_link(link)
    if self.head.nil?
      self.head = link
      return
    end
    self.head.insert_left(link)
    self.head = self.head.prev
    return link
  end

  def unshift(val)
    link = Link.new(val)
    self.unshift_link(link)
    return link
  end

  def shift_link
    link = self.head
    self.head = self.head.next
    link.remove
  end

  def shift
    shift_link.val
  end

  def [](idx)
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
