# frozen_string_literal: true

def player_is_ready(bot, message)
  field = "| ◻️ | ◻️ | ◻️ |\n| ◻️ | ◻️ | ◻️ |\n| ◻️ | ◻️ | ◻️ |"
  bot.api.send_message(chat_id: message.chat.id, text: field)
end

def show_game_field(bot, message)
  mess = "Here is your game field, #{message.from.first_name}."
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(1 2 3), %w(4 5 6), %w(7 8 9), %w(/stop)])
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers)
end

def run_a_game(bot)
  bot.listen do |message|
    case message.text
    when 'Ready'
      show_game_field(bot, message)
      player_is_ready(bot, message)
    when '/stop'
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(', reply_markup: kb)
    else
      say_unknown_command(bot, message)
    end
  end
end