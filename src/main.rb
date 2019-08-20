#!/usr/bin/ruby
# frozen_string_literal: true

require './work_with_bd'
require './map_class'
require './user_class'
require './bot_class'
require './show_map'
require './end'
require 'telegram/bot'

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

def pvp(bd, bot, message)
  if check_status(bd, message.chat.id, 'pvp_or_pve') == 1
    change_status(bd, message.chat.id, "pvp")
    kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: "Great!\nGood luck!", reply_markup: kb)
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'STATUS PVP_OR_PVE_NEEDED')
  end
end

def pve_setup(bd, bot, message, maps)
  if check_status(bd, message.chat.id, 'pvp_or_pve') == 1
    change_status(bd, message.chat.id, "pve")
    map = Map.new(message.chat.id)
    maps << map
    kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: "Great!\nGood luck!", reply_markup: kb)
    show_game_field(bot, message, map)
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'STATUS PVP_OR_PVE_NEEDED')
  end
end

def pve_game(bd, bot, message, maps, user, pve_bot)
  i = get_map(maps, message.chat.id)
  if maps[i].dot_empty?(message.text)
    user.move(maps[i], message.text)
    if check_end(bot, message, maps[i], bd) == 1
      del_map(maps, message.chat.id)
      return 0
    end
    pve_bot.hard_move(maps[i])
    if check_end(bot, message, maps[i], bd) == 1
      del_map(maps, message.chat.id)
      return 0
    end
    show_game_field(bot, message, maps[i])
  end
end

token = 'token'
bd = []
maps = []
user1 = User.new(1)
user2 = User.new(2)
pve_bot = Player_bot.new(1)

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bd.push([message.chat.id, "start"]) if check_all(bd, message.chat.id).zero?
    case message.text
    when '/start'
      start(bd, bot, message)
    when 'PVE'
      pve_setup(bd, bot, message, maps)
    when '1', '2', '3', '4', '5', '6', '7', '8', '9'
      if check_status(bd, message.chat.id, 'pve') == 1
        pve_game(bd, bot, message, maps, user1, pve_bot)
      elsif check_status(bd, message.chat.id, 'pvp') == 1
        pvp_game()
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'Unknown')
    end
  end
end
