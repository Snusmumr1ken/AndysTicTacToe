#!/usr/bin/ruby
# frozen_string_literal: true

require '../lib/lib'

token = 'token'
bd = []
maps = []
user1 = User.new(1)
user2 = User.new(2)
pve_bot = Player_bot.new(1)

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bd.push([message.chat.id, 'start', 0]) if check_all(bd, message.chat.id).zero?
    case message.text
    when '/start'
      start(bd, bot, message)
    when '/stop', 'No'
      stop(bot, bd, message, maps)
    when '/restart', 'Yes'
      restart(bot, bd, message, maps)
    when 'PVE'
      pve_setup(bd, bot, message, maps)
    when 'PVP'
      pvp_setup(bd, bot, message, maps)
    when '1', '2', '3', '4', '5', '6', '7', '8', '9'
      if check_status(bd, message.chat.id, 'pve') == 1
        pve_game(bd, bot, message, maps, user1, pve_bot)
      elsif check_status(bd, message.chat.id, 'pvp') == 1
        pvp_game(bd, bot, message, maps, user1, user2)
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'Unknown')
    end
  end
end
