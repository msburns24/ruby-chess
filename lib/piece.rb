class Piece
  attr_accessor :square
  attr_reader :color, :row, :col
  def initialize(board, color)
    @board = board
    @color = color
    @text = ""
    @square = nil
    @movements = []
  end

  def move_piece(row, col)
    new_square = @board.open_square?(row, col)
    if new_square
      @square.remove_piece
      @square = new_square
      @square.add_piece(self)
      return true
    end
    return false
  end

  def get_available_moves
    @available_moves = []
    row = @square.row
    col = @square.col
    @movements.each do |movement|
      new_row = row + movement[0]
      new_col = col + movement[1]
      if valid_move?(new_row, new_col)
        @available_moves << [new_row, new_col]
      end
    end
    @available_moves
  end

  # For all pieces but bishop, queen, & rook
  def valid_move?(new_row, new_col)
    # TODO - (King) move is only valid if it doesn't put player in check
    @board.open_square?(new_row, new_col)
  end

  def to_s
    @text
  end
end