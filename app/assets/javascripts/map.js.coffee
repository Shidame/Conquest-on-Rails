$ ->
  myColor        = $("#map").data("me")
  animationSpeed = 300
  
  $("map area").click ->
    false
    
    
    
  $("body").delegate ".badges .mine", "click", ->
    $attacker    = $(this)
    attackerId   = badgeDomIdToId($attacker.attr("id"))
    
    neighbourIds = $attacker.data("neighbour_ids")
    unitsCount   = $attacker.data("units_count")
    canAttack    = 1 < unitsCount
    
    # Go back to the global view if the user click again on the territory.
    currentAttackerState = $attacker.attr("data-state") || null
    useGlobalView        = currentAttackerState == "attacker"
    
    $(".badges li").each (index, el)->
      $target      = $(el)
      targetId     = badgeDomIdToId($target.attr("id"))
      
      # The global view doesn't highlight any territory.
      if useGlobalView
        $target.attr("data-state", null)
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
          $target.attr("data-state", "attacker")
          $target.animate({ opacity: 1 }, animationSpeed)
          
        # Attackable territories are highlighted too.
        else if isAttackable
          $target.attr("data-state", "targetable")
          $target.animate({ opacity: 1 }, animationSpeed)
          
        # Player"s territories are still quite visible.
        else unless isEnemy
          $target.attr("data-state", "ally")
          $target.animate({ opacity: 0.75 }, animationSpeed)
          
        # Other are less visible.
        else
          $target.attr("data-state", "useless")
          $target.animate({ opacity: 0.3 }, animationSpeed)
          
          
          
  # Return to the global view when a non-attackable territory is clicked.
  $("body").delegate ".badges li[data-state='useless']", "click", ->
    $(".badges li").each (index, el)->
      $target = $(el)
      $target.attr("data-state", null)
      $target.animate({ opacity: 1 }, animationSpeed)
      
      
      
  $("body").delegate ".badges li[data-state='targetable']", "click", ->
    $target    = $(this)
    attackPath = $target.data("attack_path")
    
    $.post(attackPath)
    
    
    
  badgeDomIdToId = (domId)->
    parseInt(domId.replace("badge_territory_", ""))
