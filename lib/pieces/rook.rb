require_relative '../piece'
require 'json'

class Rook < Piece

  def initialize(board, color)
    super(board, color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[color.to_s]["rook"]
  end
end