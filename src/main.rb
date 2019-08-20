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
  start(bot)
  map = Map.new
  type_of_game = decide_pvp_or_pve(bot, map)
  if type_of_game == 2
    pve(bot, map)
  elsif type_of_game == 1
    pvp(bot, map)
  end
end

Telegram::Bot::Client.run(token) do |bot|
  full_game(bot)
end
