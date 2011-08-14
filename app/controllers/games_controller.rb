class GamesController < ApplicationController
  layout 'game'
  
  # Find an appropriate game for the player.
  def find
    @game = Game.not_full.without(current_user).sample || Game.create
    @game.users << current_user
    
    redirect_to @game
  end
  
  
  # Show the game page.
  def show
    @participation = current_user.participations.find_by_game_id(params[:id])
    @ownerships    = @participation.ownerships.includes(:territory, :participation)
    @game          = @participation.game
    @territories   = Territory.all
    
    render @game.state.downcase
  end
end
