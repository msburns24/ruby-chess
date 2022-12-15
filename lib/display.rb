require 'colorize'

class Display
  def initialize()
    print_temp_board
  end

  def print_temp_board
    system 'cls'
    puts ""
    black_square = :light_black       # TEMP, in future use square's color
    white_square = :white       # TEMP, in future use square's color

    4.times do 
      4.times do
        print "    ".colorize(:color => :black, :background => white_square)
        print "    ".colorize(:color => :black, :background => black_square)
      end
      print "\n"

      4.times do
        print "    ".colorize(:color => :black, :background => black_square)
        print "    ".colorize(:color => :black, :background => white_square)
      end
      print "\n"

      # TODO: Creat board with chess pieces (default layout)
    end

    puts ""
  end
end