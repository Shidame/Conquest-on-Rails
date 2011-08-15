$ ->
  badgeSide = null
  $("#ownerships li").each (index, element)->
    $element  = $(element)
    ownership = $element.data('ownership')
    badgeSide ||= $element.width()

    $element.css
      left: ownership.offsets.x - badgeSide / 2
      top:  ownership.offsets.y - badgeSide / 2
