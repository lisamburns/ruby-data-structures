# This is a basic link class.
class Link
  attr_accessor :value
  attr_reader :next, :prev

  def initialize(value)
    self.value = value
  end

  # Add the link before us
  def insert_left(link)
    unless link.is_detached?
      raise "trying to insert a link that's not detached!"
    end

    link.next = self
    link.prev = self.prev
    self.prev.next = link if self.prev
    self.prev = link

    nil
  end

  # Add the link after us
  def insert_right(link)
    unless link.is_detached?
      raise "trying to insert a link that's not detached!"
    end

    link.prev = self
    link.next = self.next
    self.next.prev = link if self.next
    self.next = link

    nil
  end

  def is_detached?
    !(self.next || self.prev)
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
    self.side = side
  end

  def prev=(link)
    if side == :last
      return super(link)
    elsif link.nil?
      # the first sentinel may allow superfluous set of prev to `nil`.
    else
      raise "can't set prev of first sentinel"
    end
  end

  def next=(link)
    if side == :first
      return super(link)
    elsif link.nil?
      # the last sentinel may allow superfluous set of next to `nil`.
    else
      raise "can't set prev of last sentinel"
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

  protected
  attr_accessor :side
end

class LinkedList
  def initialize
    self.first = SentinelLink.new(:first)
    self.last = SentinelLink.new(:last)

    self.first.insert_right(self.last)
  end

  # O(n): don't use me!
  def [](idx)
    raise "index out of bounds" if idx < 0

    link = first
    (idx + 1).times do
      link = link.next

      # We overran the list if we ever hit the sentinel.
      raise "index out of bounds" if link == last
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

  protected
  attr_accessor :first, :last
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
  attr_reader :cache_hits, :cache_misses

  def initialize(max_size, &prc)
    @links_hash, @linked_list, @max_size, @prc =
      {}, LinkedList.new, max_size, prc

    # Logging
    @cache_hits, @cache_misses = 0, 0
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.push_link(link)

      # Logging
      @cache_hits += 1

      return link.value
    end

    # Logging
    @cache_misses += 1

    if @links_hash.count == @max_size
      link = @linked_list.shift
      @links_hash.delete(link.key)
    end

    value = @prc.call(key)
    @links_hash[key] = @linked_list.push(value)

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

class CachedFibber < LRUCache
  def initialize(max_size)
    super(max_size) do |n|
      next 0 if n == 0
      next 1 if n == 1
      next self[n - 2] + self[n - 1]
    end
  end

  def calculate(n)
    self[n]
  end
end

p "Start of fib2: #{Time.now}"
$fibber = CachedFibber.new(10)
$fibber.calculate(36)
p "End of fib2: #{Time.now}"
p "Cache hits: #{$fibber.cache_hits}"
p "Cache misses: #{$fibber.cache_misses}"
