# frozen_string_literal: true

def say_crosses(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Great, #{message.from.first_name}! You will play for crosses!"
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end

def say_noughts(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Great, #{message.from.first_name}! You will play for noughts!"
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end

def say_unknown(bot, message)
  mess = 'Say for whom do you wanna play, motherfucker!'
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end

def init(bot)
  bot.listen do |message|
    case message.text
    when 'Crosses'
      say_crosses(bot, message)
    when 'Noughts'
      say_noughts(bot, message)
    else
      say_unknown(bot, message)
    end
  end
end
