require_relative '../piece'
require 'json'

class Bishop < Piece

  def initialize(board, player)
    super(board, player)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[player.color.to_s]["bishop"]
    @long_move_piece = true
  end

  def setup_movements
    [[1,1], [1,-1], [-1,-1], [-1,1]].each do |base|
      (1..7).each do |mult|
        @movements << base.map { |dir| dir*mult }
      end
    end
  end

end