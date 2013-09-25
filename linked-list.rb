# Basic link class
class Link
  attr_reader :next, :prev
  attr_accessor :value

  def initialize(options)
    self.next = options[:next]
    self.prev = options[:prev]
    self.value = options[:value]

    if self.prev
      self.prev.next = self
    end
    if self.next
      self.next.prev = self
    end
  end

  def insert(value)
    Link.new(
      :next => self.next,
      :prev => self,
      :value => value
    )
  end

  def remove
    if self.prev
      self.prev.next = self.next
    end

    if self.next
      self.next.prev = self.prev
    end
  end

  protected
  attr_writer :next, :prev
end

# Link subclass for use in a list
class ListLink < Link
  attr_reader :list

  def initialize(options)
    super(options)
    self.list = options[:list]
  end

  def insert(value)
    new_link = ListLink.new(
      :list => self.list,
      :next => self.next,
      :prev => self,
      :value => value
    )

    list.handle_insert(new_link)

    new_link
  end

  def remove
    super

    list.handle_remove(self)
  end

  protected
  attr_writer :list
end

# A linked list implementation
class LinkedList
  attr_reader :back, :front

  def initialize
    @back = nil
    @front = nil
  end

  def [](idx)
    raise "hell" if idx < 0

    here = @front
    idx.times { here = here.next }

    here
  end

  def append(value)
    if @back
      @back.insert(value)
    else
      @front = @back = LinkedList.new(
        :list => self, :value => value
      )
    end
  end

  def handle_insert(link)
    if @back.equal?(link)
      @back = link
    end
  end

  def handle_remove(link)
    if @front.equal?(link)
      @front = link.next
    end
    if @back.equal?(link)
      @back = link.prev
    end
  end
end
