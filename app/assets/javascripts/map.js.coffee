$ ->
  myColor        = $('#map').data('me')
  animationSpeed = 300
  
  
  $('.badges .mine').click (event)->
    $attacker    = $(this)
    attackerId   = badgeDomIdToId($attacker.attr('id'))
    
    neighbourIds = $attacker.data('neighbour_ids')
    unitsCount   = $attacker.data('units_count')
    canAttack    = 1 < unitsCount
    
    $(".badges li").each (index, el)->
      $target      = $(el)
      targetId     = badgeDomIdToId($target.attr('id'))
      
      isAttacker   = attackerId == targetId
      isEnemy      = !$target.hasClass("mine")
      isNeighbour  = $.inArray(targetId, neighbourIds) != -1
      isAttackable = isEnemy && isNeighbour && canAttack
      
      # The attacker is highlighted.
      if isAttacker
        $target.animate({ opacity: 1 }, animationSpeed)
        
      # Attackable territories are highlighted too.
      else if isAttackable
        $target.animate({ opacity: 1 }, animationSpeed)
        
      # Player's territories are still quite visible.
      else unless isEnemy
        $target.animate({ opacity: 0.75 }, animationSpeed)
        
      # Other are less visible.
      else
        $target.animate({ opacity: 0.3 }, animationSpeed)
        
    false
    
    
  badgeDomIdToId = (domId)->
    parseInt(domId.replace("badge_territory_", ""))
