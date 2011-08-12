class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.text :path
      t.integer :badge_offset_x
      t.integer :badge_offset_y
      t.integer :level

      t.timestamps
    end
  end
end
