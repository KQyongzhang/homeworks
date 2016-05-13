$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'graph'

input_string = 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'

graph = Graph.new(input_string)

# problem 1-5
puts 'problem 1-5:'
routes = %w{
  A-B-C
  A-D
  A-D-C
  A-E-B-C-D
  A-E-D
}.each do |route|
  if d = graph.direct_distance(route)
    puts "\tdistance: #{d} for #{route}"
  else
    puts "\tNO SUCH ROUTE for #{route}"
  end
end

# problem 6
puts 'problem 6: '
c2c_routes = graph.dfs_find_routes('C', 3)
puts c2c_routes.count

# problem 7
puts 'problem 7: '
a2c_routes = graph.dfs_find_routes('A', 4)
puts a2c_routes.keep_if{|e| e.length == 9}.count

# problem 8
puts 'problem 8: '
a2c_route = graph.djikstra_shortest_route('A', 'C')
puts a2c_route

# problem 9
puts 'problem 9: '
b2b_route = graph.djikstra_shortest_route('B', 'B')
puts b2b_route

# problem 10
puts 'problem 10: '
c2c_route = graph.bfs_find_routes('C', 30)
puts c2c_route


