$ ->
  myColor = $('#map').data('me')
  
  $("#badges li").each (index, element)->
    $element  = $(element)
    $list     = $element.parent()
    ownership = $element.data('ownership')
    opacity   = if myColor == ownership.color then 1 else 0.55
    
    shift ?= $element.width() / 2
    $element.css
      left:    ownership.offsets.x - shift
      top:     ownership.offsets.y - shift
      opacity: opacity
      
      
  $("#badges li").bind 'ajax:beforeSend', (event, xhr, settings)->
    xhr.abort() unless $(this).hasClass('mine')
    
    
  $("#badges li").bind 'ajax:success', (event, deploymentSucceed, type)->
    if deploymentSucceed
      $element      = $(this)
      $list         = $element.parent()
      ownership     = $element.data('ownership')
      $badge        = $("#badge_territory_#{ownership.territoryId}")
      $link         = $badge.find('a')
      participation = $list.data('participation')
      unitsCount    = parseInt($badge.text()) + 1
      
      $link.text(unitsCount)
      
      $('.remaining_units_count').each (index, element)->
        $element            = $(element)
        remainingUnitsCount = parseInt($element.text()) - 1
        
        $element.text(remainingUnitsCount)
        participation.unitsCount = remainingUnitsCount
