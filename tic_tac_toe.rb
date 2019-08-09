#!/usr/bin/ruby
# frozen_string_literal: true

require 'telegram/bot'
token = 'a_great_great_secret'

def pre_init(bot)
  bot.listen do |message|
    case message.text
    when '/start'
      mess = "Hello, #{message.from.first_name}!😊\nThis is __Tic-tac-toe game__ created by Andrii Nyvchyk.\nDo you wanna play?😏"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [%w(Yes), %w(No)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers, parse_mode: 'Markdown')
    when 'Yes'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: 'Great!', reply_markup: kb)
      question = 'Do you want to play for crosses or noughts?'
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [%w(Crosses), %w(Noughts)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
      break
    when 'No'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      mess = "Sorry to see you go :(\nWrite /start to run me again."
      bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
    else
      mess = "Say 'Yes' or 'No', motherfucker"
      bot.api.send_message(chat_id: message.chat.id, text: mess)
    end
  end
end

def init(bot)
  bot.listen do |message|
    case message.text
    when 'Crosses'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      mess = "Great, #{message.from.first_name}! You will play for crosses!"
      bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
    when 'Noughts'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      mess = "Great, #{message.from.first_name}! You will play for noughts!"
      bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
    else
      mess = 'Say for whom do you wanna play, motherfucker!'
      bot.api.send_message(chat_id: message.chat.id, text: mess)
    end
  end
end

Telegram::Bot::Client.run(token) do |bot|
  pre_init(bot)
  init(bot)
end
