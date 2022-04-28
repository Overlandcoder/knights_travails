class Board
  attr_accessor :nodes

  def initialize
    @nodes = []
    positions
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
    positions.each { |position| @nodes << Node.new(position) }
  end

  def assign_children
    nodes.each do |node|
      possible_moves.each do |move|
        x_coord = node.value[0] + move[0]
        y_coord = node.value[1] + move[1]
        node.children << find_child(x_coord, y_coord) if valid_move?(x_coord, y_coord)
      end
    end
  end

  def find_child(x_coord, y_coord)
    nodes.find { |node| node.value == [x_coord, y_coord] }
  end

  def knight_moves(start_position, end_position)
    starting_node = @nodes.find { |node| node.value == start_position }
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

      if node.value == end_position
        create_path(node, starting_node)
        break
      end
    end
  end

  def create_path(node, starting_node)
    path = []
    until node.value == starting_node.value
      path << node.value
      node = node.parent
      path << node.value if node.value == starting_node.value
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
  attr_reader :value
  attr_accessor :children, :parent

  def initialize(value, parent = nil)
    @value = value
    @children = []
    @parent = parent
  end
end

game = Board.new
game.knight_moves([0, 0], [4, 4])
