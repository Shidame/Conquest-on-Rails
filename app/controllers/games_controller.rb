class GamesController < ApplicationController
  layout 'game'
  helper_method :current_participation
  
  # Find an appropriate game for the player.
  def find
    @game = Game.not_full.without(current_user).sample || Game.create
    @game.users << current_user
    
    redirect_to @game
  end
  
  
  # Show the game page.
  def show
    @game        = current_participation.game
    @ownerships  = @game.ownerships.includes(:territory, :participation)
    @territories = Territory.all
    
    render @game.state.downcase
  end
end
