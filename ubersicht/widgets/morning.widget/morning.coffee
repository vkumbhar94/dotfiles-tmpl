# Colorful Morning Widget - Enhanced with beautiful colors
# Lovingly crafted by Rohan Likhite [rohanlikhite.com]

command: "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ // '"

refreshFrequency: 30000

style: """
  color: #fff
  font-family: -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Arial, sans-serif
  font-smoothing: antialiased

  .container
    position: fixed
    top: 0
    left: 50%
    transform: translateX(-50%)
    text-align: center
    min-width: 300px
    max-width: 90vw
    margin-top: clamp(8px, 1.5vh, 20px)
    z-index: 1000
    padding: 18px 28px
    border-radius: 24px
    background: rgba(0, 0, 0, 0.6)
    backdrop-filter: blur(20px) saturate(180%)
    border: 2px solid rgba(255, 255, 255, 0.15)
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4), 
                0 4px 12px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1)

  .time
    font-size: clamp(3rem, 6vw, 5rem)
    color: #FFFFFF
    font-weight: 700
    text-align: center
    line-height: 1
    margin-bottom: 0.1em
    display: flex
    align-items: center
    justify-content: center
    flex-wrap: wrap
    gap: 0.1em
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.8),
                 0 0 20px rgba(255, 255, 255, 0.2)

  .time-part
    display: inline-block

  .colon
    margin: 0 0.1em
    color: #00D4FF
    text-shadow: 0 0 20px rgba(0, 212, 255, 0.6),
                 0 2px 8px rgba(0, 0, 0, 0.8)

  .half
    font-size: 0.15em
    margin-left: 0.3em
    align-self: flex-start
    margin-top: 0.5em
    color: #00D4FF
    text-shadow: 0 0 15px rgba(0, 212, 255, 0.5),
                 0 2px 6px rgba(0, 0, 0, 0.8)

  .text
    font-size: clamp(1rem, 2.5vw, 2rem)
    font-weight: 700
    line-height: 1.2
    margin-top: -0.2em
    white-space: nowrap
    overflow: hidden
    text-overflow: ellipsis

  .salutation
    margin-right: 0.3em
    color: #FFFFFF
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.8),
                 0 0 15px rgba(255, 255, 255, 0.15)

  .name
    color: #E0E7FF
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.8),
                 0 0 12px rgba(224, 231, 255, 0.3)

  /* Time-based accent colors for better contrast */
  .morning-theme .colon,
  .morning-theme .half
    color: #FFB800
    text-shadow: 0 0 20px rgba(255, 184, 0, 0.6),
                 0 2px 8px rgba(0, 0, 0, 0.8)

  .afternoon-theme .colon,
  .afternoon-theme .half
    color: #00E676
    text-shadow: 0 0 20px rgba(0, 230, 118, 0.6),
                 0 2px 8px rgba(0, 0, 0, 0.8)

  .evening-theme .colon,
  .evening-theme .half
    color: #E91E63
    text-shadow: 0 0 20px rgba(233, 30, 99, 0.6),
                 0 2px 8px rgba(0, 0, 0, 0.8)

  .night-theme .colon,
  .night-theme .half
    color: #9C27B0
    text-shadow: 0 0 20px rgba(156, 39, 176, 0.6),
                 0 2px 8px rgba(0, 0, 0, 0.8)

  /* Enhanced contrast for light wallpapers */
  @media (prefers-color-scheme: light)
    .container
      background: rgba(0, 0, 0, 0.75)
      border: 2px solid rgba(255, 255, 255, 0.25)
      box-shadow: 0 16px 50px rgba(0, 0, 0, 0.5), 
                  0 6px 20px rgba(0, 0, 0, 0.4),
                  inset 0 1px 0 rgba(255, 255, 255, 0.15)

    .time
      text-shadow: 0 3px 12px rgba(0, 0, 0, 0.9),
                   0 0 25px rgba(255, 255, 255, 0.3)

    .salutation
      text-shadow: 0 3px 12px rgba(0, 0, 0, 0.9),
                   0 0 20px rgba(255, 255, 255, 0.2)

    .name
      text-shadow: 0 3px 12px rgba(0, 0, 0, 0.9),
                   0 0 15px rgba(224, 231, 255, 0.4)

  /* Enhanced readability for dark wallpapers */
  @media (prefers-color-scheme: dark)
    .container
      background: rgba(255, 255, 255, 0.08)
      border: 2px solid rgba(255, 255, 255, 0.12)
      box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6), 
                  0 4px 12px rgba(0, 0, 0, 0.4),
                  inset 0 1px 0 rgba(255, 255, 255, 0.08)

  /* High contrast fallback */
  @media (prefers-contrast: high)
    .container
      background: rgba(0, 0, 0, 0.9)
      border: 3px solid #FFFFFF

    .time, .salutation, .name
      color: #FFFFFF
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 1)

    .colon, .half
      color: #00FF00
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 1)

  /* Responsive breakpoints */
  @media (max-width: 768px)
    .container
      max-width: 95vw
      margin-top: clamp(5px, 1vh, 15px)
      padding: 15px 22px

    .time
      font-size: clamp(2.5rem, 8vw, 4rem)

    .text
      font-size: clamp(0.9rem, 3vw, 1.5rem)

  @media (max-width: 480px)
    .container
      margin-top: clamp(3px, 0.8vh, 12px)
      padding: 12px 18px

    .time
      font-size: clamp(2rem, 10vw, 3rem)
      flex-direction: column
      gap: 0

    .text
      font-size: clamp(0.8rem, 3.5vw, 1.2rem)

    .half
      font-size: 0.25em
      margin-left: 0
      margin-top: 0.2em
      align-self: center

  /* MacBook Pro with notch */
  @media screen and (min-width: 1200px) and (max-width: 1800px)
    .container
      margin-top: clamp(12px, 2vh, 25px)

  /* External monitors without notch */
  @media screen and (min-width: 1801px)
    .container
      margin-top: clamp(8px, 1.5vh, 20px)

  /* High DPI displays */
  @media (-webkit-min-device-pixel-ratio: 2), (min-resolution: 192dpi)
    .container
      backdrop-filter: blur(25px) saturate(200%)

  /* Ultra-wide monitors */
  @media (min-width: 2560px)
    .time
      font-size: clamp(8rem, 8vw, 12rem)

    .text
      font-size: clamp(3rem, 3vw, 5rem)
"""

