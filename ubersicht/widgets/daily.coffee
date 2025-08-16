# Daily Essential Reminders Widget
command: "echo 'reminders'"

refreshFrequency: 300000 # Refresh every 5 minutes

style: """
  .reminders-container
    position: fixed
    top: 28%
    left: 50%
    transform: translate(-50%, -50%)
    background: rgba(0, 0, 0, 0.7)
    backdrop-filter: blur(20px) saturate(150%)
    border-radius: 20px
    border: 2px solid rgba(255, 255, 255, 0.15)
    padding: 25px
    width: 600px
    height: 280px
    max-width: 90vw
    max-height: 90vh
    box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4),
                0 5px 15px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1)
    z-index: 1000
    display: flex
    flex-direction: column

  .widget-header
    text-align: center
    margin-bottom: 15px
    font-size: 18px
    font-weight: 700
    color: #FFFFFF
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.8)
    letter-spacing: 0.5px

  .reminders-grid
    display: grid
    grid-template-columns: 1fr 1fr
    grid-template-rows: 1fr 1fr
    gap: 15px
    flex: 1
    width: 100%
    height: 100%

  .reminder-item
    display: flex
    flex-direction: column
    align-items: center
    justify-content: center
    padding: 15px 12px
    background: rgba(255, 255, 255, 0.08)
    border-radius: 16px
    border: 2px solid var(--accent-color)
    transition: all 0.3s ease
    cursor: pointer
    text-align: center
    position: relative
    overflow: hidden

  .reminder-item:hover
    background: rgba(255, 255, 255, 0.12)
    transform: scale(1.05)
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4)

  .reminder-item:nth-child(1)
    --accent-color: #FF6B6B
    border-color: #FF6B6B

  .reminder-item:nth-child(2)
    --accent-color: #4ECDC4
    border-color: #4ECDC4

  .reminder-item:nth-child(3)
    --accent-color: #45B7D1
    border-color: #45B7D1

  .reminder-item:nth-child(4)
    --accent-color: #96CEB4
    border-color: #96CEB4

  .reminder-icon
    font-size: 28px
    margin-bottom: 8px
    color: var(--accent-color)
    text-shadow: 0 0 20px rgba(255, 255, 255, 0.3)

  .reminder-text
    font-size: 14px
    font-weight: 700
    color: #FFFFFF
    text-shadow: 0 2px 6px rgba(0, 0, 0, 0.8)
    letter-spacing: 0.3px
    line-height: 1.2
    margin-bottom: 5px

  .reminder-subtitle
    font-size: 10px
    color: #B0B0B0
    font-weight: 400
    font-style: italic
    line-height: 1.3
    text-align: center

  /* Responsive design */
  @media (max-width: 768px)
    .reminders-container
      width: 500px
      height: 240px
      padding: 20px
      top: 38%

    .widget-header
      font-size: 16px
      margin-bottom: 12px

    .reminders-grid
      gap: 12px

    .reminder-item
      padding: 12px 8px

    .reminder-icon
      font-size: 24px
      margin-bottom: 6px

    .reminder-text
      font-size: 13px
      margin-bottom: 4px

    .reminder-subtitle
      font-size: 9px

  @media (max-width: 600px)
    .reminders-container
      width: 90vw
      height: 200px
      min-height: 200px
      padding: 18px
      top: 35%

    .reminders-grid
      gap: 10px

    .reminder-item
      padding: 10px 6px

    .reminder-icon
      font-size: 20px
      margin-bottom: 5px

    .reminder-text
      font-size: 12px
      margin-bottom: 3px

    .reminder-subtitle
      font-size: 8px

  @media (max-width: 480px)
    .reminders-container
      height: 180px
      min-height: 180px
      top: 32%

    .widget-header
      font-size: 14px
      margin-bottom: 10px

    .reminders-grid
      gap: 8px

    .reminder-item
      padding: 8px 4px

    .reminder-icon
      font-size: 18px
      margin-bottom: 4px

    .reminder-text
      font-size: 11px
      margin-bottom: 2px

    .reminder-subtitle
      font-size: 7px

  /* High contrast mode */
  @media (prefers-contrast: high)
    .reminders-container
      background: rgba(0, 0, 0, 0.9)
      border: 3px solid #FFFFFF

    .reminder-item
      background: rgba(255, 255, 255, 0.15)
      border-left-width: 6px

    .reminder-text, .widget-header
      color: #FFFFFF
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 1)

  /* Reduced motion preference */
  @media (prefers-reduced-motion: reduce)
    .reminder-item
      transition: none

    .reminder-item:hover
      transform: none
"""

render: -> """
  <div class="reminders-container">
    <div class="widget-header">
      🏆 Master Yourself
      <!--- 💎 Daily Essentials --->
    </div>
    <div class="reminders-grid">
      <div class="reminder-item" data-reminder="1">
        <div class="reminder-icon">🤐</div>
        <div class="reminder-text">Don't Overshare</div>
        <div class="reminder-subtitle">Keep your personal matters private</div>
      </div>
      <div class="reminder-item" data-reminder="2">
        <div class="reminder-icon">🤫</div>
        <div class="reminder-text">Don't Overtalk</div>
        <div class="reminder-subtitle">Listen more, speak with purpose</div>
      </div>
      <div class="reminder-item" data-reminder="3">
        <div class="reminder-icon">🧘</div>
        <div class="reminder-text">Don't Overthink</div>
        <div class="reminder-subtitle">Trust your instincts and act</div>
      </div>
      <div class="reminder-item" data-reminder="4">
        <div class="reminder-icon">🧠</div>
        <div class="reminder-text">Don't Blame - Be Emotionally Intelligent</div>
        <div class="reminder-subtitle">Take responsibility, show empathy</div>
      </div>
    </div>
  </div>
"""

update: (output, domEl) ->
  # Get current time for any time-based logic if needed
  now = new Date()
  currentHour = now.getHours()
  
  # Add subtle interaction effects
  $(domEl).find('.reminder-item').off('click').on 'click', ->
    $(this).css('transform', 'translateX(10px) scale(1.02)')
    setTimeout(() ->
      $(this).css('transform', 'translateX(5px)')
    , 150)
  
  # Optional: Add a subtle daily rotation effect
  dayOfYear = Math.floor((now - new Date(now.getFullYear(), 0, 0)) / (1000 * 60 * 60 * 24))
  rotationClass = 'rotation-' + (dayOfYear % 4)
  
  # You can add different subtle variations here if desired
  # For now, keeping it simple and consistent
