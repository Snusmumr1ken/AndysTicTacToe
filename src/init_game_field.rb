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
end

def init_game_field
  Map.new
end