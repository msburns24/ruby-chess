require_relative 'square'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/rook'
require_relative 'pieces/pawn'

class Board
  def initialize()
    create_squares
  end

  def create_squares
    squares = []
    colors = ["white", "black"]
    (0..7).each do |row|
      squares << []
      (0..7).each do |col|
        color = colors[row%2 - col%2]
        squares[-1] << Square.new(row, col, color)
      end
    end

    @squares = squares
  end

  def setup_pieces(player)
    pieces_hash = {}
    # Piece classes is used to lookup a type (string) and return
    # the correct class
    piece_classes = {
      "king" => King, "queen" => Queen, "bishop" => Bishop,
      "knight" => Knight, "rook" => Rook, "pawn" => Pawn
    }
    piece_classes.keys.each { |type| pieces_hash[type] = [] }

    setup_file = "lib/base_setup.json"
    piece_data_array = JSON.parse(File.read(setup_file))
    piece_data_array.each do |piece_data|
      col = piece_data[0]
      row = piece_data[1]
      color = piece_data[2]
      type = piece_data[3]

      next unless color == player.color
      @squares[row][col].add_piece( piece_classes[type].new(self, player) )
      pieces_hash[type] << @squares[row][col].piece
    end

    return pieces_hash
  end

  def open_square?(row, col)
    @squares[row][col].piece.nil?
  end

  def valid_move?(piece, new_row, new_col, curr_in_check = false)
    return false if @squares[new_row][new_col].piece.color == piece.color # If it's occupied by player
    return false if illegal_jump?(piece, new_row, new_col)
    unless curr_in_check 
      # Prevents infinite loop if checking valid move of opponent during puts_in_check? simulation
      return false if puts_in_check?(piece.player, piece.pos, [new_row, new_col])
    end
    return true
  end

  def illegal_jump?(piece, new_row, new_col)
    return false unless piece.long_move_piece # For all pieces but bishop, queen, & rook

    row_change = new_row - piece.square.row
    col_change = new_col - piece.square.col
    distance = [row_change.abs(), col_change.abs()].max
    return false if distance == 1

    base_move = [row_change/distance, col_change/distance]
    (1..(distance-1)).each do |mult|
      row_i = piece.square.row + base_move[0]*mult
      col_i = piece.square.col + base_move[1]*mult
      return true unless open_square?(row_i, col_i)
    end

    return false
  end

  def capture?(piece, row, col)
    occupied_color = @squares[row][col].piece.color
    return (piece.color != occupied_color)
  end

  def check?(player)
    king_row = player.pieces["king"].square.row
    king_col = player.pieces["king"].square.col
    player.opponent.moves.values.each do |moves_list|
      moves_list.each { |posn| return true if posn == [king_row, king_col] }
    end
    return false
  end

  def puts_in_check?(player, start_pos, end_pos)
    sim_board = Board.new_from(self)
    player_color = player.color

    square_start = sim_board.squares[start_pos[0]][start_pos[1]]
    square_end = sim_board.squares[end_pos[0]][end_pos[1]]
    given_piece = square_start.piece

    square_start.piece = nil
    square_end.piece = given_piece

    player_sim_pcs = get_simulation_pieces(player.color, sim_board)
    king_pc_arr = player_sim_pcs.select { |piece| piece.class.to_s == "King" }
    king_pos = king_pc_arr[0].pos

    opponent_sim_pcs = get_simulation_pieces(player.opponent.color, sim_board)
    opponent_moves = player.find_available_moves(opponent_sim_pcs, sim_board, true)
    # Passing curr_in_check = true to prevent infinite loop. Only validates move once more.

    opponent_moves.values.each do |move_list|
      move_list.each do |move_posn|
        return true if move_posn == king_pos
      end
    end

    return false
  end

  def get_simulation_pieces(color, board)
    sim_pieces = []
    board.squares.each do |sq_row|
      sq_row.each do |square|
        next if square.piece.nil? || square.piece.color != opp_color
        sim_pieces << square.piece
      end
    end

    return sim_pieces
  end

  def to_s
    return "" if @squares.nil?
    str_return = ""
    str_return += "\n"

    @squares.each do |row|
      row.each do |square|
        str_return += square.to_s
      end
      str_return += "\n"
    end
    str_return += "\n"

    return str_return
  end

  def self.new_from(existing_board)
    new_board = Board.new
    piece_classes = {
      "king" => King, "queen" => Queen, "bishop" => Bishop,
      "knight" => Knight, "rook" => Rook, "pawn" => Pawn
    }

    (0..7).each do |row|
      (0..7).each do |col|
        piece_i = existing_board.squares[row][col].piece
        next if piece_i.nil?

        piece_i_class = piece_i.class.to_s.downcase
        new_piece = piece_classes[piece_i_class].new(new_board, nil, piece_i.color)
        new_board.squares[row][col].add_piece(new_piece)
      end
    end

    return new_board

  end
end