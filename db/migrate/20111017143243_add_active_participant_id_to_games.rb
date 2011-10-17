class AddActiveParticipantIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :active_participation_id, :integer
    add_column :games, :turn_finish_at, :datetime
    add_column :games, :turn, :integer, :default => 0
  end
end
