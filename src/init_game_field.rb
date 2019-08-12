# frozen_string_literal: true

# Это класс описывающий карту на которой будут распологаться
# все игровые эелементы: 0 - клетка пустая, 1 - крестики, 2 - нолики
class Map
  def initialize
    @data = Array.new(3) { Array.new(3, 0) }
  end

  def [](x, y)
    @data[x][y]
  end

  def []=(x, y, value)
    @data[x][y] = value
  end

  def output
    (0..2).each do |i|
      (0..2).each do |j|
        print "#{@data[i][j]} "
      end
      print "\n"
    end
  end

  def check_game_status
    (0..2).each do |i|
      return 'Crosses won!' if @data[0][i] == 1 && @data[1][i] == 1 && @data[2][i] == 1
      return 'Noughts won!' if @data[0][i] == 2 && @data[1][i] == 2 && @data[2][i] == 2
      return 'Noughts won!' if @data[i][0] == 2 && @data[i][1] == 2 && @data[i][2] == 2
      return 'Crosses won!' if @data[i][0] == 1 && @data[i][1] == 1 && @data[i][2] == 1
    end
  end
end
