$ ->
  myColor        = $('#map').data('me')
  animationSpeed = 300
  
  
  $('.badges .mine').click (event)->
    $attacker    = $(this)
    attackerId   = badgeDomIdToId($attacker.attr('id'))
    neighbourIds = $attacker.data('neighbour_ids')
    
    $(".badges li").each (index, el)->
      $target  = $(el)
      targetId = badgeDomIdToId($target.attr('id'))
      
      isAttacker   = attackerId == targetId
      
      isEnemy      = !$target.hasClass("mine")
      isNeighbour  = $.inArray(targetId, neighbourIds) != -1
      isAttackable = isEnemy && isNeighbour
      
      if isAttacker
        # The attacker is highlighted.
        $target.animate({ opacity: 1 }, animationSpeed)
        
      else if isAttackable
        # Attackable territories are highlighted too.
        $target.animate({ opacity: 1 }, animationSpeed)
        
      else unless isEnemy
        # Player's territories are still quite visible.
        $target.animate({ opacity: 0.75 }, animationSpeed)
        
      else
        # Other are less visible.
        $target.animate({ opacity: 0.3 }, animationSpeed)
        
    false
    
    
  badgeDomIdToId = (domId)->
    parseInt(domId.replace("badge_territory_", ""))
