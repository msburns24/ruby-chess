require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board

  def initialize()
    @board = Board.new
    @white_player = Player.new("white", @board)
    @black_player = Player.new("black", @board, true)

    @white_player.opponent = @black_player
    @black_player.opponent = @white_player

    @white_player.find_available_moves
    @black_player.find_available_moves
  end

  # TODO - Create turns cycle
  # TODO - Interpret "Knight B6" into [piece, row, col]
end