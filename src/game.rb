# frozen_string_literal: true

def show_game_field(bot, message)
  mess = "Here is your game field, #{message.from.first_name}."
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(1 2 3), %w(4 5 6), %w(7 8 9)])
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers)
end

def run_a_game(bot)
  bot.listen do |message|
    case message.text
    when 'Ready'
      show_game_field(bot, message)
    when '/stop'
      stop(bot, message)
    else
      say_unknown_command(bot, message)
    end
  end
end