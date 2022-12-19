class Piece
  attr_accessor :square
  attr_reader :color, :long_move_piece
  def initialize(board, player, color = nil)
    @board = board
    @player = player
    @color = (color.nil? ? @player.color : color)
    @text = ""
    @square = nil
    @movements = []
    @long_move_piece = false # Override on bishop/queen/rook
  end

  def move_piece(row, col)
    return false unless @player.valid_move?(self, row, col)
    
    # Remove opponent's piece if capture.
    if capture?(self, row, col)
      opp_piece = @board[row][col].piece
      @board[row][col].piece = nil            # Remove piece from board
      @player.opponent.lose_piece(opp_piece)  # Remove piece from opp's pieces
    end

    prev_square = @square
    new_square = @board[row][col]
    new_square.piece = self
    @square = new_square
    prev_square.piece = nil
    return true
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

  def pos
    [@square.row, @square.col]
  end

  def to_s
    @text
  end
end