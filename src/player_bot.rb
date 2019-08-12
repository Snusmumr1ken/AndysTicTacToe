# frozen_string_literal: true

class Player_bot
  def initialize
    @figure = 2
  end

  def easy_move(map)
    (0..2).each do |i|
      (0..2).each do |j|
        if map[i, j].zero?
          map[i, j] = @figure
          return 1    # bot placed his figure on i j
        end
      end
    end
    0        # there is no place to move
  end
end