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
    @game = current_user.games.find(params[:id])
    @territories = Territory.all
  end
end
