class Piece
  attr_accessor :square
  attr_reader :color, :row, :col, :long_move_piece
  def initialize(board, color)
    @board = board
    @color = color
    @text = ""
    @square = nil
    @movements = []
    @long_move_piece = false # Override on bishop/queen/rook
  end

  def move_piece(row, col)
    # TODO - handle if piece is taking opponent's piece
    # How to get opponent's @piece variable?
    new_square, taking_piece = @board.open_square?(row, col, @color)
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
    row = @square.row
    col = @square.col
    @movements.each do |movement|
      new_row = row + movement[0]
      new_col = col + movement[1]
      if (new_row.between?(0,7) && new_col.between?())
      if @board.open_square?(new_row, new_col, @color)
        @potential_moves << [new_row, new_col]
      end
    end
    @potential_moves
  end

  def to_s
    @text
  end
end