jQuery ($) ->
  return unless canvas = $("#canvas").get(0)
  console.log(canvas)
  width = 1
  context = canvas.getContext("2d")
  context.strokeStyle = "rgba(0, 0, 0, 0.5)"

  point = (e) ->
    rect = e.target.getBoundingClientRect()
    [e.clientX - rect.left, e.clientY - rect.top]

  beginPoint = false

  draw = (e) ->
    return unless beginPoint
    context.beginPath()
    [x, y] = beginPoint
    context.moveTo(x, y)
    context.lineWidth = width
    currentPoint = point(e)
    [_x, _y] = currentPoint
    context.lineTo(_x, _y)
    context.closePath()
    context.stroke()
    beginPoint = currentPoint

  canvas.onmousedown = (e) -> beginPoint = point(e)
  canvas.onmouseup   = () -> beginPoint = false
  canvas.onmousemove = draw

  canvas.onmouseout = (e) ->
    draw(e)
    beginPoint = false


