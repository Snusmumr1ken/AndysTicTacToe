#!/usr/bin/ruby
# frozen_string_literal: true

require 'telegram/bot'
require_relative 'init'
require_relative 'pre_init'

token = 'privacy our basis'

Telegram::Bot::Client.run(token) do |bot|
  pre_init(bot)
  init(bot)
end
