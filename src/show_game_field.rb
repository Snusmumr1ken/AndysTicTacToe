# frozen_string_literal: true

def create_line(field, num_of_line)
  (0..2).each do |i|
    @line = if field[num_of_line][i].zero
              '◻️'
            elsif field[num_of_line][i] == 1
              '❎'
            else
              '🅾️'
            end
    @line += ' | ' if i != 2
  end
end

def show_game_field(bot, field)
  mess = create_line(field, 0)
  bot.api.send_message(chat_id: message.chat.id, text: mess)
  mess = create_line(field, 1)
  bot.api.send_message(chat_id: message.chat.id, text: mess)
  mess = create_line(field, 2)
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end