render: -> """
  <div class="container" id="timeContainer">
    <div class="time">
      <span class="time-part hour"></span>
      <span class="time-part colon">:</span>
      <span class="time-part min"></span>
      <span class="half"></span>
    </div>
    <div class="text">
      <span class="salutation"></span>
      <span class="name"></span>
    </div>
  </div>
"""

update: (output, domEl) ->
  # Options: (true/false)
  showAmPm = true
  showName = true
  fourTwenty = false # Smoke Responsibly
  militaryTime = false # Military Time = 24 hour time

  # Time Segments for the day
  segments = ["morning", "afternoon", "evening", "night"]

  # Grab the name of the current user
  name = output.split(' ')

  # Creating a new Date object
  date = new Date()
  hour = date.getHours()
  minutes = date.getMinutes()

  # Quick and dirty fix for single digit minutes
  minutes = "0" + minutes if minutes < 10

  # timeSegment logic
  timeSegment = segments[0] if 4 < hour <= 11
  timeSegment = segments[1] if 11 < hour <= 17
  timeSegment = segments[2] if 17 < hour <= 24
  timeSegment = segments[3] if hour <= 4

  # Apply time-based theme
  container = $(domEl).find('#timeContainer')
  container.removeClass('morning-theme afternoon-theme evening-theme night-theme')
  container.addClass(timeSegment + '-theme')

  # AM/PM String logic
  if hour < 12
    half = "AM"
  else
    half = "PM"

  # 0 Hour fix
  hour = 12 if hour == 0

  # 420 Hour
  if hour == 16 && minutes == 20
    blazeIt = true
  else
    blazeIt = false

  # 24 - 12 Hour conversion
  hour = hour % 12 if hour > 12 && !militaryTime

  # DOM manipulation
  if fourTwenty && blazeIt
    $(domEl).find('.salutation').text("Blaze It")
  else
    $(domEl).find('.salutation').text("Good #{timeSegment}")

  $(domEl).find('.name').text(" , #{name[0]}.") if showName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}")
  $(domEl).find('.half').text("#{half}") if showAmPm && !militaryTime
