# Basic link class
class Link
  attr_reader :next, :prev
  attr_accessor :value

  def initialize(value)
    self.value = value
  end

  # insert a new link to store `value` after this link.
  def insert_after(value)
    new_link = self.new_link(value)

    # insert `new_link` before `self.next`...
    new_link.next = self.next
    self.next.prev = new_link unless self.next.nil?

    # and after `self`.
    self.next = new_link
    new_link.prev = self

    new_link
  end

  # insert a new link to store `value` before this link.
  def insert_before(value)
    new_link = self.new_link(value)

    # insert `new_link` after `self.prev`...
    new_link.prev = self.prev
    self.prev.next = new_link unless self.prev.nil?

    # and before `self`.
    self.prev = new_link
    new_link.next = self

    new_link
  end

  # remove this link from the chain.
  def remove
    self.prev.next = self.next unless self.prev.nil?
    self.next.prev = self.prev unless self.next.nil?
  end

  protected
  attr_writer :next, :prev

  def new_link(value)
    self.class.new(value)
  end
end

# `Link` subclass for use by the `List` class.
class ListLink < Link
  attr_reader :list

  def initialize(value, list)
    super(value)

    self.list = list
    self.list._handle_insert(self)
  end

  def insert_after(value)
    new_link = super(value)
    self.list._handle_insert(new_link)
    new_link
  end

  def insert_before(value)
    new_link = super(value)
    self.list._handle_insert(new_link)
    new_link
  end

  def remove
    super
    list._handle_remove(self)
  end

  protected
  attr_writer :list

  def new_link(value)
    self.class.new(value, self.list)
  end
end

# A doubly ended linked list implementation.
class LinkedList
  include Enumerable

  attr_reader :back, :front

  def initialize
    self.back = nil
    self.front = nil
  end

  # Index method is `O(n)`.
  def [](idx)
    raise "hell" if idx < 0

    here = self.front
    idx.times { here = here.next }

    here
  end

  def each(&prc)
    cur = self.front
    until cur.nil?
      prc.call(cur.value)
      cur = cur.next
    end

    nil
  end

  def empty?
    self.front.nil?
  end

  def push(value)
    if self.empty?
      self.front = self.back = ListLink.new(value, self)
    else
      self.back.insert_after(value)
    end
  end

  def unshift(value)
    if self.empty?
      self.front = self.back = ListLink.new(value, self)
    else
      self.front.insert_before(value)
    end
  end

  def _handle_insert(new_link)
    if self.front.equal?(new_link.next)
      # inserted before the first link.
      self.front = new_link
    end

    if self.back.equal?(new_link.prev)
      # inserted after last link.
      self.back = new_link
    end
  end

  def _handle_remove(link)
    if self.front.equal?(link)
      # removed the first link.
      self.front = link.next
    end

    if self.back.equal?(link)
      # removed the last link.
      self.back = link.prev
    end
  end

  private
  attr_writer :back, :front
end

# TODO:
# Write implementations of:
# * Appending linked lists
# * Drop a subseq
