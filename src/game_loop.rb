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

# i == 0 - ничья
# i == 1 - крестики выиграли
# i == 2 - нолики выиграла

def say_end(bot, message, i)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess =  case i
          when 0
            "End of the game, #{message.from.first_name}!\nIt's a draw!"
          when 1
            "End of the game, #{message.from.first_name}!\nCrosses has won!"
          when 2
            "End of the game, #{message.from.first_name}!\nNoughts has won!\n"
          end
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
  mess = 'Do you want to play again?'
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w[/start]], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers)
  full_game(bot)
end

def tick(bot, message, map)
  cases(map, message.text)
  show_game_field(bot, message, map)
  if map.check_game_status == 'Crosses won!'
    say_end(bot, message, 1)
  elsif map.check_game_status == 'Noughts won!'
    say_end(bot, message, 2)
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
      tick(bot, message, map)
    end
  end
end

def game_loop(bot, map)
  listen_user_input(bot, map)
end
