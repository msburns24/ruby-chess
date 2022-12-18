require_relative '../piece'
require 'json'

class Knight < Piece

  def initialize(board, player)
    super(board, player)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[player.color.to_s]["knight"]
  end

  def setup_movements
    [[-1,-2], [-2,-1], [-2, 1], [-1, 2]].each do |base|
      (-7..7).each do |mult|
        next if mult == 0
        @movements << base.map { |dir| dir*mult }
      end
    end
  end
end