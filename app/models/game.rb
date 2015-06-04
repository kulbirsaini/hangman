class Game < ActiveRecord::Base
  before_validation :set_defaults, on: :create

  validates :word, presence: true, format: { with: /[a-z]/, message: 'should contain only lowercase alphabets' }
  validates :guessed_chars, format: { with: /[a-z]/, message: 'should contain only lowercase alphabets' }, if: "guessed_chars.present?"
  validates :tries_left, presence: true, numericality: { only_integer: true, greater_than: -1, less_than_or_equal_to: Rails.application.config.x.max_tries }
  validates :status, inclusion: { in: ['busy', 'fail', 'success'] }, if: "status.present?"

  def busy?
    status == 'busy'
  end

  def failed?
    status == 'fail'
  end

  def success?
    status == 'success'
  end

  def current_word
    busy? ? word.gsub(/[^#{guessed_chars} ]/, '.') : word
  end

  private

  def set_defaults
    self.word = Rails.application.config.x.words.sample
    self.tries_left = Rails.application.config.x.max_tries
    self.guessed_chars = ''
    self.status = 'busy'
  end
end
