# frozen_string_literal: true

def build_map_str(map)
  str = ' '
  (0..2).each do |i|
    (0..2).each do |j|
      str += case map[i, j]
             when 0
               "◻️  "
             when 1
               "❎  "
             when 2
               "🅾️  "
             else
               'something went really wrong'
             end
      str += '|  ' if j != 2
    end
    str += "\n"
    str += "➖➕➖➕➖\n" if i != 2
  end
  str
end

def show_game_field(bot, message, map)
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(1 2 3), %w(4 5 6), %w(7 8 9)])
  mess_map = build_map_str(map)
  bot.api.send_message(chat_id: message.chat.id, text: mess_map, reply_markup: answers)
end