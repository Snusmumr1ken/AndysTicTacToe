# frozen_string_literal: true

def go_pvp(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: "Great!\nLet the game begin!", reply_markup: kb)
end

def go_pve(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: 'Great!', reply_markup: kb)
  question = 'Do you want to play for crosses or noughts?'
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w[Crosses], %w[Noughts]], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
end

# 1 - pvp
# 2 - pve
def decide_pvp_or_pve(bot, map)
  bot.listen do |message|
    case message.text
    when 'PVP'
      go_pvp(bot, message)
      show_game_field(bot, message, map)
      return 1
    when 'PVE'
      go_pve(bot, message)
      return 2
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      say_unknown_command(bot, message)
    end
  end
end
