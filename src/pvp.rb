# frozen_string_literal: true

def pvp_setup(bd, bot, message, maps)
  if check_status(bd, message.chat.id, 'pvp_or_pve') == 1
    change_status(bd, message.chat.id, "pvp")
    map = Map.new(message.chat.id)
    maps << map
    kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: "Great!\nGood luck!", reply_markup: kb)
    show_game_field(bot, message, map)
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'STATUS PVP_OR_PVE_NEEDED')
  end
end

def pvp_game(bd, bot, message, maps, user1, user2)
  i = get_map(maps, message.chat.id)
  if maps[i].dot_empty?(message.text)
    iter = get_iter(bd, message.chat.id)
    user1.move(maps[i], message.text) if bd[iter][2].even?
    user2.move(maps[i], message.text) if bd[iter][2].odd?
    bd[iter][2] += 1
    if check_end(bot, message, maps[i], bd) == 1
      bd[iter][2] = 0
      del_map(maps, message.chat.id)
      return 0
    end
    show_game_field(bot, message, maps[i])
  end
end
