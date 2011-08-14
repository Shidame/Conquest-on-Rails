class AddDeploymentFinishAtToGames < ActiveRecord::Migration
  def change
    add_column :games, :deployment_finish_at, :datetime
  end
end
