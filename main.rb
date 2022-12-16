require_relative 'lib/game.rb'

test_game = Game.new
# system 'cls'
# puts test_game.board

def my_method(str)
  return 1, 2
end


a, b = my_method("hi")

puts a 
puts b