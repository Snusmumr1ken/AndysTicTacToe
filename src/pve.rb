# frozen_string_literal: true


def mv(map, mess, figure)
  case mess
  when '1'
    place_1(map, figure)
  when '2'
    place_2(map, figure)
  when '3'
    place_3(map, figure)
  when '4'
    place_4(map, figure)
  when '5'
    place_5(map, figure)
  when '6'
    place_6(map, figure)
  when '7'
    place_7(map, figure)
  when '8'
    place_8(map, figure)
  when '9'
    place_9(map, figure)
  end
end

def pve_setup(bd, bot, message)
  if check_status(bd, message.chat.id, 'pvp_or_pve') == 1
    change_status(bd, message.chat.id, 'cr_or_no')
    mess = 'Do you want to play for crosses or noughts?'
    ans =
      Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [%w[Crosses], %w[Noughts]], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: ans)
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'STATUS PVP_OR_PVE_NEEDED')
  end
end

def pve_game(bd, bot, message, maps, pve_bot)
  i = get_map(maps, message.chat.id)
  iter = get_iter(bd, message.chat. id)
  if maps[i].dot_empty?(message.text)
    if bd[iter][2] == 1 ## choose figure to move
      mv(maps[i], message.text, 1)
    elsif bd[iter][2] == 2
      mv(maps[i], message.text, 2)
    end
    if check_end(bot, message, maps[i], bd) == 1 ## check if user didn't win
      del_map(maps, message.chat.id)
      return 0
    end
    pve_bot.set_figure(2) if bd[iter][2] == 1
    pve_bot.set_figure(1) if bd[iter][2] == 2
    pve_bot.hard_move(maps[i])
    if check_end(bot, message, maps[i], bd) == 1
      del_map(maps, message.chat.id)
      return 0
    end
    show_game_field(bot, message, maps[i])
  end
end
