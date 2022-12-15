class Piece
  attr_reader :color, :row, :col
  # TODO - Make rest of chess pieces
  def initialize(color)
    @color = color
    @text = ""
    @movements = []
  end

  def to_s
    @text
  end
end