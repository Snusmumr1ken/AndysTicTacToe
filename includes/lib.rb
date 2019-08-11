# frozen_string_literal: true

require 'telegram/bot'
require '../../AndysTicTacToe/src/game'
require '../../AndysTicTacToe/src/init'
require '../../AndysTicTacToe/src/init_game_field'
require '../../AndysTicTacToe/src/pre_init'
require '../../AndysTicTacToe/src/start'

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
