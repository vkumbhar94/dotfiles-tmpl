# Mindful Breathing Widget for Übersicht
# Interactive breathing exercise with animated visual guide

command: "cat \"$HOME/Library/Application Support/Übersicht/widgets/mindful-breath.json\""
refreshFrequency: false

style: """
  bottom: 20px
  left: 50%
  transform: translateX(-50%)
  width: 700px
  z-index: 100
  font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace

  .mindful-container
    background: rgba(40, 44, 52, 0.95)
    border: 2px solid #4a5568
    border-radius: 16px
    padding: 20px 25px
    box-shadow: 0 8px 32px rgba(0,0,0,0.5)
    backdrop-filter: blur(10px)
    position: relative
    display: flex
    gap: 25px
    align-items: center

  .mindful-left
    flex: 0 0 180px
    display: flex
    flex-direction: column
    align-items: center
    justify-content: center

  .mindful-right
    flex: 1
    display: flex
    flex-direction: column
    gap: 12px

  .mindful-header
    display: flex
    align-items: center
    justify-content: flex-start
    gap: 8px
    margin-bottom: 0

  .mindful-icon
    font-size: 20px
    filter: drop-shadow(0 0 10px rgba(255,255,255,0.3))

  .mindful-title
    color: #f7fafc
    font-size: 16px
    font-weight: bold
    text-shadow: 0 0 10px rgba(247,250,252,0.4)

  .breath-circle-container
    width: 160px
    height: 160px
    position: relative
    display: flex
    align-items: center
    justify-content: center

  .breath-circle
    width: 100px
    height: 100px
    border-radius: 50%
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
    box-shadow: 0 0 30px rgba(102, 126, 234, 0.6),
                0 0 60px rgba(118, 75, 162, 0.4),
                inset 0 0 20px rgba(255,255,255,0.2)
    position: absolute
    transition: all 0.3s ease

  .breath-circle.breathe-in
    animation: breatheIn var(--duration) ease-in-out

  .breath-circle.hold
    animation: hold var(--duration) ease-in-out

  .breath-circle.breathe-out
    animation: breatheOut var(--duration) ease-in-out

  @keyframes breatheIn
    0%
      transform: scale(1)
      opacity: 0.8
    100%
      transform: scale(2)
      opacity: 1

  @keyframes hold
    0%, 100%
      transform: scale(2)
      opacity: 1

  @keyframes breatheOut
    0%
      transform: scale(2)
      opacity: 1
    100%
      transform: scale(1)
      opacity: 0.8

  .breath-text
    position: absolute
    color: #f7fafc
    font-size: 18px
    font-weight: bold
    text-shadow: 0 2px 10px rgba(0,0,0,0.8)
    z-index: 10
    user-select: none

  .breath-counter
    position: absolute
    bottom: -35px
    left: 50%
    transform: translateX(-50%)
    color: #a0aec0
    font-size: 24px
    font-weight: bold
    text-shadow: 0 0 20px rgba(102, 126, 234, 0.8)

  .technique-info
    text-align: left

  .technique-name
    color: #f7fafc
    font-size: 14px
    font-weight: bold
    margin-bottom: 3px

  .technique-desc
    color: #a0aec0
    font-size: 11px
    font-style: italic

  .control-buttons
    display: flex
    gap: 10px
    justify-content: flex-start
    flex-wrap: wrap

  .btn
    padding: 6px 14px
    border-radius: 6px
    border: none
    font-size: 11px
    font-weight: bold
    cursor: pointer
    transition: all 0.2s ease
    font-family: inherit
    text-transform: uppercase
    letter-spacing: 0.5px

  .btn-start
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
    color: white
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4)

  .btn-start:hover
    transform: translateY(-2px)
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6)

  .btn-stop
    background: rgba(248, 113, 113, 0.8)
    color: white

  .btn-next
    background: rgba(96, 165, 250, 0.8)
    color: white

  .reminder-text
    color: #f7fafc
    font-size: 11px
    padding: 8px 10px
    background: rgba(102, 126, 234, 0.1)
    border-radius: 6px
    border-left: 3px solid #667eea
    min-height: 30px
    text-align: left
"""

