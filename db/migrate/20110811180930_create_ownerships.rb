class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :territory_id
      t.integer :participation_id
      t.integer :game_id
      t.integer :units_count, default: 0

      t.timestamps
    end
  end
end
