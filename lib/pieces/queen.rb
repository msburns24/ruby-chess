require_relative '../piece'
require 'json'

class Queen < Piece

  def initialize(board, color)
    super(board, color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[color.to_s]["queen"]
  end
end