Rails.application.config_for(:hangman).each do |key, value|
  Rails.application.config.x.send(key + '=', value)
end

Rails.application.config.x.words = open(Rails.root.join(Rails.application.config.x.words_file)).read.split(',')
