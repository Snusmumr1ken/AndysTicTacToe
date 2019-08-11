# frozen_string_literal: true

def cases(map, mess)
  case mess
  when '1'
    place_1(map)
  when '2'
    place_2(map)
  when '3'
    place_3(map)
  when '4'
    place_4(map)
  when '5'
    place_5(map)
  when '6'
    place_6(map)
  when '7'
    place_7(map)
  when '8'
    place_8(map)
  when '9'
    place_9(map)
  end
end

def listen_user_input(bot, map)
  bot.listen do |message|
    case message.text
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      cases(map, message.text)
      show_game_field(bot, message, map)
    end
  end
end

def game_loop(bot, map)
  listen_user_input(bot, map)
end