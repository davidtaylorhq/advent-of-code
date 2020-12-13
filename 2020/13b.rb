lines = DATA.readlines

Bus = Struct.new(:index, :interval)
buses = lines[1].split(',').each_with_index.map do |value, index| 
  Bus.new(index, value.to_i) if value != "x"
end.compact

t0 = 0
aligned_bus_count = 0
iterations = 0

interval = buses.max_by(&:interval).interval
loop do
  aligned_buses = buses.filter do |bus|
    (t0 + bus.index) % bus.interval == 0
  end

  if aligned_buses.count > aligned_bus_count
    interval = aligned_buses.map(&:interval).reduce(&:*)
    aligned_bus_count = aligned_buses.count
  end

  break if aligned_buses.count == buses.count

  t0 += interval
  iterations += 1
end

puts "Completed after #{iterations} iterations"
puts "t0 is #{t0}"

__END__
1001938
41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,431,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,x,x,863,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29