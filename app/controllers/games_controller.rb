class GamesController < ApplicationController
  layout 'game'
  helper_method :current_participation
  
  # Find an appropriate game for the player.
  def find
    @participation = current_user.send_in_game!
    Juggernaut.publish("games/#{@participation.game_id}", {
      eventType: "PLAYER_JOIN",
      color:     @participation.color,
      gameId:    @participation.game_id
    })
    
    redirect_to dashboard_path
  end
  
  
  # Show the game page.
  def show
    @game           = current_participation.game
    @participations = @game.participations.includes(:user, :ownerships)
    @ownerships     = @game.ownerships.includes { [ territory.neighbours, participation ] }
    @territories    = Territory.all
    
    render @game.state.downcase
  end
  
  
  private
  
  def current_participation
    @current_participation ||= current_user.participations.find_by_game_id(params[:id])
  end
end
