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
    return false if @board[new_row][new_col].piece.color == @color # If it's occupied by player
    return false if illegal_jump?(piece, new_row, new_col)
    # TODO - returns false if, by simulating this move, it puts player in check.
    return true
  end

  def illegal_jump?(piece, new_row, new_col)
    return false unless piece.long_move_piece

    row_change = new_row - piece.square.row
    col_change = new_col - piece.square.col
    distance = [row_change.abs(), col_change.abs()].max
    return false if distance == 1

    base_move = [row_change/distance, col_change/distance]
    (1..(distance-1)).each do |mult|
      row_i = piece.square.row + base_move[0]*mult
      col_i = piece.square.col + base_move[1]*mult
      return true unless @board.open_square?(row_i, col_i)
    end

    return false
  end

  def check?
    king_row = @pieces["king"].square.row
    king_col = @pieces["king"].square.col
    @opponent.moves.values.each do |moves_list|
      moves_list.each { |posn| return true if posn == [king_row, king_col] }
    end
    return false
  end

  def game_over?
    @moves.values.each do |move_list|
      return false unless move_list.empty?
    end
    return true
  end

  def checkmate?
    game_over? && check?
  end

  def stalemate?
    game_over? && !check?
  end

end