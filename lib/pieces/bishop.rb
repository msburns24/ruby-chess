require_relative '../piece'
require 'json'

class Bishop < Piece

  def initialize(board, color)
    super(board, color)
    pieces_text = JSON.parse(File.read("lib/pieces/unicode_pieces.json"))
    @text = pieces_text[color.to_s]["bishop"]
  end

  def setup_movements
    [[1,1], [1,-1], [-1,-1], [-1,1]].each do |base|
      (1..7).each do |mult|
        @movements << base.map { |dir| dir*mult }
      end
    end
  end

  def valid_move?(new_row, new_col)
    row_change = new_row - @square.row
    col_change = new_col - @square.col
    distance = [row_change.abs(), col_change.abs()].max

    base_move = [row_change/distance, col_change/distance]
    (1..distance).each do |mult|
      row_i = @square.row + base_move[0]*mult
      col_i = @square.col + base_move[1]*mult
      return false unless @board.open_square?(row_i, col_i, @color)
    end

    return true
  end
end