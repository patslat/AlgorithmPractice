class Graph
  def initialize(directed = false)
    @directed = directed
    #index of value == id of vertex
    @values = []
    @vertices = {}
    @edges = Hash.new { |hash, key| hash[key] = Array.new }
    @v_count = 0
    @e_count = 0
  end

  def add_vertex(value)
    vertex = Node.new(value, @v_count)
    @values << value
    @vertices[value] = vertex
    @v_count += 1
  end

  def add_edge(val1, val2)
    v, w = @vertices[val1], @vertices[val2]
    if directed
      add_directed_edge(v, w)
    else
      add_bidirectional_edge(v, w)
    end
  end

  def add_directed_edge(v, w)
    @edges[v] << w
    v.add_adjacent_vertex(w)
    @e_count += 1
  end
# not so good since graphs are either directed or undirected
  def add_bidirctional_edge(v, w)
    add_directed_edge(v, w)
    add_directed_edge(w, v)
  end
end

class Node
  def initialize(value, id)
    @value = value
    @id = id
    @adjacent_vertices = []
  end

  def add_adjacent_vertex(id)
    @adjacent_vertices << id
  end
end

g = Graph.new
g.add_vertex("cheese")
g.add_vertex("puffs")
g.add_vertex("snacks")

g.add_edge("cheese", "puffs")
g.add_edge("puffs", "snacks")

p g
