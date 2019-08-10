def when_start(bot, message)
  mess = "Hello, #{message.from.first_name}!😊\nThis is __Tic-tac-toe game__ created by Andrii Nyvchyk.\nDo you wanna play?😏"
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Yes), %w(No)], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: answers, parse_mode: 'Markdown')
end

def when_yes(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: 'Great!', reply_markup: kb)
  question = 'Do you want to play for crosses or noughts?'
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Crosses), %w(Noughts)], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
end

def when_no(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Sorry to see you go :(\nWrite /start to run me again."
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end

def say_unknown(bot, message)
  mess = "Say 'Yes' or 'No', motherfucker!"
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end

def pre_init(bot)
  bot.listen do |message|
    case message.text
    when '/start'
      when_start(bot, message)
    when 'Yes'
      when_yes(bot, message)
      break
    when 'No'
      when_no(bot, message)
    else
      say_unknown(bot, message)
    end
  end
end