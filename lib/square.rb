require 'colorize'

class Square
  attr_reader :color, :row, :col
  attr_accessor :piece

  def initialize(row, col, color)
    @color = color
    @row = row
    @col = col
    @piece = nil
  end

  def add_piece(piece)
    return false if @piece
    @piece = piece
    piece.square = self
  end

  def remove_piece
    @piece = nil
  end

  def to_s
    str_return = " "
    str_return += (@piece.nil? ? " " : @piece.to_s)
    str_return += "  "
    return str_return.colorize(:background => color.to_sym)
  end
end