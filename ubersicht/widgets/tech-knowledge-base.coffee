# Tech Knowledge Base Widget for Übersicht
# Rotating technical knowledge for tech leads

command: "cat \"$HOME/Library/Application Support/Übersicht/widgets/tech-knowledge-base.json\""
refreshFrequency: 3600000  # Refresh every hour to rotate content

style: """
  bottom: 20px
  right: 20px
  width: 450px
  z-index: 100
  font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace

  .tech-kb-container
    background: rgba(40, 44, 52, 0.95)
    border: 2px solid #4a5568
    border-radius: 8px
    padding: 20px
    box-shadow: 0 8px 32px rgba(0,0,0,0.5)
    backdrop-filter: blur(10px)

  .kb-header
    display: flex
    align-items: center
    justify-content: space-between
    margin-bottom: 16px
    padding-bottom: 12px
    border-bottom: 1px solid #4a5568

  .header-left
    display: flex
    align-items: center

  .kb-icon-main
    width: 24px
    height: 24px
    margin-right: 12px
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%)
    border-radius: 50%
    display: flex
    align-items: center
    justify-content: center
    font-size: 14px

  .kb-category
    color: #a0aec0
    font-size: 11px
    text-transform: uppercase
    letter-spacing: 0.5px
    font-weight: bold

  .kb-rotation-indicator
    color: #718096
    font-size: 10px
    font-style: italic

  .kb-nav-btns
    display: flex
    gap: 6px
    align-items: center

  .kb-arrow-btn
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%)
    color: white
    border: none
    padding: 4px 8px
    border-radius: 4px
    font-size: 12px
    cursor: pointer
    transition: all 0.2s ease
    font-family: inherit
    line-height: 1

  .kb-arrow-btn:hover
    transform: translateY(-1px)
    box-shadow: 0 4px 12px rgba(240, 147, 251, 0.4)

  .kb-title
    color: #f7fafc
    font-size: 15px
    font-weight: bold
    margin-bottom: 12px
    text-shadow: 0 0 8px rgba(240, 147, 251, 0.5)

  .kb-content
    color: #e2e8f0
    font-size: 13px
    line-height: 1.6
    padding: 14px
    background: rgba(0,0,0,0.3)
    border-radius: 6px
    border-left: 3px solid #f093fb

  .kb-footer
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
    window.techKBData = items

    # Initialize manual index if not set
    if !window.techKBManualIndex?
      currentHour = new Date().getHours()
      currentDay = new Date().getDate()
      # Offset by 1 to show different content than the wisdom widget
      window.techKBManualIndex = (currentDay * 24 + currentHour + 1) % items.length

    index = window.techKBManualIndex
    item = items[index]

    """
    <div class="tech-kb-container">
      <div class="kb-header">
        <div class="header-left">
          <div class="kb-icon-main">#{item.icon}</div>
          <div class="kb-category">#{item.category}</div>
        </div>
        <div class="header-left">
          <div class="kb-rotation-indicator">#{index + 1}/#{items.length}</div>
          <div class="kb-nav-btns">
            <button class="kb-arrow-btn" onclick="prevKB()">←</button>
            <button class="kb-arrow-btn" onclick="nextKB()">→</button>
          </div>
        </div>
      </div>

      <div class="kb-title" id="kb-title">#{item.title}</div>

      <div class="kb-content" id="kb-content">#{item.content}</div>

      <div class="kb-footer">Rotates hourly • Tech Knowledge Base</div>
    </div>
    """
  catch error
    console.log("Error parsing tech knowledge data:", error)
    """
    <div class="tech-kb-container">
      <div class="kb-header">
        <div class="header-left">
          <div class="kb-icon-main">⚠️</div>
          <div class="kb-category">Error</div>
        </div>
      </div>
      <div class="kb-content">Failed to load tech knowledge content. Check tech-knowledge-base.json</div>
    </div>
    """

update: (output, domEl) ->
  # Optional: Add subtle fade effect when content changes
  currentHour = new Date().getHours()
  opacity = if 6 <= currentHour <= 22 then 0.95 else 0.85
  $(domEl).css('opacity', opacity)

  # Global functions for navigation buttons
  window.nextKB = () ->
    return unless window.techKBData
    window.techKBManualIndex = (window.techKBManualIndex + 1) % window.techKBData.length
    item = window.techKBData[window.techKBManualIndex]

    # Update content
    $('.kb-icon-main').text(item.icon)
    $('.kb-category').text(item.category)
    $('#kb-title').text(item.title)
    $('#kb-content').text(item.content)
    $('.kb-rotation-indicator').text("#{window.techKBManualIndex + 1}/#{window.techKBData.length}")

  window.prevKB = () ->
    return unless window.techKBData
    window.techKBManualIndex = if window.techKBManualIndex <= 0 then window.techKBData.length - 1 else window.techKBManualIndex - 1
    item = window.techKBData[window.techKBManualIndex]

    # Update content
    $('.kb-icon-main').text(item.icon)
    $('.kb-category').text(item.category)
    $('#kb-title').text(item.title)
    $('#kb-content').text(item.content)
    $('.kb-rotation-indicator').text("#{window.techKBManualIndex + 1}/#{window.techKBData.length}")
