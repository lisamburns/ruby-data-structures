class TreeNode
  attr_reader :parent, :left, :right
  attr_accessor :value

  def initialize(value)
    self.value = value
  end

  def left=(node)
    assign_child(node, :left)
  end

  def right=(node)
    assign_child(node, :right)
  end

  protected
  attr_accessor :side, :parent, :value

  def assign_child(node, side)
    if node && node.parent
      # detach node from previous parent
      node.parent.send("#{node.side}=", nil)
    end

    if old_child = self.send(side)
      # detach existing child (if it exists)
      old_child.parent = nil
      old_child.side = nil
    end

    self.set_instance_variable("@#{side}", node)
    if node
      node.parent = self
      node.side = side
    end

    nil
  end
end
