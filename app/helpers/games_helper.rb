module GamesHelper
  def json_for_badges(ownerships)
    data = ownerships.map do |ownership|
      {
        offsets: {
          x: ownership.territory.badge_offset_x,
          y: ownership.territory.badge_offset_y
        },
        territoryId: ownership.territory.id,
        unitsCount:  ownership.units_count,
        color:       ownership.participation.color
      }
    end
    
    JSON.dump(data)
  end
end
