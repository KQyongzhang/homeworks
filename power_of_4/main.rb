def is_power_of_4?(num)
  sprintf('%b', num) =~ /^1(0*$)/ if num > 0
  (!$1.nil? and ($1.length !=0 ) and ($1.length % 2 == 0)) ? true : false
end

puts is_power_of_4?(ARGV[0].to_i)

