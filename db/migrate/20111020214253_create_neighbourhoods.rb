class CreateNeighbourhoods < ActiveRecord::Migration
  def change
    create_table :neighbourhoods do |t|
      t.integer :territory_id
      t.integer :other_territory_id

      t.timestamps
    end
  end
end
