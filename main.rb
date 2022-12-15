require_relative 'lib/display.rb'
require_relative 'lib/board.rb'

# test_board = Board.new
# system 'cls'
# puts test_board

#### COLUMN, ROW, COLOR, TYPE

require 'json'
prime_row = ["rook", "knight", "bishop", "king", "queen", "bishop", "knight", "rook"]


output_array = []

row = 0
col = 0
prime_row.each do |type|
  output_array << [col, row, "black", type]
  col += 1
end

row = 1
col = 0
8.times do
  output_array << [col, row, "black", "pawn"]
  col += 1
end

row = 6
col = 0
8.times do
  output_array << [col, row, "white", "pawn"]
  col += 1
end

row = 7
col = 0
prime_row.each do |type|
  output_array << [col, row, "white", type]
  col += 1
end

File.write("lib/base_setup.json", JSON.dump(output_array))