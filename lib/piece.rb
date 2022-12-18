class Piece
  attr_accessor :square
  attr_reader :color, :row, :col, :long_move_piece
  def initialize(board, player)
    @board = board
    @player = player
    @color = player.color
    @text = ""
    @square = nil
    @movements = []
    @long_move_piece = false # Override on bishop/queen/rook
  end

  def move_piece(row, col)
    # TODO - Change logic to include #valid_move?
    # How to get opponent's @piece variable?
    # new_square, taking_piece = @board.open_square?(row, col, @color)
    if new_square
      @square.remove_piece
      @square = new_square
      @square.add_piece(self)
      return true
    end
    return false
  end

  def potential_moves
    @potential_moves = []
    current_row = @square.row
    current_col = @square.col
    @movements.each do |movement|
      new_row = current_row + movement[0]
      new_col = current_col + movement[1]
      next unless (new_row.between?(0,7) && new_col.between?(0,7))
      @potential_moves << [new_row, new_col]
    end
    @potential_moves
  end

  def to_s
    @text
  end
end