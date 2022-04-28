class Board
  attr_accessor :nodes

  def initialize
    @nodes = []
    create_nodes
    assign_children
  end

  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def valid_move?(x_coord, y_coord)
    x_coord.between?(0, 7) && y_coord.between?(0, 7)
  end

  def positions
    [*0..7].repeated_permutation(2).to_a
  end

  def create_nodes
    positions.each { |position| nodes << Node.new(position) }
  end

  def assign_children
    nodes.each do |node|
      possible_moves.each do |move|
        x_coord = node.position[0] + move[0]
        y_coord = node.position[1] + move[1]
        node.children << find_child(x_coord, y_coord) if valid_move?(x_coord, y_coord)
      end
    end
  end

  def find_child(x_coord, y_coord)
    nodes.find { |node| node.position == [x_coord, y_coord] }
  end

  def knight_moves(start_position, end_position)
    starting_node = @nodes.find { |node| node.position == start_position }
    level_order(starting_node, end_position)
  end

  def level_order(starting_node, end_position)
    queue = [starting_node]
    until queue.empty?
      node = queue.shift
      node.children.each do |child|
        queue << child
        child.parent = node if child.parent.nil?
      end

      if node.position == end_position
        create_path(node, starting_node)
        break
      end
    end
  end

  def create_path(node, starting_node)
    path = []
    until node.position == starting_node.position
      path << node.position
      node = node.parent
      path << node.position if node.position == starting_node.position
    end
    display_path(path)
  end

  def display_path(path)
    puts "Attempting to go from #{path[-1]} to #{path[0]}..."
    puts "You made it in #{path.count - 1} moves! Here's your path:"
    path.reverse.each { |move| p move }
  end
end

class Node
  attr_reader :position
  attr_accessor :children, :parent

  def initialize(position)
    @position = position
    @children = []
  end
end

game = Board.new
game.knight_moves([0, 0], [1, 1])
