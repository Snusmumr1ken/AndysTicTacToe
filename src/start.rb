# frozen_string_literal: true

def start(bot)
  bot.listen do |message|
    case message.text
    when '/start'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!😊", reply_markup: kb)
      mess1 = "This is Tic-tac-toe game created by Andrii Nyvchyk.\n\nHow do you wanna play?😏\n\n"
      mess2 = "PVP - Player versus Player\nPVE - Player versus Computer"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [%w[PVP], %w[PVE]], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: mess1 + mess2, reply_markup: answers)
      break
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'Please, write /start now.')
    end
  end
end
