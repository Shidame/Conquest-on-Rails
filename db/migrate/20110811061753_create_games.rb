class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :state
      t.integer :participations_count

      t.timestamps
    end
  end
end
