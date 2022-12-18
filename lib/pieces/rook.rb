require_relative '../piece'
require 'json'

class Rook < Piece

  def initialize(board, player)
    super(board, player)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[player.color.to_s]["rook"]
    @long_move_piece = true
  end

  def setup_movements
    [[0,1], [1,0]].each do |base|
      (-7..7).each do |mult|
        next if mult == 0
        @movements << base.map { |dir| dir*mult }
      end
    end
  end
end