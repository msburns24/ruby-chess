class Player
  attr_accessor :opponent

  def initialize(color, board, computer = false)
    @color = color
    @board = board
    @opponent = nil
    add_pieces
    # find_available_moves
  end

  def add_pieces
    @pieces = @board.setup_pieces(@color)
  end

  def find_available_moves
    # Each move defined as piece: [row, col], interpreted as 
    # "I can move piece to square (row, col)"
    @moves = {}
    @pieces.each do |piece|
      @moves[piece] = piece.get_available_moves
    end
  end

  # TODO - Add #check? method
  # TODO - Add #checkmate? method

  # TODO - Create computer version of player
end