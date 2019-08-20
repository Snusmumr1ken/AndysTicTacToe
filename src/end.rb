# frozen_string_literal: true

def the_end(bot, message, i, bd)
  change_status(bd, message.chat.id, 'start')
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
end

def check_end(bot, message, map, bd)
  res = map.check_game_status
  if res == 'Crosses won!'
    show_game_field(bot, message, map)
    the_end(bot, message, 1, bd)
    return 1
  elsif res == 'Noughts won!'
    show_game_field(bot, message, map)
    the_end(bot, message, 2, bd)
    return 1
  elsif res == 'No space'
    show_game_field(bot, message, map)
    the_end(bot, message, 0, bd)
    return 1
  end
  0
end