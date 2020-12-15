starting_numbers = DATA.readline.split(",").map(&:to_i)

last_spoken_at = {}

starting_numbers.each_with_index do |num, i|
  last_spoken_at[num] = i + 1
end

i = starting_numbers.length - 1
num = next_number = starting_numbers.last

while i < 30000000 do
  i += 1
  num = next_number
  next_number = last_spoken_at[num].nil? ? 0 : i - last_spoken_at[num]
  last_spoken_at[num] = i
end

puts "#{i}th number is #{num}"
__END__
14,8,16,0,1,17