def simple_solution array, sum
  records = Array.new(array.size, Float::INFINITY)
  array.each_with_index do |e, i|
    tmp_sum = 0
    0.upto(array.size - i - 1) do |j|
      tmp_sum += array[i + j]
      if tmp_sum >= sum
        records[i] = j + 1
        break
      end
    end
  end
  records
end

def fast_solution array, sum
  records = Array.new(array.size, Float::INFINITY)
  i, j, tmp_sum  = 0, 0, array[0]
  while i < array.size do
    if tmp_sum < sum
      j       += 1
      break if j >= array.size
      tmp_sum += array[j]
    else
      records[i] = j - i + 1
      tmp_sum    = tmp_sum - array[i]
      i         += 1
    end
  end
  records
end

def parse_input args
  return args[0].split(',').map{ |e| e.to_i }, args[1].to_i
end

# 样例: ruby main.rb 1,3,4,2,34 6
array, sum = parse_input(ARGV)
# records = simple_solution array, sum
records = fast_solution array, sum


records.each_with_index do |e, i|
  if records.min == Float::INFINITY
    puts 'No such subarray'
    break
  end
  if e == records.min
    puts array.slice(i, e).inspect
  end
end
