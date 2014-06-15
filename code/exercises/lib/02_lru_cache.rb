class Link
  attr_accessor :value
  attr_reader :next, :prev

  def initialize(value)
    @value = value
  end

  # Add ourself before the link
  def insert_before(link)
    if self.next || self.prev
      raise "trying to insert a link that's not bare!"
    end

    self.prev = link.prev
    self.next = link
    link.prev = self
  end

  # Add ourself after the link
  def insert_after(link)
    if self.next || self.prev
      raise "trying to insert a link that's not bare!"
    end

    self.prev = link
    self.next = link.next
    link.next = self
  end

  def remove
    if self.prev
      self.prev.next = self.next
    end
    if self.next
      self.next.prev = self.prev
    end

    self.prev, self.next = nil, nil
  end

  protected
  attr_writer :next, :prev
end

class LinkedListLink < Link
  attr_reader :list

  def initialize(list, value)
    super(value)
    @list = list
  end

  def insert_after(link)
    list.send(:tail=, self) if link == list.tail
    super
  end

  def insert_before(link)
    list.send(:head=, self) if link == list.head
    super
  end

  def remove
    list.send(:head=, self.next) if self == list.head
    list.send(:tail=, self.prev) if self == list.tail
    super
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head, @tail = nil, nil
  end

  # O(n): don't use me!
  def [](idx)
    raise "index out of bounds" if idx < 0

    link = self.front
    idx.times do
      raise "index out of bounds" if link.nil?
      link = link.next
    end

    link
  end

  def empty?
    head.nil?
  end

  def new_link(value)
    LinkedListLink.new(self, value)
  end

  def pop
    popped_link = @tail
    popped_link.remove
    popped_link
  end

  def push(link)
    if empty?
      @head = @tail = link
    else
      link.insert_after(tail)
    end
  end

  def shift
    shifted_link = @head
    shifted_link.remove
    shifted_link
  end

  def unshift(link)
    if empty?
      @head = @tail = link
    else
      link.insert_before(@head)
    end
  end

  protected
  attr_writer :head, :tail
end

class LRUCache
  def initialize(max_size, &prc)
    @links_hash, @linked_list, @max_size, @prc =
      {}, LinkedList.new, max_size, prc
  end

  def get(key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.unshift(link)
      return link.value
    end

    if @links_hash.count == @max_size
      @linked_list.pop
    end

    value = @prc.call(key)
    link = @linked_list.new_link(value)
    @linked_list.unshift(link)

    value
  end
end
