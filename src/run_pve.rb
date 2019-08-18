# frozen_string_literal: true

def run_pve(bot, map, easy_bot)
  bot.listen do |message|
    case message.text
    when 'Ready'
      easy_bot.easy_move(map) if easy_bot.read_figure == 1
      show_game_field(bot, message, map)
      break
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      say_unknown_command(bot, message)
    end
  end
end
