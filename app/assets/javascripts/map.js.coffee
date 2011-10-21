$ ->
  myColor        = $("#map").data("me")
  animationSpeed = 300
  
  
  $(".badges .mine").click (event)->
    $attacker    = $(this)
    attackerId   = badgeDomIdToId($attacker.attr("id"))
    
    neighbourIds = $attacker.data("neighbour_ids")
    unitsCount   = $attacker.data("units_count")
    canAttack    = 1 < unitsCount
    
    # Go back to the global view if the user click again on the territory.
    currentAttackerState = $attacker.data("state") || null
    useGlobalView        = currentAttackerState == "attacker"
    
    $(".badges li").each (index, el)->
      $target      = $(el)
      targetId     = badgeDomIdToId($target.attr("id"))
      
      # The global view doesn't highlight any territory.
      if useGlobalView
        $target.removeData("state")
        $target.animate({ opacity: 1 }, animationSpeed)
        
      # The attack view changes territories appearance according to their
      # attackability.
      else
        isAttacker   = attackerId == targetId
        isEnemy      = !$target.hasClass("mine")
        isNeighbour  = $.inArray(targetId, neighbourIds) != -1
        isAttackable = isEnemy && isNeighbour && canAttack
      
        # The attacker is highlighted.
        if isAttacker
          $target.data("state", "attacker")
          $target.animate({ opacity: 1 }, animationSpeed)
        
        # Attackable territories are highlighted too.
        else if isAttackable
          $target.data("state", "targetable")
          $target.animate({ opacity: 1 }, animationSpeed)
        
        # Player"s territories are still quite visible.
        else unless isEnemy
          $target.data("state", "ally")
          $target.animate({ opacity: 0.75 }, animationSpeed)
        
        # Other are less visible.
        else
          $target.data("state", "useless")
          $target.animate({ opacity: 0.3 }, animationSpeed)
          
    false
    
    
  badgeDomIdToId = (domId)->
    parseInt(domId.replace("badge_territory_", ""))
