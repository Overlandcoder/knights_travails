class Board
  def initialize(start)
    @start = start
    p @start
  end

  def possible_moves
    moves = (0..7).to_a.permutation(2).to_a
    (0..7).flat_map { |num| moves << [num, num] }
    moves
  end

  def create_children
    
  end
end

class Knight

end

game = Board.new([0,0])
p game.possible_moves.count
