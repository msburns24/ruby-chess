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
    setup_pieces("lib/base_setup.json")
  end

  def create_squares
    squares = []
    colors = [:white, :black]
    (0..7).each do |row|
      squares << []
      (0..7).each do |col|
        color = colors[row%2 - col%2]
        squares[-1] << Square.new(col, row, color)
      end
    end

    @squares = squares
  end

  def valid_move?(col, row)
    return @squares[row][col] if @squares[row][col].piece.nil?
  end

  def setup_pieces(setup_file)
    piece_data_array = JSON.parse(File.read(setup_file))
    piece_data_array.each do |piece_data|
      col = piece_data[0]
      row = piece_data[1]
      color = piece_data[2]
      type = piece_data[3]

      case type
      when "king"
        @squares[row][col].add_piece King.new(self, color.to_sym)
      when "queen"
        @squares[row][col].add_piece Queen.new(self, color.to_sym)
      when "bishop"
        @squares[row][col].add_piece Bishop.new(self, color.to_sym)
      when "knight"
        @squares[row][col].add_piece Knight.new(self, color.to_sym)
      when "rook"
        @squares[row][col].add_piece Rook.new(self, color.to_sym)
      when "pawn"
        @squares[row][col].add_piece Pawn.new(self, color.to_sym)
      else
        puts "Okay, something went wrong here with the type. No match."
      end
    end
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