module GamesHelper
  def json_for_badge(ownership)
    JSON.dump({
      offsets: {
        x: ownership.territory.badge_offset_x,
        y: ownership.territory.badge_offset_y
      },
      territoryId: ownership.territory.id,
      unitsCount:  ownership.units_count,
      color:       ownership.participation.color
    })
  end
  
  
  def json_for_participation(participation)
    JSON.dump({
      unitsCount: participation.units_count,
      color:      participation.color
    })
  end
  
  
  def classes_for_badge(ownership)
    [
      ownership.participation.color,
      ownership.participation == current_participation && :mine
    ]
  end
end
