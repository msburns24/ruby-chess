class Player
  attr_accessor :opponent
  attr_reader :moves

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
    @pieces.values.each do |piece_list|
      piece_list.each { |piece| @moves[piece] = piece.get_available_moves }
    end
  end

  def check?(row, col)
    @opponent.moves.values.each do |moves_list|
      moves_list.each { |posn| return true if posn == [row, col] }
    end
    return false
  end

  # TODO - Add #checkmate? method

  # TODO - Create computer version of player
end