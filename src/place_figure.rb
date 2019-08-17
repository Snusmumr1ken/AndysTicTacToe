# frozen_string_literal: true

def place_1(map, figure)
  map[0, 0] = figure if map[0, 0].zero?
end

def place_2(map, figure)
  map[0, 1] = figure if map[0, 1].zero?
end

def place_3(map, figure)
  map[0, 2] = figure if map[0, 2].zero?
end

def place_4(map, figure)
  map[1, 0] = figure if map[1, 0].zero?
end

def place_5(map, figure)
  map[1, 1] = figure if map[1, 1].zero?
end

def place_6(map, figure)
  map[1, 2] = figure if map[1, 2].zero?
end

def place_7(map, figure)
  map[2, 0] = figure if map[2, 0].zero?
end

def place_8(map, figure)
  map[2, 1] = figure if map[2, 1].zero?
end

def place_9(map, figure)
  map[2, 2] = figure if map[2, 2].zero?
end
