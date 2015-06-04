json.array!(@games) do |game|
  json.extract! game, :id, :tries_left, :guessed_chars, :status
  json.word game.current_word
  json.url game_url(game, format: :json)
end
