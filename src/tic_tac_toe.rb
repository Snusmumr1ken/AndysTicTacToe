#!/usr/bin/ruby
# frozen_string_literal: true

require '../includes/lib'
token = '810797047:AAHJ__oVXVBP6teg1i3hI4I48xsBcxZQexg'

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
