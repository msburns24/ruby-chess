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
      piece_list.each do |piece|
        piece.potential_moves.each do |new_row, new_col|
          @moves[piece] = piece.potential_moves if valid_move?(piece, new_row, new_col)
        end
      end
    end
  end

  # For all pieces but bishop, queen, & rook
  def valid_move?(piece, new_row, new_col)
    return false unless not_jumping?(piece, new_row, new_col)
    return false unless @board.open_square?(new_row, new_col, @color)
    # TODO - (King) move is only valid if it doesn't put player in check
    return true
  end

  def not_jumping?(piece, new_row, new_col)
    return true unless piece.long_move_piece

    row_change = new_row - piece.square.row
    col_change = new_col - piece.square.col
    distance = [row_change.abs(), col_change.abs()].max

    base_move = [row_change/distance, col_change/distance]
    (1..distance).each do |mult|
      row_i = piece.square.row + base_move[0]*mult
      col_i = piece.square.col + base_move[1]*mult
      return false unless @board.open_square?(row_i, col_i, @color)
    end

    return true
  end

  def check?
    king_row = @pieces["king"].square.row
    king_col = @pieces["king"].square.col
    @opponent.moves.values.each do |moves_list|
      moves_list.each { |posn| return true if posn == [king_row, king_col] }
    end
    return false
  end

  # TODO - Add #checkmate? method

  # TODO - Create computer version of player
end