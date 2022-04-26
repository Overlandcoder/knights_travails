require 'pry-byebug'

class Board
  attr_reader :start

  def initialize(start)
    @start = start
    @knight = Node.new(start)
  end

  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def create_children
    possible_moves.each do |move|
      x_coord = start[0] + move[0]
      y_coord = start[1] + move[1]
      Node.new([x_coord, y_coord], @knight) if valid_move?(x_coord, y_coord)
    end
  end

  def valid_move?(x_coord, y_coord)
    x_coord.between?(0, 7) && y_coord.between?(0, 7)
  end
end

class Knight

end

class Node
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    p "#{value} parent: #{parent}"
  end
end

game = Board.new([3, 3])
game.create_children
