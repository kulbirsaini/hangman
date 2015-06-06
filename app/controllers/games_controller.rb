class GamesController < ApplicationController
  before_action :set_game, only: [:show, :guess]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @current_word = @game.current_word
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_path(@game, format: :html), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { redirect_to games_path(format: :html), notice: 'Failed to create new game.' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /games/1
  # POST /games/1.json
  def guess
    char = game_params[:char]
    @guess_status = process_guess(char)
    message = verbose_message_for(@guess_status)
    respond_to do |format|
      format.html { redirect_to game_path(@game, format: :html), notice: message[:notice] }
      format.json { render :guess, status: message[:status] }
    end
  end

  private

    def verbose_message_for(message)
      case message
      when :invalid_char
        { notice: 'Invalid character', status: :ok }
      when :already_guessed
        { notice: 'Character already guessed', status: :ok }
      when :failed
        { notice: 'Game failed', status: :ok }
      when :success
        { notice: 'Successfully guessed the word', status: :ok }
      when :errors
        { notice: 'Error while processing guess', status: :unprocessable_entity }
      when :incorrect
        { notice: 'Incorrect guess', status: :ok }
      when :correct
        { notice: 'Correct guess', status: :ok }
      when :already_over
        { notice: 'Game already completed', status: :ok }
      else
        { notice: 'Unknown game status', status: :ok }
      end
    end

    def process_guess(char)
      return :already_over unless @game.busy?
      return :invalid_char unless char.present? && ('a'..'z').member?(char)

      return :already_guessed if @game.guessed_chars.present? && @game.guessed_chars.include?(char)

      correct_guess = true
      @game.guessed_chars = (@game.guessed_chars || '') + char
      unless @game.word.include?(char)
        @game.tries_left -= 1 
        correct_guess = false
      end
      if @game.current_word.include?('.')
        @game.status = 'fail' if @game.tries_left == 0
      else
        @game.status = 'success'
      end
      @game.save
      @game.reload

      return :failed if @game.failed?
      return :success if @game.success?
      return :errors if @game.errors.present?
      return :correct if correct_guess
      return :incorrect
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:char)
    end
end
