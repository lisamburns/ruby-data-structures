require '06a_graph'

# Runs in O(|E|) time.
def graph_bfs(source)
  last_edges = {
    source => nil
  }

  queue = [source]
  until queue.empty?
    vertex = queue.shift

    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex
      next if last_edges.has_key?(to_vertex)

      last_edges[to_vertex] = e
    end
  end

  last_edges
end
