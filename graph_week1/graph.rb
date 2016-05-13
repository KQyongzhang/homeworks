class Graph

  def initialize input_string
    @vertex = input_string.split(//).keep_if{|e| e >= 'A' and e <= 'Z'}.uniq
    @graph = Array.new(@vertex.length){Array.new(@vertex.length)}
    input_string.split(/,\s*/).each do |edge|
      edge =~ /([A-Z])([A-Z])(\d)/
      @graph[@vertex.index($1)][@vertex.index($2)] = $3.to_i
    end
    puts "vertex ==>\n" + @vertex.inspect
    # puts "graph ==> \n" + @graph.inspect
  end

  def direct_distance route
    distance = 0
    stops = route.split(//).keep_if{ |e| e >= 'A' and e <= 'Z'}
    0.upto(stops.length - 2) do |i|
      return false if weight(stops[i], stops[i+1]).nil?
      distance += weight(stops[i], stops[i+1])
    end
    return distance
  end

  # 看起来像广度优先，但是由于递归，实际是深度优先
  def dfs_find_routes current, max_degree, from='', end_vertex='C'
    routes = []
    routes << "#{from}-#{end_vertex}" if (from != '' and current == end_vertex)
    if max_degree == 1
      routes += ["#{from}-#{current}-#{end_vertex}"] if weight(current, end_vertex)
    else
      available_next_vertexs(current).each do |v|
        routes += dfs_find_routes(v, max_degree - 1, (from=='') ? "#{current}" : "#{from}-#{current}")
      end
    end
    return routes
  end

  # def dfs2_find_routes current, max_length, from='', end_vertex='C'
  #   routes = []
  #   if max_length > 0
  #     routes << "#{from}-#{end_vertex}" if (from != '' and current == end_vertex)
  #     available_next_vertexs(current).each do |v|
  #       routes += dfs_find_routes(v, max_length - weight(current, v), (from=='') ? "#{current}" : "#{from}-#{current}")
  #     end
  #   end
  #   return routes
  # end

  # 其实也是深度优先 
  def bfs_find_routes current, max_length, from='', end_vertex='C'
    routes = []
    if max_length > 0
      routes << "#{from}-#{end_vertex}" if (from != '' and current == end_vertex)
      available_next_vertexs(current).each do |v|
        routes += bfs_find_routes(v, max_length - weight(current, v), (from=='') ? "#{current}" : "#{from}-#{current}")
      end
    end
    return routes
  end

  def djikstra_shortest_route start_v, stop_v
    visited     = Array.new(@vertex.length, false)
    distance    = Array.new(@vertex.length, Float::INFINITY)
    pre_vertex  = Array.new(@vertex.length, nil)

    is_first_visit = true
    queue = [start_v]
    distance[@vertex.index(start_v)] = 0
    while queue.length != 0
      current_v = queue.delete_at(0)
      available_next_vertexs(current_v).each do |v|
        queue << v if visited[@vertex.index(v)] == false
        if distance[@vertex.index(current_v)] + weight(current_v, v) < distance[@vertex.index(v)]
          pre_vertex[@vertex.index(v)]  = current_v
          distance[@vertex.index(v)]    = distance[@vertex.index(current_v)] + weight(current_v, v)
        end
      end
      # 兼容回路问题
      if (start_v == stop_v) and (current_v == start_v) and is_first_visit
        is_first_visit = false
        distance[@vertex.index(start_v)] = Float::INFINITY
      else
        visited[@vertex.index(current_v)] = true
      end
    end
    return distance[@vertex.index(stop_v)]
  end

  def weight start, stop
    @graph[@vertex.index(start)][@vertex.index(stop)]
  end

  def available_next_vertexs vertex
    available_next_vertexs = []
    @graph[@vertex.index(vertex)].each_with_index do |v, i|
      available_next_vertexs << @vertex[i] if !v.nil?
    end
    return available_next_vertexs
  end

end

