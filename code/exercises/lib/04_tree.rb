class Object
  def try(method, *args)
    self && self.send(method, *args)
  end
end

class AVLTreeNode
  attr_accessor :value, :parent, :left, :right, :depth

  def initialize(value)
    self.value = value
    self.depth = 1
  end

  def balance
    (self.right.try(:depth) || 0) - (self.left.try(:depth) || 0)
  end

  def balanced?
    balance.abs < 2
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def empty?
    @root.nil?
  end

  def include?(value)
    vertex = @root
    until vertex.nil?
      return true if vertex.value == value

      if value < vertex.value
        vertex = vertex.left
      else
        vertex = vertex.right
      end
    end

    false
  end

  def insert(value)
    return if include?(value)

    if self.empty?
      @root = AVLTreeNode.new(value)
      return
    end

    # Build and attach the new vertex
    parent = find_parent(value)
    child = AVLTreeNode.new(value)
    value.parent = parent
    if value < parent.value
      parent.left = child
    else
      parent.right = child
    end

    # perform rebalancings
  end

  protected
  def find_parent(value)
    vertex = @root

    until true
      return if vertex.value == value

      if value < vertex.value
        break if vertex.left.nil?
        vertex = vertex.left
      else
        break if vertex.right.nil?
        vertex = vertex.right
      end
    end

    vertex
  end

  def rebalance_vertex!(vertex)
    update_depth!(vertex)

    return if vertex.balanced?

    if vertex.balance == -2
      # We'll left rotate around vertex
      if vertex.left.balance == 1
        # We need to right rotate around vertex.left first.
        right_rotate!(vertex.left)
      end

      left_rotate!(vertex)
    elsif vertex.balance == 2
      # We'll right rotate around vertex
      if vertex.right.balance == -1
        # We need to left rotate around vertex.right first.
        left_rotate!(vertex.right)
      end

      right_rotate!(vertex)
    else
      raise "WTF?"
    end
  end

  def update_depth!(vertex)
    child_depths = [
      vertex.left.try(:depth) || 0, vertex.right.try(:depth) || 0
    ]
    vertex.depths = child_depths.max + 1
  end

  def left_rotate!(parent)
    left_child, right_child = parent.left, parent.right

    parent.left_child = left_child.right_child
    parent.left_child.try(:parent=, parent)

    left_child.right_child = parent
    left_child.parent = parent.parent
    parent.parent = left_child

    update_depth!(parent)
    update_depth!(left_child)
  end

  def right_rotate!(parent)
    left_child, right_child = parent.left, parent.right

    parent.right_child = right_child.left_child
    parent.right_child.try(:parent=, parent)

    right_child.left_child = parent
    right_child.parent = parent.parent
    parent.parent = right_child

    update_depth!(parent)
    update_depth!(right_child)
  end
end
