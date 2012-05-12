jQuery ($) ->
  return unless canvas = $("#canvas").get(0)
  form = if location.pathname.match(/new$/) then $(".new_article") else $(".edit_article")

  form.on "submit", () ->
    $("#article_picture").val(canvas.toDataURL())

  width = 1
  context = canvas.getContext("2d")
  context.strokeStyle = "rgba(0, 0, 0, 0.5)"
  $("#clear_picture").on "click", () -> context.clearRect(0, 0, canvas.width, canvas.height)

  if article_picture
    picture = new Image()
    picture.src = article_picture
    picture.onload = ->
      context.drawImage(picture, 0, 0)

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
