# frozen_string_literal: true

def show_ready_button(bot, message)
  mess = 'Tell me when you will be ready.'
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Ready)], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers)
end

def say_crosses(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Great, #{message.from.first_name}! You will play for crosses!"
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
  show_ready_button(bot, message)
end

def say_noughts(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Great, #{message.from.first_name}! You will play for noughts!"
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
  show_ready_button(bot, message)
end

def init(bot)
  bot.listen do |message|
    case message.text
    when 'Crosses'
      say_crosses(bot, message)
      break
    when 'Noughts'
      say_noughts(bot, message)
      break
    when 'stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      say_unknown_command(bot, message)
    end
  end
end
