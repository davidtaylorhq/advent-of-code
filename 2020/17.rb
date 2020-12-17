require 'set'

raw_lines = DATA.readlines

class Space
  def initialize(dimensions = 3)
    @dimensions = dimensions
    @space = Set.new
  end

  def initialize_copy(other_obj)
    @space = @space.dup
  end

  def active?(coords)
    !!@space.include?(coords)
  end

  def active!(coords, active = true)
    if active
      @space.add coords
    else
      @space.delete coords
    end
  end

  def active_coords
    @space
  end

  def neighbour_coordinates_for(coord)
    [-1, 0, 1]
      .repeated_permutation(@dimensions)
      .filter { |perm| !perm.all? { |v| v == 0 } }
      .map { |perm| [coord, perm].transpose.map(&:sum) }
  end

  def interesting_coords
    interesting = active_coords.dup
    active_coords.each { |c| interesting.merge(neighbour_coordinates_for(c)) }
    interesting
  end

  def active_neighbours(coord)
    neighbour_coordinates_for(coord).filter { |coord| active?(coord) }.count
  end
end

[3, 4].each do |dim|
  space = Space.new(dim)

  raw_lines.each_with_index do |l, y|
    l.each_char.with_index do |char, x|
      space.active!([x, y, *Array.new(dim - 2, 0)]) if char == '#'
    end
  end

  cycle = 0
  (1..6).each do |cycle|
    new_space = space.dup
    space.interesting_coords.each do |coord|
      neighbours = space.active_neighbours coord
      if space.active? coord
        new_space.active! coord, [2, 3].include?(neighbours)
      else
        new_space.active! coord, neighbours == 3
      end
    end
    space = new_space
  end

  puts "#{space.active_coords.count} in #{dim} dimensions"
end

__END__
..#..#..
#.#...#.
..#.....
##....##
#..#.###
.#..#...
###..#..
....#..#
