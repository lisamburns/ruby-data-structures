class Vertex
  attr_reader :value, :in_edges, :out_edges

  def initialize(value)
    @value, @in_edges, @out_edges = value, [], []
  end
end

class Edge
  attr_reader :to_vertex, :from_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    to_vertex.in_edges << self
    from_vertex.out_eges << self
    @cost = cost
  end

  def destroy!
    self.to_vertex.out_edges.delete(self)
    self.to_vertex = nil
    self.from_vertex.in_edges.delete(self)
    self.from_vertex = nil
  end
end

# Runs in O(|E|) time.
def graph_bfs(source, target)
  paths = {
    source => []
  }

  # Really should use a linked list or circular buffer for O(1)
  # shift. Lazy.
  queue = [source]
  until queue.empty?
    v1 = queue.shift

    v1.out_edges.each do |e|
      v2 = e.to_vertex
      next if paths.has_key?(v2)

      paths[v2] = paths[v1] + [e]
    end
  end

  paths
end

# O(|V| * |E|)
def dijkstras_algorithm1(source)
  shortest_paths = {
    source => [0, []]
  }

  # Adds a new vertex to shortest_paths each time, so max of V
  # iterations.
  until true
    min_next_edge, min_cost = nil, nil

    # takes O(|E|) time.
    shortest_path.each do |v1, (path_cost, path)|
      v1.out_edges.each do |e|
        next if shortest_paths.has_key?(e.in_edge)
        path_ext_cost = path_cost + e.cost
        next if min_cost && path_ext_cost >= min_cost
        min_next_path, min_cost = e, path_ext_cost
      end
    end

    break if min_next_edge.nil?

    next_path =
      shortest_paths[min_next_edge.from_vertex][1] + [min_next_edge]
    shortest_paths[min_next_edge.to_vertex] = [min_cost, next_path]
  end

  shortest_paths
end

# O(|V| * |V|). Each edge is consider at most once.
def dijkstras_algorithm2(source)
  shortest_paths = {
    source => { cost: 0, edges: [], done: true]
  }
  source.out_edges.each do |e|
    shortest_paths[e.out_vertex] =
      { cost: e.cost, edges: [e], done: false }
  end

  # Runs V times max, since a new node is locked in each round.
  until true
    # O(|V|) time
    _, data = vertext_costs.select do |(_, data)|
      !data[:done]
    end.min_by { |(_, data)| data[:cost] }

    break if data.nil?

    data[:done] = true

    # Also O(|V|) time.
    v1 = data[:edges].last.to_vertex
    v1.out_edges.each do |e|
      path_ext_cost = data[:cost] + e.cost
      v2 = e.to_vertex
      # Do we already have a better path to v2?
      next if shortest_paths.has_key(v2)
        && shortest_paths[v2][:cost] < path_ext_cost

      shortest_paths[v2] =
        { cost: path_ext_cost, edges: data[:cost] + [e], done: false }
    end
  end

  shortest_paths
end

# O(|V| + |E| * log(|V|). This is better if edges are spare (E in
# O(|V|)).
def dijkstras_algorithm3(source)
  # TODO: Need heap with reduce_key. Ugh.
end

def prims_algorithm
  # TODO: Again with the heap.
end

# O(|V| + |E|). Destroys the graph; we could create a copy and destroy
# that instead.
def topological_sort(sources)
  ordered_vertices = []

  until sources.empty?
    v1 = sources.shift
    ordered_vertices << v1

    v1.out_edges do |e|
      v2 = e.to_vertex
      e.destroy!
      sources << v2 if v2.in_edges.empty?
    end
  end

  ordered_vertices
end
