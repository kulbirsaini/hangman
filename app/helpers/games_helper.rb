module GamesHelper
  def button_disabled?(game, char)
    return true unless game.busy?
    game.guessed_chars.present? && game.guessed_chars.include?(char)
  end

  def get_button_type(game, current_word, char)
    return 'primary' unless button_disabled?(game, char)
    return 'success' if current_word.include?(char)
    return 'danger'
  end
end
