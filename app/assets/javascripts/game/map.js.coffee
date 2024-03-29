$ ->
  myColor        = $("#map").data("me")
  animationSpeed = 300
  
  $("map area").click ->
    false
    
    
    
  $("body").delegate ".badges .mine", "click", ->
    hideAttackBox()
    
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
    hideAttackBox()
    
    $(".badges li").each (index, el)->
      $target = $(el)
      $target.attr("data-state", null)
      $target.animate({ opacity: 1 }, animationSpeed)
      
      
      
  # Show the attack box when a target is chosen among targetable ones.
  # Other targetable territories become useless.
  $("body").delegate ".badges li[data-state='targetable']", "click", (event)->
    $attacker  = $(".badges li[data-state='attacker']")
    $target    = $(this)
    targetId   = badgeDomIdToId($target.attr("id"))
    
    $target.attr("data-state", "targeted")
    
    $(".badges li[data-state='targetable']").each (index, el)->
      $targetable  = $(el)
      targetableId = badgeDomIdToId($targetable.attr("id"))
      
      if targetableId != targetId
        $targetable.attr("data-state", "useless")
        $targetable.animate({ opacity: 0.3 }, animationSpeed)
        
    $attackBox = buildAttackBox($attacker, $target)
    
    
    
  $("body").delegate ".badges li[data-state='targeted']", "click", (event)->
    $attacker      = $(".badges li[data-state='attacker']")
    $target        = $(this)
    targetId       = badgeDomIdToId($target.attr("id"))
    path           = $attacker.data("attack_path")
    attackersCount = getAttackBoxValue()
    
    $.post(path, target_id: targetId, attackers_count: attackersCount)
    
    # Go back to the global view.
    $attacker.trigger('click')
    
    
  # Extract the territory id from the badge DOM id.
  badgeDomIdToId = (domId)->
    parseInt(domId.replace("badge_territory_", ""))
    
    
    
  # Find the attacker box in the DOM or create it.
  findOrCreateAttackBox = ->
    if $("#attack_box")[0]
      $("#attack_box")
    else
      $el = $("<div />", id: "attack_box").hide()
      $el.appendTo($("body"))
      
      
      
  hideAttackBox = ->
    $("#attack_box").fadeOut animationSpeed, ->
      $(this).remove()
      
      
      
  getAttackBoxValue= ->
    parseInt($("#attack_box span").text())
    
    
    
  # Build the widget to chose the number of attackers.
  buildSpinner = ($attacker, $target)->
    attackerUnitsCount    = $attacker.data("units_count")
    targetUnitsCount      = $target.data("units_count")
    maximumAttackersCount = attackerUnitsCount - 1
    
    $spinner = $("<div />").data("maximum_count", maximumAttackersCount)
      
      
    $minus = $('<a class="minus">−</a>').click ->
      $counter = $(this).siblings("span")
      count    = parseInt($counter.text())
      newCount = if count == 1 then 1 else count - 1
      
      $($counter).text(newCount)
      
      
    $plus = $('<a class="plus">+</a>').click (event)->
      $counter     = $(this).siblings("span")
      count        = parseInt($counter.text())
      maximumCount = parseInt($(this).parent().data("maximum_count"))
      newCount     = if count == maximumCount then count else count + 1
      
      $($counter).text(newCount)
      
      
    $counter = $("<span />").text(maximumAttackersCount)
    
    $spinner.append($minus, $counter, $plus)
    
    
    
  # Create the attack box and put it at the right of the target.
  buildAttackBox = ($attacker, $target)->
    $box     = findOrCreateAttackBox()
    $content = buildSpinner($attacker, $target)
    
    $box
      .html($content)
      .fadeIn(animationSpeed)
      .position
        my: "left"
        at: "right"
        of: $target
