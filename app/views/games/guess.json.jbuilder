json.extract! @game, :id, :tries_left, :guessed_chars, :status
json.word @game.current_word
json.guess_status @guess_status
json.url game_url(@game)
