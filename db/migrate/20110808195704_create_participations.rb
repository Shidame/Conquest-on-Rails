class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :color
      t.boolean :alive, default: false
      t.integer :units_count, default: 0
      t.integer :position

      t.timestamps
    end
  end
end
