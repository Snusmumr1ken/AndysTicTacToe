# frozen_string_literal: true

def get_map(maps, id)
  iterator = 0
  maps.each do |i|
    return iterator if i.read_id == id

    iterator += 1
  end
  -1
end

def del_map(maps, id)
  iterator = 0
  maps.each do |i|
    maps.delete_at(iterator) if i.read_id == id
    iterator += 1
  end
end

def check_all(bd, id)
  bd.each do |i|
    return 1 if i[0] == id
  end
  0
end

def get_iter(bd, id)
  iterator = 0
  bd.each do |i|
    return iterator if i[0] == id

    iterator += 1
  end
end

def change_status(bd, id, status)
  bd.each do |i|
    if i[0] == id
      i[1] = status
      break
    end
  end
end

def check_status(bd, id, status)
  bd.each do |i|
    if i[0] == id
      return 1 if i[1] == status
      return 0
    end
  end
end