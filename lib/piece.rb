class Piece
  attr_accessor :square
  attr_reader :color, :row, :col
  # TODO - Make rest of chess pieces
  def initialize(board, color)
    @board = board
    @color = color
    @text = ""
    @square = nil
    @movements = []
  end

  def move_piece(col, row)
    new_square = @board.valid_move?(col, row)
    if new_square
      @square.remove_piece
      @square = new_square
      @square.add_piece(self)
    end
  end

  def to_s
    @text
  end
end