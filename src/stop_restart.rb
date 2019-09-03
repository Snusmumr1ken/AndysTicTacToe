# frozen_string_literal: true

def restart(bot, bd, message, maps)
  change_status(bd, message.chat.id, 'pvp_or_pve')
  del_map(maps, message.chat.id)
  i = get_iter(bd, message.chat.id)
  bd[i][2] = 0
  mess1 = "Okay, #{message.from.first_name}!\nHow do you wanna play?😊\n\n"
  mess2 = "PVP - Player versus Player\nPVE - Player versus Computer"
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w[PVP], %w[PVE]])
  bot.api.send_message(chat_id: message.chat.id, text: mess1 + mess2, reply_markup: answers)
end

def stop(bot, bd, message, maps)
  del_map(maps, message.chat.id)
  i = get_iter(bd, message.chat.id)
  bd.delete_at(i)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Okay, #{message.from.first_name}, see you later! Write /start when you will be ready to play again."
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end
