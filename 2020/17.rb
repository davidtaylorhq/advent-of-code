require 'set'

raw_lines = DATA.readlines

class Space
  def initialize(dimensions = 3)
    @dimensions = dimensions
    @active = Set.new
    @neighbours = Hash.new(0)
  end

  def initialize_copy(other_obj)
    @active = @active.dup
    @neighbours = @neighbours.dup
  end

  def active?(coords)
    @active.include?(coords)
  end

  def active!(coords, active = true)
    change =
      if active
        1 if @active.add?(coords)
      else
        -1 if @active.delete?(coords)
      end
    neighbours(coords).each { |c| @neighbours[c] += change } if change
  end

  def active_coords
    @active
  end

  def neighbours(coord)
    [-1, 0, 1]
      .repeated_permutation(@dimensions)
      .filter { |perm| !perm.all? { |v| v == 0 } }
      .map { |perm| [coord, perm].transpose.map(&:sum) }
  end

  def interesting_coords
    active_coords.dup.merge(@neighbours.keys)
  end

  def active_neighbours(coord)
    @neighbours[coord]
  end
end

[3, 4].each do |dim|
  space = Space.new(dim)

  raw_lines.each_with_index do |l, y|
    l.each_char.with_index do |char, x|
      space.active!([x, y, *Array.new(dim - 2, 0)]) if char == '#'
    end
  end

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
