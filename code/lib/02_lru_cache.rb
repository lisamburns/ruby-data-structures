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

    link
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

class LRUCache
  attr_reader :hits, :misses

  def initialize(max_size, &prc)
    @links_hash, @linked_list, @max_size, @prc =
      {}, LinkedList.new, max_size, prc

    # Logging
    self.hits, self.misses = 0, 0
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.push_link(link)

      # Logging
      self.hits += 1

      return link.value
    end

    # Logging
    self.misses += 1

    if @links_hash.count == @max_size
      link = @linked_list.shift_link
      @links_hash.delete(link.value)
    end

    value = @prc.call(key)
    @links_hash[key] = @linked_list.push(value)

    value
  end

  protected
  attr_writer :hits, :misses
end

class UncachedFibber
  attr_reader :calculations

  def initialize
    self.calculations = 0
  end

  def calculate(n)
    self.calculations += 1

    return 0 if n == 0
    return 1 if n == 1
    return calculate(n - 2) + calculate(n - 1)
  end

  protected
  attr_writer :calculations
end

class CachedFibber
  attr_reader :cache

  def initialize(max_size)
    self.cache = LRUCache.new(max_size) do |n|
      calculate(n, false)
    end
  end

  def calculate(n, use_cache = true)
    if use_cache
      return cache[n]
    end

    return 0 if n == 0
    return 1 if n == 1
    return self.calculate(n - 2) + self.calculate(n - 1)
  end

  protected
  attr_writer :cache
end

def main
  uncached_fibber = UncachedFibber.new
  puts "Start of UncachedFibber: #{Time.now}"
  puts uncached_fibber.calculate(35)
  puts "End of UncachedFibber: #{Time.now}"
  puts "Number of calculations: #{uncached_fibber.calculations}"

  # Just a little cache can help a lot!
  cached_fibber = CachedFibber.new(10)
  puts "Start of CachedFibber: #{Time.now}"
  puts cached_fibber.calculate(35)
  puts "End of CachedFibber: #{Time.now}"
  puts "Cache hits: #{cached_fibber.cache.hits}"
  puts "Cache misses: #{cached_fibber.cache.misses}"
end

if $PROGRAM_NAME == __FILE__
  main
end
