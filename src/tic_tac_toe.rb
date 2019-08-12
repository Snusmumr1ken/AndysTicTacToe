#!/usr/bin/ruby
# frozen_string_literal: true

require '../includes/lib'
token = 'token'

def full_game(bot)
  start(bot)
  pre_init(bot)
  init(bot)
  map = Map.new
  run_a_game(bot, map)
  game_loop(bot, map)
end

Telegram::Bot::Client.run(token) do |bot|
  full_game(bot)
end
