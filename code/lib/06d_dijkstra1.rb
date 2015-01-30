require_relative '06a_graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  locked_in_paths = {}
  possible_paths = {
    source => { cost: 0, last_edge: nil }
  }

  # Runs |V| times max, since a new node is "locked in" each round.
  until possible_paths.empty?
    vertex = select_possible_path(possible_paths)

    locked_in_paths[vertex] = possible_paths[vertex]
    possible_paths.delete(vertex)

    update_possible_paths(vertex, locked_in_paths, possible_paths)
  end

  locked_in_paths
end

# O(|V|) time, as `possible_paths` has as many as |V| entries.
def select_possible_path(possible_paths)
  vertex, data = possible_paths.min_by do |(vertex, data)|
    data[:cost]
  end

  vertex
end

def update_possible_paths(vertex, locked_in_paths, possible_paths)
  path_to_vertex_cost = locked_in_paths[vertex][:cost]

  # We'll run this |E| times overall.
  vertex.out_edges.each do |e|
    to_vertex = e.to_vertex

    # Already locked in a best path for this
    next if locked_in_paths.has_key?(to_vertex)

    extended_path_cost = path_to_vertex_cost + e.cost
    next if possible_paths.has_key?(to_vertex) &&
            possible_paths[to_vertex][:cost] <= extended_path_cost

    # We found a better path to `to_vertex`!
    possible_paths[to_vertex] = {
      cost: extended_path_cost,
      last_edge: e
    }
  end
end

def main
  v1 = Vertex.new("A")
  v2 = Vertex.new("B")
  v3 = Vertex.new("C")
  v4 = Vertex.new("D")

  Edge.new(v1, v2, 10)
  Edge.new(v1, v3, 5)
  Edge.new(v3, v2, 3)
  Edge.new(v1, v4, 9)
  Edge.new(v3, v4, 2)

  output = dijkstra1(v1).map do |v, data|
    [v.value, data[:cost]]
  end

  p output
end

main if __FILE__ == $PROGRAM_NAME