render: (output) ->
  try
    window.mindfulData = JSON.parse(output)
    window.currentTechniqueIndex = 0
    window.isBreathing = false
    window.currentCycle = 0
    window.currentPhaseIndex = 0
    window.breathingInsightIndex = 0

    technique = window.mindfulData.techniques[0]
    reminder = window.mindfulData.reminders[Math.floor(Math.random() * window.mindfulData.reminders.length)]

    """
    <div class="mindful-container">
      <div class="mindful-left">
        <div class="breath-circle-container">
          <div class="breath-circle" id="breath-circle"></div>
          <div class="breath-text" id="breath-text">Ready</div>
          <div class="breath-counter" id="breath-counter"></div>
        </div>
      </div>

      <div class="mindful-right">
        <div class="mindful-header">
          <div class="mindful-icon">🧘</div>
          <div class="mindful-title">Mindful Breathing</div>
        </div>

        <div class="technique-info">
          <div class="technique-name" id="technique-name">#{technique.name}</div>
          <div class="technique-desc" id="technique-desc">#{technique.description}</div>
        </div>

        <div class="control-buttons">
          <button class="btn btn-start" id="start-btn" onclick="startBreathing()">Start</button>
          <button class="btn btn-stop" id="stop-btn" onclick="stopBreathing()" style="display:none;">Stop</button>
          <button class="btn btn-next" id="next-btn" onclick="nextTechnique()">Next Technique</button>
        </div>

        <div class="reminder-text" id="reminder-text">#{reminder}</div>
      </div>
    </div>
    """
  catch error
    console.log("Error parsing mindful breath data:", error)
    """
    <div class="mindful-container">
      <div class="mindful-header">
        <div class="mindful-icon">⚠️</div>
        <div class="mindful-title">Error</div>
      </div>
      <div class="technique-desc">Failed to load breathing exercises</div>
    </div>
    """

update: (output, domEl) ->
  # Rotate reminder every 5 minutes
  if window.mindfulData?.reminders
    setInterval(() ->
      reminder = window.mindfulData.reminders[Math.floor(Math.random() * window.mindfulData.reminders.length)]
      $('#reminder-text').text(reminder)
    , 300000)

  # Global functions for breathing control
  window.startBreathing = () ->
    return if window.isBreathing
    window.isBreathing = true
    window.currentCycle = 0
    window.currentPhaseIndex = 0

    $('#start-btn').hide()
    $('#stop-btn').show()
    $('#next-btn').hide()

    technique = window.mindfulData.techniques[window.currentTechniqueIndex]
    runBreathingCycle(technique)

  window.stopBreathing = () ->
    window.isBreathing = false
    $('#breath-circle').removeClass('breathe-in hold breathe-out')
    $('#breath-text').text('Ready')
    $('#breath-counter').text('')
    $('#start-btn').show()
    $('#stop-btn').hide()
    $('#next-btn').show()
    # Reset to random reminder when stopped
    reminder = window.mindfulData.reminders[Math.floor(Math.random() * window.mindfulData.reminders.length)]
    $('#reminder-text').text(reminder)
    if window.breathTimeout
      clearTimeout(window.breathTimeout)

  window.nextTechnique = () ->
    window.currentTechniqueIndex = (window.currentTechniqueIndex + 1) % window.mindfulData.techniques.length
    technique = window.mindfulData.techniques[window.currentTechniqueIndex]
    $('#technique-name').text(technique.name)
    $('#technique-desc').text(technique.description)
    window.stopBreathing() if window.isBreathing

  window.runBreathingCycle = (technique) ->
    return unless window.isBreathing

    if window.currentCycle >= technique.cycles
      window.stopBreathing()
      $('#breath-text').text('Complete! 🎉')
      return

    if window.currentPhaseIndex >= technique.pattern.length
      window.currentPhaseIndex = 0
      window.currentCycle++
      # Change insight text with each complete cycle
      if window.mindfulData?.breathingInsights
        window.breathingInsightIndex = (window.breathingInsightIndex + 1) % window.mindfulData.breathingInsights.length
        $('#reminder-text').text(window.mindfulData.breathingInsights[window.breathingInsightIndex])

    phase = technique.pattern[window.currentPhaseIndex]

    # Set the phase
    $('#breath-text').text(phase.phase)
    circle = $('#breath-circle')
    circle.removeClass('breathe-in hold breathe-out')

    # Determine animation class
    animClass = switch phase.phase.toLowerCase()
      when 'breathe in' then 'breathe-in'
      when 'hold' then 'hold'
      when 'breathe out' then 'breathe-out'
      else 'hold'

    circle.addClass(animClass)
    circle.css('--duration', "#{phase.duration}s")

    # Update color
    circle.css('background', "linear-gradient(135deg, #{phase.color} 0%, #{phase.color}dd 100%)")
    circle.css('box-shadow', "0 0 30px #{phase.color}88, 0 0 60px #{phase.color}44, inset 0 0 20px rgba(255,255,255,0.2)")

    # Countdown
    remaining = phase.duration
    updateCounter = () ->
      $('#breath-counter').text(remaining)
      remaining--
      if remaining >= 0
        setTimeout(updateCounter, 1000)
    updateCounter()

    # Move to next phase
    window.currentPhaseIndex++
    window.breathTimeout = setTimeout(() ->
      runBreathingCycle(technique)
    , phase.duration * 1000)
