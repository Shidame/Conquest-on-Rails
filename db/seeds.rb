# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Territories.
path = Rails.root.join("config", "territories.yml")
territories_attributes = YAML.load(File.read(path))

territories_attributes.each do |territory_attributes|
  # It would fail if the neighbour ids point to yet inexisting territories. 
  # We deep clone the hash to not lose "neighbour_ids" forever.
  attributes = territory_attributes.clone
  attributes.delete("neighbour_ids")
  
  t = Territory.find_or_create_by_id(attributes["id"])
  t.update_attributes!(attributes)
end

territories_attributes.each do |territory_attributes|
  t = Territory.find(territory_attributes["id"])
  t.neighbour_ids = territory_attributes["neighbour_ids"]
  t.save!
end
