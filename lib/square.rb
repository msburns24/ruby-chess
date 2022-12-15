class Square
  attr_reader :color, :row, :col, :piece

  def initialize(col, row, color)
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
    return str_return.colorize(:background => color)
  end
end