# frozen_string_literal: true

class Player_bot
  def initialize(user_figure)
    @figure = 2 if user_figure == 1
    @figure = 1 if user_figure == 2
  end

  def read_figure
    @figure
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
    0                 # there is no place to move
  end

  def check_horizontal(map, i, fig)
    return 2 if map[i, 0] == fig && map[i, 1] == fig && map[i, 2].zero?
    return 1 if map[i, 0] == fig && map[i, 1].zero? && map[i, 2] == fig
    return 0 if map[i, 0].zero? && map[i, 1] == fig && map[i, 2] == fig

    -1
  end

  def check_vertical(map, i, fig)
    return 2 if map[0, i] == fig && map[1, i] == fig && map[2, i].zero?
    return 1 if map[0, i] == fig && map[1, i].zero? && map[2, i] == fig
    return 0 if map[0, i].zero? && map[1, i] == fig && map[2, i] == fig

    -1
  end

  def check_diagonal1(map, fig)
    return 2 if map[0, 0] == fig && map[1, 1] == fig && map[2, 2].zero?
    return 1 if map[0, 0] == fig && map[1, 1].zero? && map[2, 2] == fig
    return 0 if map[0, 0].zero? && map[1, 1] == fig && map[2, 2] == fig

    -1
  end

  def check_diagonal2(map, fig)
    return 2 if map[0, 2] == fig && map[1, 1] == fig && map[2, 0].zero?
    return 1 if map[0, 2] == fig && map[1, 1].zero? && map[2, 0] == fig
    return 0 if map[0, 2].zero? && map[1, 1] == fig && map[2, 0] == fig

    -1
  end

  def hard_move(map)
    return 1 if try_to_move(map, @figure) == 1

    enemy = @figure == 1 ? 2 : 1
    return 1 if try_to_move(map, enemy) == 1

    if map[1, 1].zero?
      map[1, 1] = @figure
      return 1
    end
    easy_move(map)
  end

  def try_to_move(map, fig)
    # check vertical and horizontal
    (0..2).each do |i|
      ret = check_horizontal(map, i, fig)
      if ret != -1
        map[i, ret] = @figure
        return 1
      end
      ret = check_vertical(map, i, fig)
      if ret != -1
        map[ret, i] = @figure
        return 1
      end
    end
    # check diagonals
    ret = check_diagonal1(map, fig)
    if ret != -1
      map[ret, ret] = @figure
      return 1
    end
    ret = check_diagonal2(map, fig)
    if ret == 2
      map[2, 0] = @figure
      return 1
    elsif ret.zero?
      map[0, 2] = @figure
      return 1
    elsif ret == 1
      map[1, 1] = @figure
      return 1
    end
    0
  end
  
end