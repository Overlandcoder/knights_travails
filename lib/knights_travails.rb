require 'pry-byebug'

class Board
  attr_reader :start
  attr_accessor :moves, :nodes

  def initialize(start)
    @start = start
    @moves = [start]
    @nodes = []
  end

  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def valid_move?(x_coord, y_coord)
    x_coord.between?(0, 7) && y_coord.between?(0, 7)
  end

  def positions
    positions = [*0..7].repeated_permutation(2).to_a
    positions
  end

  def create_nodes
    positions.each do |position|
      nodes << Node.new(position)
    end
  end

  def assign_children
    nodes.each do |node|
      possible_moves.each do |move|
        x_coord = node.value[0] + move[0]
        y_coord = node.value[1] + move[1]
        if valid_move?(x_coord, y_coord)
          child = nodes.find { |node| node.value == [x_coord, y_coord] }
          node.children << child
        end
      end
    end
  end

  def knight_moves(start_position)
    start_node = @nodes.find { |node| node.value == start_position }
    end_node = [0, 0]
    level_order(start_node, end_node)
  end

  def level_order(start_node, end_node)
    queue = [start_node]
    path = []
    until queue.empty?
      node = queue.shift
      p node.value
      path << node.value
      node.children.each { |child| queue << child }
      return path if node.value == end_node
    end
  end

    # ignore this method
    def create_children(node)
      possible_moves.each do |move|
        x_coord = node.value[0] + move[0]
        y_coord = node.value[1] + move[1]
        if valid_move?(x_coord, y_coord) && !@moves.include?([x_coord, y_coord])
          @child = Node.new([x_coord, y_coord])
          @moves << [x_coord, y_coord]
          node.children << @child
        end
      end
    end
end

class Knight

end

class Node
  attr_reader :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @children = []
    p value
  end
end

game = Board.new([3, 3])
knight = Node.new(game.start)
game.positions
p game.create_nodes
p game.moves.count
game.assign_children
game.knight_moves([3, 3])
