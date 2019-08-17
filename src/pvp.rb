# frozen_string_literal: true

# i == 0 - ничья
# i == 1 - крестики выиграли
# i == 2 - нолики выиграли

def first_player_move(bot, first_player, map)
  bot.listen do |message|
    case message.text
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      first_player.move(map, message.text)
      show_game_field(bot, message, map)
      break
    end
  end
end

def pvp_loop(bot, map, user1, user2)
  counter = 0
  bot.listen do |message|
    case message.text
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      counter.odd? ? user1.move(map, message.text) : user2.move(map, message.text)
      counter += 1
      check_end(bot, message, map)
      show_game_field(bot, message, map)
    end
  end
end
