# frozen_string_literal: true

require './show_map'

def start(bd, bot, message)
  if check_status(bd, message.chat.id, 'start') == 1
    kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!😊", reply_markup: kb)
    mess1 = "This is Tic-tac-toe game created by Andrii Nyvchyk.\n\nHow do you wanna play?😏\n\n"
    mess2 = "PVP - Player versus Player\nPVE - Player versus Computer"
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [%w[PVP], %w[PVE]], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: mess1 + mess2, reply_markup: answers)
    change_status(bd, message.chat.id, 'pvp_or_pve')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'You are not on the start layer to write /start.')
  end
end

def the_end(bot, message, i, bd)
  change_status(bd, message.chat.id, 'start')
  iter = get_iter(bd, message.chat.id)
  bd[iter][2] = 0
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
      .new(keyboard: [%w[Yes], %w[No]], one_time_keyboard: true)
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
