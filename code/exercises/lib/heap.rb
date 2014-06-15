class BinaryFullHeap
  def initialize
    @store = []
  end

  def extract
    val = @store[0]
    @store[0] = @store.pop
    heapify_down
  end

  def push(val)
    @store << val
    heapify_up
  end

  protected
end
