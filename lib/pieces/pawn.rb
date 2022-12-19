require_relative '../piece'
require 'json'

class Pawn < Piece

  # TODO - Constrain pawn's moves to only capture at a diagonal

  def initialize(board, player, color = nil)
    super(board, player, color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[@color.to_s]["pawn"]
    @made_first_move = false
    @long_move_piece = true # Only for first move
  end
  
  def setup_movements
    @movements << (@color == :white ? [-1, 0] : [1,0])
    @movements << (@color == :white ? [-2, 0] : [2,0]) unless @made_first_move
  end

  def move_piece(row, col)
    if super(row, col)
      @made_first_move = true
      @long_move_piece = false
      setup_movements
    end
  end
end