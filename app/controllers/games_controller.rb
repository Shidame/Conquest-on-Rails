class GamesController < ApplicationController
  def find
    @game = Game.not_full.without(current_user).sample || Game.create
    @game.users << current_user
    
    redirect_to @game
  end
end
