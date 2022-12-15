require_relative '../piece'
require 'json'

class King < Piece

  def initialize(color)
    super(color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[color.to_s]["queen"]
  end
end