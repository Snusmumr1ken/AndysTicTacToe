#!/usr/bin/ruby
# frozen_string_literal: true

require 'telegram/bot'
require_relative 'init'
require_relative 'pre_init'
require_relative 'game'

token = 'token'

Telegram::Bot::Client.run(token) do |bot|
  pre_init(bot)
  init(bot)
  run_a_game(bot)
end
