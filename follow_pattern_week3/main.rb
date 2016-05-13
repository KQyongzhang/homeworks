# 双射类
class Bijection
  def initialize
    @f_map = {} # e1 -> e2
    @b_map = {} # e2 -> e1
  end

  def match?(e1, e2)
    add(e1, e2) if !@f_map.keys.include?(e1) and !@b_map.keys.include?(e2)
    (@f_map[e1] == e2 and @b_map[e2] == e1) ? true : false
  end

  def add(e1, e2)
    @f_map[e1] = e2
    @b_map[e2] = e1
  end
end

def is_match?(pat_array, str_array)
  return false if pat_array.size != str_array.size
  bj = Bijection.new
  pat_array.each_with_index do |e1, i|
    return false if !bj.match?(e1, str_array[i])
  end
  return true
end

puts is_match?(ARGV[0].split(''), ARGV[1].split(' '))

