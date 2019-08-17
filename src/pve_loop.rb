# frozen_string_literal: true

# i == 0 - ничья
# i == 1 - крестики выиграли
# i == 2 - нолики выиграли

def pve_end(bot, message, i)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess =  case i
          when 0
            "End of the game, #{message.from.first_name}!\nIt's a draw!"
          when 1
            "End of the game, #{message.from.first_name}!\nCrosses won!"
          when 2
            "End of the game, #{message.from.first_name}!\nNoughts won!\n"
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
    show_game_field(bot, message, map)
    pve_end(bot, message, 1)
  elsif res == 'Noughts won!'
    show_game_field(bot, message, map)
    pve_end(bot, message, 2)
  elsif res == 'No space'
    show_game_field(bot, message, map)
    pve_end(bot, message, 0)
  end
end

def pve_tick(bot, message, map, easy_bot, user)
  user.move(map, message.text)
  check_end(bot, message, map)
  easy_bot.easy_move(map)
  check_end(bot, message, map)
  show_game_field(bot, message, map)
  mess = "Your move, #{message.from.first_name}!"
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end

def pve_loop(bot, map, easy_bot, user)
  bot.listen do |message|
    case message.text
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      pve_tick(bot, message, map, easy_bot, user)
    end
  end
end
