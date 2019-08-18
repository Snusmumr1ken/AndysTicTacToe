# frozen_string_literal: true

require 'telegram/bot'
require '../../AndysTicTacToe/src/show_map'
require '../../AndysTicTacToe/src/pvp'
require '../../AndysTicTacToe/src/run_pve'
require '../../AndysTicTacToe/src/pve_loop'
require '../../AndysTicTacToe/src/init_pve'
require '../../AndysTicTacToe/src/init_game_field'
require '../../AndysTicTacToe/src/pvp_or_pve'
require '../../AndysTicTacToe/src/start'
require '../../AndysTicTacToe/src/place_figure'
require '../../AndysTicTacToe/src/player_bot'
require '../../AndysTicTacToe/src/user_class'

def say_unknown_command(bot, message)
  mess = 'Do you think it is funny?'
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end

def start_again(bot, message)
  mess = 'Do you really want to start again?'
  button_start =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w[/start]], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: button_start)
  full_game(bot)
end

def stop(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Sorry to see you go :(\nWrite /restart to run me again."
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end
