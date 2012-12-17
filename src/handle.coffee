
q = (id) -> document.querySelector id
log = -> console.log.apply console, arguments

window.onload = ->
  video = q "#video"
  player = q "#player"
  timeline = q "#timeline"
  stop = q "#step"
  volume = q "#volume"
  current = q "#current"
  length = q "#length"
  play = q "#play"

  video.loop = yes
  # video.pause()

  width = video.clientWidth
  player.style.width = "#{width}px"

  video.addEventListener "timeupdate", (playing) ->
    now = video.currentTime
    all = video.duration
    percent =  now / all * 100
    step.style.width = "#{percent}%"
    current.innerText = video.currentTime.toFixed()
    length.innerText = video.duration.toFixed()

  timeline.onclick = (click) ->
    x = click.x
    base = timeline.offsetLeft + timeline.offsetParent.offsetLeft
    whole = timeline.clientWidth
    before = x - base
    percent = before / whole * 100
    log x, base, before, whole, percent
    video.currentTime = video.duration * percent / 100
    step.style.width = "#{percent}%"

  current.onmousewheel = (scroll) ->
    delta = scroll.wheelDelta / 60
    value = (Number current.innerText) + delta
    if value < 0 then value = 0
    else if value > video.duration then value = video.duration
    video.currentTime = value

  volume.onmousewheel = (scroll) ->
    delta = scroll.wheelDelta / 120
    value = (Number volume.innerText) + delta
    if value < 0 then value = 0
    else if value > 100 then value = 100
    volume.innerText = String value
    video.volume = value / 100
    localStorage.volume = String value

  do ->
    if localStorage.volume?
      value = Number localStorage.volume
      video.volume = value / 100
      volume.innerText = String value

  volume.onclick = (click) ->
    if video.muted
      video.muted = no
      volume.className = ""
    else
      video.muted = yes
      volume.className = "muted"

  play.onclick = ->
    if video.paused
      video.play()
      play.innerText = "Pause"
    else
      video.pause()
      play.innerText = "Play"

  control.onmousewheel = (scroll) ->
    scroll.returnValue = false