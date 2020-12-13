lines = DATA.readlines
earliest = lines[0].to_i

bus_ids = lines[1].split(',').filter{|v| v != "x"}.map(&:to_i)

best_waiting_time = Float::INFINITY
best_bus = nil
bus_ids.each do |bus|
  remainder = earliest % bus
  waiting_time = bus - remainder
  if waiting_time < best_waiting_time
    best_bus = bus
    best_waiting_time = waiting_time
  end
end

puts "Best bus is #{best_bus} with waiting time #{best_waiting_time}"

puts "Multiplied, equals #{best_bus * best_waiting_time}"

__END__
1001938
41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,431,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,x,x,863,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29