# frozen_string_literal: true

def player_move(map, mess)
  case mess
  when '1'
    place_1(map, 1)
  when '2'
    place_2(map, 1)
  when '3'
    place_3(map, 1)
  when '4'
    place_4(map, 1)
  when '5'
    place_5(map, 1)
  when '6'
    place_6(map, 1)
  when '7'
    place_7(map, 1)
  when '8'
    place_8(map, 1)
  when '9'
    place_9(map, 1)
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

def check_end(bot, message, map)
  res = map.check_game_status
  if res == 'Crosses won!'
    say_end(bot, message, 1)
  elsif res == 'Noughts won!'
    say_end(bot, message, 2)
  elsif res == 'No space'
    say_end(bot, message, 0)
  end
end

def tick(bot, message, map, easy_bot)
  mess = "Field after your move, #{message.from.first_name}"
  player_move(map, message.text)
  bot.api.send_message(chat_id: message.chat.id, text: mess)
  show_game_field(bot, message, map)
  check_end(bot, message, map)

  mess = "Field after BOT move"
  easy_bot.easy_move(map)
  bot.api.send_message(chat_id: message.chat.id, text: mess)
  show_game_field(bot, message, map)
  check_end(bot, message, map)
end

def game_loop(bot, map, easy_bot)
  bot.listen do |message|
    case message.text
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      tick(bot, message, map, easy_bot)
    end
  end
end
