#!/usr/bin/ruby
# frozen_string_literal: true

require '../includes/lib'
token = 'token'

def full_game(bot)
  start(bot)
  pre_init(bot)
  players_figure = init(bot)
  user = User.new(players_figure)
  easy_bot = Player_bot.new(players_figure)
  map = Map.new
  run_a_game(bot, map)
  game_loop(bot, map, easy_bot, user)
end

Telegram::Bot::Client.run(token) do |bot|
  full_game(bot)
end
