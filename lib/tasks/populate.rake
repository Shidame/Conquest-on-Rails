namespace :populate do
  desc "Create territories."
  task :territories  => :environment do
    data_file_path = Rails.root.join("config", "territories.yml")
    data_as_yaml   = File.read(data_file_path)
    data           = YAML.load(data_as_yaml)
    
    data.each_with_index do |attributes, index|
      Territory.find_or_create_by_id(
        index + 1,
        path:  attributes["path"],
        level: attributes["level"],
        badge_offset_x: attributes["badge_offset_x"],
        badge_offset_y: attributes["badge_offset_y"]
      )
    end
  end
end
