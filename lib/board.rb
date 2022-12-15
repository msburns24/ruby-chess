require_relative 'square'
require_relative 'pieces/king'

class Board
  def initialize()

    create_squares
  end

  def create_squares
    squares = []
    colors = [:black, :white]
    (0..7).each do |row|
      squares << []
      (0..7).each do |col|
        color = colors[row%2 - col%2]
        squares[-1] << Square.new(col, row, color)
      end
    end

    @squares = squares
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