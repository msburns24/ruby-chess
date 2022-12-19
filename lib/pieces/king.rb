require_relative '../piece'
require 'json'

class King < Piece

  def initialize(board, player, color = nil)
    super(board, player, color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[@color.to_s]["king"]
    setup_movements
  end

  def setup_movements
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if (row == 0) && (col == 0)
        @movements << [row, col]
      end
    end
  end
end