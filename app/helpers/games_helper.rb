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
end
