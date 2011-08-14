class window.BadgesPool
  constructor: ->
    @badges = {}

  get: (id)->
    @badges[id]

  set: (id, element)->
    @badges[id] = element



window.Badge =
  size: 32
  colorCodes:
    blue:   "#67aaff"
    green:  "#b8ff65"
    orange: "#ffb459"
    purple: "#dc73ff"
    yellow: "#f9ff7c"

  draw: (paper, label, color)->
    colorCode = @colorCodes[color]
    x = y = @size/2

    outerCircle = paper.circle(x, y, 14)
    outerCircle.attr
      "stroke-width": 2
      "stroke":       "#333"
      "fill":         colorCode

    innerCircle = paper.circle(x, y, 10)
    innerCircle.attr
      "fill": "#333"

    text = paper.text(x, y - 2, label)
    text.attr
      "font-family": "Georgia"
      "font-size":   12
      "fill":        "white"
