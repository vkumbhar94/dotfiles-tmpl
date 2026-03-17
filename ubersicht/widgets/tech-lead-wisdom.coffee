# Tech Lead Wisdom Widget for Übersicht
# Rotating knowledge for technical leaders

command: "cat \"$HOME/Library/Application Support/Übersicht/widgets/tech-lead-wisdom.json\""
refreshFrequency: 3600000  # Refresh every hour to rotate content

style: """
  bottom: 20px
  left: 20px
  width: 450px
  z-index: 100
  font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace

  .tech-wisdom-container
    background: rgba(40, 44, 52, 0.95)
    border: 2px solid #4a5568
    border-radius: 8px
    padding: 20px
    box-shadow: 0 8px 32px rgba(0,0,0,0.5)
    backdrop-filter: blur(10px)

  .wisdom-header
    display: flex
    align-items: center
    justify-content: space-between
    margin-bottom: 16px
    padding-bottom: 12px
    border-bottom: 1px solid #4a5568

  .header-left
    display: flex
    align-items: center

  .wisdom-icon-main
    width: 24px
    height: 24px
    margin-right: 12px
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
    border-radius: 50%
    display: flex
    align-items: center
    justify-content: center
    font-size: 14px

  .wisdom-category
    color: #a0aec0
    font-size: 11px
    text-transform: uppercase
    letter-spacing: 0.5px
    font-weight: bold

  .wisdom-rotation-indicator
    color: #718096
    font-size: 10px
    font-style: italic

  .wisdom-nav-btns
    display: flex
    gap: 6px
    align-items: center

  .wisdom-arrow-btn
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
    color: white
    border: none
    padding: 4px 8px
    border-radius: 4px
    font-size: 12px
    cursor: pointer
    transition: all 0.2s ease
    font-family: inherit
    line-height: 1

  .wisdom-arrow-btn:hover
    transform: translateY(-1px)
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4)

  .wisdom-title
    color: #f7fafc
    font-size: 15px
    font-weight: bold
    margin-bottom: 12px
    text-shadow: 0 0 8px rgba(102, 126, 234, 0.5)

  .wisdom-content
    color: #e2e8f0
    font-size: 13px
    line-height: 1.6
    padding: 14px
    background: rgba(0,0,0,0.3)
    border-radius: 6px
    border-left: 3px solid #667eea

  .wisdom-footer
    margin-top: 12px
    padding-top: 8px
    border-top: 1px solid #4a5568
    color: #718096
    font-size: 10px
    text-align: center
    font-style: italic
"""

render: (output) ->
  try
    data = JSON.parse(output)
    items = data.items || []

    # Store data globally for manual navigation
    window.techWisdomData = items

    # Initialize manual index if not set
    if !window.techWisdomManualIndex?
      currentHour = new Date().getHours()
      currentDay = new Date().getDate()
      window.techWisdomManualIndex = (currentDay * 24 + currentHour) % items.length

    index = window.techWisdomManualIndex
    item = items[index]

    """
    <div class="tech-wisdom-container">
      <div class="wisdom-header">
        <div class="header-left">
          <div class="wisdom-icon-main">#{item.icon}</div>
          <div class="wisdom-category">#{item.category}</div>
        </div>
        <div class="header-left">
          <div class="wisdom-rotation-indicator">#{index + 1}/#{items.length}</div>
          <div class="wisdom-nav-btns">
            <button class="wisdom-arrow-btn" onclick="prevWisdom()">←</button>
            <button class="wisdom-arrow-btn" onclick="nextWisdom()">→</button>
          </div>
        </div>
      </div>

      <div class="wisdom-title" id="wisdom-title">#{item.title}</div>

      <div class="wisdom-content" id="wisdom-content">#{item.content}</div>

      <div class="wisdom-footer">Rotates hourly • Tech Lead Knowledge Base</div>
    </div>
    """
  catch error
    console.log("Error parsing tech wisdom data:", error)
    """
    <div class="tech-wisdom-container">
      <div class="wisdom-header">
        <div class="header-left">
          <div class="wisdom-icon-main">⚠️</div>
          <div class="wisdom-category">Error</div>
        </div>
      </div>
      <div class="wisdom-content">Failed to load tech wisdom. Check tech-lead-wisdom.json</div>
    </div>
    """

update: (output, domEl) ->
  # Optional: Add subtle fade effect when content changes
  currentHour = new Date().getHours()
  opacity = if 6 <= currentHour <= 22 then 0.95 else 0.85
  $(domEl).css('opacity', opacity)

  # Global functions for navigation buttons
  window.nextWisdom = () ->
    return unless window.techWisdomData
    window.techWisdomManualIndex = (window.techWisdomManualIndex + 1) % window.techWisdomData.length
    item = window.techWisdomData[window.techWisdomManualIndex]

    # Update content
    $('.wisdom-icon-main').text(item.icon)
    $('.wisdom-category').text(item.category)
    $('#wisdom-title').text(item.title)
    $('#wisdom-content').text(item.content)
    $('.wisdom-rotation-indicator').text("#{window.techWisdomManualIndex + 1}/#{window.techWisdomData.length}")

  window.prevWisdom = () ->
    return unless window.techWisdomData
    window.techWisdomManualIndex = if window.techWisdomManualIndex <= 0 then window.techWisdomData.length - 1 else window.techWisdomManualIndex - 1
    item = window.techWisdomData[window.techWisdomManualIndex]

    # Update content
    $('.wisdom-icon-main').text(item.icon)
    $('.wisdom-category').text(item.category)
    $('#wisdom-title').text(item.title)
    $('#wisdom-content').text(item.content)
    $('.wisdom-rotation-indicator').text("#{window.techWisdomManualIndex + 1}/#{window.techWisdomData.length}")
