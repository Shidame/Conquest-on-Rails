$ ->
  $('#map').each (index, element)->
    $element   = $(element)
    badges     = {}

    for ownership in $element.data('ownerships')
      index = ownership.territoryId
      badges[index] = Raphael(element, Badge.size, Badge.size)

      $(badges[index].canvas).css
        left: ownership.offsets.x - Badge.size/2
        top:  ownership.offsets.y - Badge.size/2

      Badge.draw(badges[index], ownership.unitsCount, ownership.color)
