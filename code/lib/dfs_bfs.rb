def dfs(node, target, visited = {})
  return nil if node.nil?
  return node if node.value == target
  if !visited[node]
    visited[node] = true;
    return dfs(node.left, target, visited) || dfs(node.right, target, visited)
  end
  return nil;
end

def bfs(node, target)
  queue = []
  queue.push(node)
  until queue.empty?
    node = queue.pop
    return node if target == node.value
    queue.unshift(node.left) if node.left
    queue.unshift(node.right) if node.right
  end
  return nil
end

class BinaryNode #Not a Binary Search Tree
  attr_accessor :value, :left, :right

  def initialize(val)
    @value = val
    @left = nil
    @right = nil
  end

  def addLeftChild(node)
    self.left = node
  end

  def addRightChild(node)
    self.right = node
  end
end

a = BinaryNode.new(8)
a = BinaryNode.new(8)
b = BinaryNode.new(2)
c = BinaryNode.new(4)
e = BinaryNode.new(5)
f = BinaryNode.new(9)

a.addLeftChild(b)
a.addRightChild(c)
b.addLeftChild(e)
b.addRightChild(f)

puts dfs(a, 5).value
puts dfs(a, 100).to_s

puts bfs(a, 9).value
puts bfs(a, 150).to_s
