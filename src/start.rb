# frozen_string_literal: true

def start(bot)
  bot.listen do |message|
    case message.text
    when '/start'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!😊", reply_markup: kb)
      mess = "This is Tic-tac-toe game created by Andrii Nyvchyk.\nDo you wanna play?😏"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [%w[Yes], %w[No]], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers)
      break
    end
  end
end
