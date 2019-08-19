#!/usr/bin/ruby
# frozen_string_literal: true

require '../includes/lib'
token = 'token'

def pve(bot, map)
  players_figure = init(bot)
  user = User.new(players_figure)
  easy_bot = Player_bot.new(players_figure)
  run_pve(bot, map, easy_bot)
  pve_loop(bot, map, easy_bot, user)
end

def pvp(bot, map)
  user1 = User.new(1)
  user2 = User.new(2)
  pvp_loop(bot, map, user1, user2)
end

def full_game(bot)
  map = Map.new
  type_of_game = decide_pvp_or_pve(bot, map)
  if type_of_game == 2
    pve(bot, map)
  elsif type_of_game == 1
    pvp(bot, map)
  end
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!😊", reply_markup: kb)
      mess1 = "This is Tic-tac-toe game created by Andrii Nyvchyk.\n\nHow do you wanna play?😏\n\n"
      mess2 = "PVP - Player versus Player\nPVE - Player versus Computer"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [%w[PVP], %w[PVE]], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: mess1 + mess2, reply_markup: answers)
      full_game(bot)
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'Please, write /start now.')
    end
  end
end
