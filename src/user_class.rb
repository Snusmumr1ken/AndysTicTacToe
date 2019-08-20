# frozen_string_literal: true

require './place_figure'

class User
  def initialize(figure)
    @figure = figure
  end

  def read_figure
    @figure
  end

  def move(map, mess)
    case mess
    when '1'
      place_1(map, @figure)
    when '2'
      place_2(map, @figure)
    when '3'
      place_3(map, @figure)
    when '4'
      place_4(map, @figure)
    when '5'
      place_5(map, @figure)
    when '6'
      place_6(map, @figure)
    when '7'
      place_7(map, @figure)
    when '8'
      place_8(map, @figure)
    when '9'
      place_9(map, @figure)
    end
  end
end