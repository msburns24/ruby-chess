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

  def open_square?(row, col, move_color)
    return nil, false unless (row.between?(0,7) && col.between?(0,7))
    
    if @squares[row][col].piece.nil?
      return @squares[row][col], false
    elsif @squares[row][col].piece.color != move_color
      return @squares[row][col], true
    else
      return nil, false
    end
  end

  def setup_pieces(player_color)
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

      next unless color == player_color
      @squares[row][col].add_piece( piece_classes[type].new(self, color) )
      pieces_hash[type] << @squares[row][col].piece
    end

    return pieces_hash
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
end