class Player
  attr_accessor :opponent
  attr_reader :moves

  def initialize(color, board, computer = false)
    @color = color
    @board = board
    @opponent = nil
    @pieces = @board.setup_pieces(@color)
    @moves = find_available_moves(@pieces, @board)
  end

  def find_available_moves(pieces, board, curr_in_check = false)
    # Each move defined as piece: [row, col], interpreted as 
    # "I can move piece to square (row, col)"
    moves = {}
    pieces.values.each do |piece_list|
      piece_list.each do |piece|
        piece.potential_moves.each do |new_row, new_col|
          moves[piece] = piece.potential_moves if board.valid_move?(piece, new_row, new_col, curr_in_check)
        end
      end
    end

    # TODO - find way to minimize number of calls on #FAM/
    # Note that for each piece, it will need to run a simulation of move, then get opp's pieces, then run sim
    # on those. With 16 pieces, this grows with 16^n. Going to be too slow.

    return moves
  end

  def lose_piece(piece)
    @pieces.values.each do |piece_list|
      next unless piece_list.include?(piece)
      piece_list.remove(piece)
    end
  end

  # TODO - Move game_over?, checkmate?, and stalemate? to Game class
  def game_over?
    @moves.values.each do |move_list|
      return false unless move_list.empty?
    end
    return true
  end

  def checkmate?
    game_over? && @board.check?(self)
  end

  def stalemate?
    game_over? && !@board.check?(self)
  end

end