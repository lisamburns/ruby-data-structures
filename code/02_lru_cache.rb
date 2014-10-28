# This is a basic link class.
class Link
  attr_accessor :value
  attr_reader :next, :prev

  def initialize(value)
    @value = value
  end

  # Add the link before us
  def insert_left(link)
    if link.next || link.prev
      raise "trying to insert a link that's not bare!"
    end

    link.next = self
    link.prev = self.prev
    self.prev.next = link if self.prev
    self.prev = link

    nil
  end

  # Add the link after us
  def insert_right(link)
    if link.next || link.prev
      raise "trying to insert a link that's not bare!"
    end

    link.prev = self
    link.next = self.next
    self.next.prev = link if self.next
    self.next = link

    nil
  end

  def remove
    self.prev.next, self.next.prev = self.next, self.prev
    self.prev, self.next = nil, nil
  end

  protected
  attr_writer :next, :prev
end

# A SentinelLink class helps us manage a list. A linked list will
# always include at least two links: the first and last
# sentinels. They're dummy objects.
class SentinelLink < Link
  def initialize(side)
    raise "incorrect side choice" unless [:first, :last].include?(side)
    @side = side
  end

  def prev=(link)
    if @side == :last
      return super(link)
    elsif link.nil?
      # always keep the prev of the first sentinel nil
    else
      raise "can't set prev of left sentinel"
    end
  end

  def next=(link)
    if @side == :first
      return super(link)
    elsif link.nil?
      # always keep the next of the last sentinel nil
    else
      raise "can't set prev of left sentinel"
    end
  end

  def value
    raise "Sentinels don't have values!"
  end

  def value=(link)
    raise "Sentinels don't have values!"
  end

  def remove
    raise "Can't remove a sentinel!"
  end
end

class LinkedList
  attr_reader :first, :last

  def initialize
    @first = SentinelLink.new(:first)
    @last = SentinelLink.new(:last)

    @first.insert_right(@last)
  end

  # O(n): don't use me!
  def [](idx)
    raise "index out of bounds" if idx < 0

    link = first.next
    idx.times do
      # We overran the list if we ever hit the sentinel.
      raise "index out of bounds" if link == last
      link = link.next
    end

    link.value
  end

  def empty?
    # Nothing between the sentinels
    first.next == last
  end

  def pop
    pop_link.value
  end

  def pop_link
    raise "can't pop from empty list!" if empty?

    link = last.prev
    link.remove
    link
  end

  def push(value)
    push_link(Link.new(value))
  end

  def push_link(link)
    last.insert_left(link)
    link
  end

  def shift
    shift_link.value
  end

  def shift_link
    raise "can't pop from empty list!" if empty?

    link = first.next
    link.remove
    link
  end

  def unshift(value)
    unshift_link(Link.new(value))
  end

  def unshift_link(link)
    first.insert_right(link)
    link
  end
end

FIBS = [0, 1, 1, 2, 3, 5]
ll = LinkedList.new
FIBS.each { |num| ll.push(num) }
arr = []
6.times { arr << ll.shift }
raise "hell" unless arr == FIBS

ll = LinkedList.new
FIBS.each { |num| ll.unshift(num) }
arr = []
6.times { arr << ll.pop }
raise "hell" unless arr == FIBS

class LRUCache
  def initialize(max_size, &prc)
    @links_hash, @linked_list, @max_size, @prc =
      {}, LinkedList.new, max_size, prc
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.push_link(link)
      return link.value
    end

    p "NOT CACHED"

    if @links_hash.count == @max_size
      @linked_list.shift
    end

    value = @prc.call(key)
    @links_hash[key] = @linked_list.unshift(value)

    value
  end
end

def fib1(n)
  return 0 if n == 0
  return 1 if n == 1
  return fib1(n - 2) + fib1(n - 1)
end

p "Start of fib1: #{Time.now}"
p fib1(36)
p "End of fib1: #{Time.now}"

@cache = LRUCache.new(10) do |n|
  next 0 if n == 0
  next 1 if n == 1
  next @cache[n - 2] + @cache[n - 1]
end

def fib2(n)
  @cache[n]
end

p "Start of fib2: #{Time.now}"
p fib2(36)
p "End of fib2: #{Time.now}"
