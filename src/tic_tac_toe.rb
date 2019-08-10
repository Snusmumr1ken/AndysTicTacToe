#!/usr/bin/ruby
# frozen_string_literal: true

require 'telegram/bot'
require_relative 'init'
require_relative 'pre_init'

token = '810797047:AAHJ__oVXVBP6teg1i3hI4I48xsBcxZQexg'

Telegram::Bot::Client.run(token) do |bot|
  pre_init(bot)
  init(bot)
end
