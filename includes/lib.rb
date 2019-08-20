# frozen_string_literal: true

require 'telegram/bot'
require '../src/show_map'
require '../src/pvp'
require '../src/pve_loop'
require '../src/init_pve'
require '../src/init_game_field'
require '../src/pvp_or_pve'
require '../src/start'
require '../src/place_figure'
require '../src/player_bot'
require '../src/user_class'

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
