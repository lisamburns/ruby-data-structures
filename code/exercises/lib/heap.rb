class BinaryMinHeap
  def initialize
    @store = []
  end

  def extract
    val = @store[0]
    @store[0] = @store.pop
    heapify_down(0)
  end

  def push(val)
    @store << val
    heapify_up(@store.length - 1)
  end

  protected
  def child_indices(parent_index)
    # If `parent_index` is the parent of `child_index`:
    #
    # (1) There are `parent_index` previous nodes to
    # `parent_index`. Any children of `parent_index` needs to appear
    # after the children of all the nodes preceeding the parent.
    #
    # (2) Also, since the tree is full, every preceeding node will
    # have two children before the parent has any children. This means
    # there are `2 * parent_index` child nodes before the first child
    # of `parent_index`.
    #
    # (3) Lastly there is also the root node, which is not a child of
    # anyone. Therefore, there are a total of `2 * parent_index + 1`
    # nodes before the first child of `parent_index`.
    #
    # (4) Therefore, the children of parent live at `2 * parent_index
    # + 1` and `2 * parent_index + 2`.

    [2 * parent_index + 1, 2 * parent_index + 2]
  end

  def parent_index(child_index)
    # If child_index is odd: `child_index == 2 * parent_index + 1`
    # means `parent_index = (child_index - 1) / 2`.
    #
    # If child_index is even: `child_index == 2 * parent_index + 2`
    # means `parent_index = (child_index - 2) / 2`. Note that, because
    # of rounding, when child_index is even: `(child_index - 2) / 2 ==
    # (child_index - 1) / 2`.

    (child_index - 1) / 2
  end

  def heapify_down(parent_idx)
    l_child_idx, r_child_idx = child_indices(parent_idx)
    parent_val, l_child_val, r_child_val =
      @store[parent_idx], @store[l_child_idx], @store[r_child_idx]

    # We compact because `l_child_val`, `r_child_val` could be nil if
    # any child indices are outside the range of the store.
    heap_prop_valid = [l_child_val, r_child_val].compact.all? do |child_val|
      child_val <= parent_val
    end

    if heap_prop_valid
      # Leaf or both children_vals <= parent_val
      return
    else
      swap_idx = (r_child_val.nil? || l_child_val <= r_child_val) ?
        l_child_idx : r_child_idx

      @store[parent_idx] = @store[swap_idx]
      @store[swap_idx] = parent_val
      heapify_down(swap_idx)
    end
  end

  def heapify_up(child_idx)
    return if child_idx == 0
    parent_idx = parent_index(child_idx)
    child_val, parent_val = @store[child_idx], @store[parent_idx]
    if child_val <= parent_val
      # Heap property valid!
      return
    else
      @store[child_idx] = parent_val
      @store[parent_idx] = child_val
      heapify_up(parent_idx)
    end
  end
end
