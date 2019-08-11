#!/usr/bin/ruby
# frozen_string_literal: true

require '../includes/lib'
token = '810797047:AAHJ__oVXVBP6teg1i3hI4I48xsBcxZQexg'

def start_again(bot, message)
  mess = 'Do you really want to start again?'
  button_start =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w[/start]], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: button_start)
  full_game(bot)
end

def full_game(bot)
  start(bot)
  pre_init(bot)
  init(bot)
  run_a_game(bot)
end

Telegram::Bot::Client.run(token) do |bot|
  full_game(bot)
end
