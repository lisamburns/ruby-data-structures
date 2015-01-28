require '06a_graph'

# O(|V| + |E|).
def topological_sort(vertices)
  in_edge_counts = {}
  queue = []

  vertices.each do |v|
    in_edge_counts[v] = v.in_edges.count
    queue << v if v.in_edges.empty?
  end

  sorted_vertices = []

  until queue.empty?
    vertex = queue.shift
    result << vertex

    vertex.out_edges do |e|
      to_vertex = e.to_vertex

      in_edge_counts[to_vertex] -= 1
      queue << to_vertex if in_edge_counts[vertex] == 0
    end
  end

  sorted_vertices
end
