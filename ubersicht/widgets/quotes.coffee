# Time-Based Daily Quotes Widget
command: "cat ~/.quotes.txt"

refreshFrequency: 10000 # milliseconds 

style: """
  top: 60%
  left: 50%
  transform: translate(-50%, -50%)
  width: 80vw
  max-width: 1000px
  height: 400px
  background: rgba(0, 0, 0, 0.85)
  color: #ffffff
  padding: 25px
  border-radius: 12px
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif
  font-size: 14px
  line-height: 1.7
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3)
  backdrop-filter: blur(10px)
  border: 1px solid rgba(255, 255, 255, 0.1)

  .widget-title
    font-size: 18px
    font-weight: 600
    margin-bottom: 15px
    color: #4A90E2
    border-bottom: 2px solid #4A90E2
    padding-bottom: 8px
    text-align: center

  .time-indicator
    text-align: center
    font-size: 14px
    margin-bottom: 15px
    padding: 8px 12px
    border-radius: 8px
    font-weight: 500

  .time-indicator.wake-up
    background: rgba(255, 193, 7, 0.2)
    color: #FFC107
    border: 1px solid rgba(255, 193, 7, 0.3)

  .time-indicator.morning
    background: rgba(76, 175, 80, 0.2)
    color: #4CAF50
    border: 1px solid rgba(76, 175, 80, 0.3)

  .time-indicator.afternoon
    background: rgba(255, 152, 0, 0.2)
    color: #FF9800
    border: 1px solid rgba(255, 152, 0, 0.3)

  .time-indicator.evening
    background: rgba(156, 39, 176, 0.2)
    color: #9C27B0
    border: 1px solid rgba(156, 39, 176, 0.3)

  .time-indicator.night
    background: rgba(63, 81, 181, 0.2)
    color: #3F51B5
    border: 1px solid rgba(63, 81, 181, 0.3)

  .quotes-container
    height: 280px
    overflow-y: auto
    overflow-x: hidden
    padding-right: 10px

  .quotes-container::-webkit-scrollbar
    width: 8px

  .quotes-container::-webkit-scrollbar-track
    background: rgba(255, 255, 255, 0.1)
    border-radius: 4px

  .quotes-container::-webkit-scrollbar-thumb
    background: rgba(74, 144, 226, 0.6)
    border-radius: 4px

  .quotes-container::-webkit-scrollbar-thumb:hover
    background: rgba(74, 144, 226, 0.8)

  .category-group
    margin-bottom: 25px

  .category-header
    font-size: 16px
    font-weight: 700
    margin-bottom: 12px
    padding: 8px 12px
    border-radius: 6px
    border-left: 4px solid #4A90E2
    background: rgba(74, 144, 226, 0.15)
    color: #4A90E2

  .quotes-list
    list-style: none
    padding: 0
    margin: 0 0 0 15px

  .quote-item
    margin-bottom: 12px
    padding: 10px 12px
    border-left: 3px solid #4A90E2
    background: rgba(255, 255, 255, 0.05)
    border-radius: 6px
    transition: all 0.3s ease
    cursor: pointer

  .quote-item:hover
    background: rgba(255, 255, 255, 0.1)
    border-left-color: #60A5FA
    transform: translateX(5px)
    box-shadow: 0 4px 16px rgba(74, 144, 226, 0.3)

  .quote-text
    font-style: italic
    margin-bottom: 6px
    font-size: 17px
    line-height: 1.6
    transition: all 0.3s ease

  .quote-item:hover .quote-text
    font-size: 25px
    line-height: 1.5

  .quote-author
    font-size: 13px
    color: #B0B0B0
    font-weight: 500
    text-align: right
    transition: all 0.3s ease

  .quote-item:hover .quote-author
    color: #D0D0D0

  .quote-count
    position: absolute
    top: 10px
    right: 15px
    background: rgba(74, 144, 226, 0.3)
    color: #4A90E2
    padding: 4px 8px
    border-radius: 12px
    font-size: 11px
    font-weight: 600

  .current-time
    position: absolute
    top: 10px
    left: 15px
    background: rgba(255, 255, 255, 0.1)
    color: #ffffff
    padding: 4px 8px
    border-radius: 12px
    font-size: 11px
    font-weight: 600

  .show-all-btn
    position: absolute
    top: 40px
    left: 15px
    background: rgba(255, 255, 255, 0.1)
    color: #ffffff
    padding: 4px 8px
    border-radius: 12px
    font-size: 11px
    font-weight: 600
    cursor: pointer
    transition: all 0.3s ease
    user-select: none

  .show-all-btn:hover
    background: rgba(255, 255, 255, 0.2)
    transform: scale(1.05)
"""

render: -> """
  <div class="quotes-widget">
    <div class="current-time" id="currentTime"></div>
    <div class="show-all-btn" id="showAllBtn">Show All</div>
    <div class="quote-count"></div>
    <div class="widget-title">💡 My Daily Inspiration/Reminders</div>
    <div class="time-indicator" id="timeIndicator"></div>
    <div class="quotes-container">
      <div class="quotes-content"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  now = new Date()
  currentHour = now.getHours()
  currentTime = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})
  
  # Determine current time period
  timeOfDay = ""
  if currentHour >= 5 and currentHour < 7
    timeOfDay = "Wake Up"
  else if currentHour >= 7 and currentHour < 12
    timeOfDay = "Morning" 
  else if currentHour >= 12 and currentHour < 17
    timeOfDay = "Afternoon"
  else if currentHour >= 17 and currentHour < 21
    timeOfDay = "Evening"
  else
    timeOfDay = "Night"
  
  # Update current time display
  $(domEl).find('#currentTime').text(currentTime)
  
  # Parse all quotes
  lines = output.split('\n').filter (line) -> line.trim() != ''
  allCategories = {}
  currentCategory = null
  
  for line in lines
    line = line.trim()
    if line.startsWith('#')
      currentCategory = line.replace('#', '').trim()
      allCategories[currentCategory] = []
    else if line.startsWith('-') and currentCategory
      allCategories[currentCategory].push(line)
  
  # Check if "Show All" mode is active - store state in widget data
  showAllBtn = $(domEl).find('#showAllBtn')
  if !$(domEl).data('showAllMode')?
    $(domEl).data('showAllMode', false)
  
  showAll = $(domEl).data('showAllMode')
  
  # Update button text based on current state
  if showAll
    showAllBtn.text('Show Current').addClass('active')
  else
    showAllBtn.text('Show All').removeClass('active')
  
  # Filter categories based on time or show all
  categoriesToShow = {}
  timeIndicatorText = ""
  timeIndicatorClass = ""
  
  if showAll
    categoriesToShow = allCategories
    timeIndicatorText = "🌍 All Time Periods"
    timeIndicatorClass = "all-periods"
  else
    # Get time indicator text and class
    emoji = ""
    if timeOfDay == "Wake Up"
      emoji = "🌅"
    else if timeOfDay == "Morning"
      emoji = "☀️"
    else if timeOfDay == "Afternoon"
      emoji = "🌤️"
    else if timeOfDay == "Evening"
      emoji = "🌆"
    else
      emoji = "🌙"
    
    timeIndicatorText = emoji + " " + timeOfDay + " Time • " + currentTime
    timeIndicatorClass = timeOfDay.replace(/\s+/g, '-').toLowerCase()
    
    # Find the current time period category
    for category, quotes of allCategories
      categoryLower = category.toLowerCase()
      timeOfDayLower = timeOfDay.toLowerCase()
      if categoryLower.indexOf(timeOfDayLower) >= 0
        categoriesToShow[category] = quotes
        break
  
  # Update time indicator
  timeIndicator = $(domEl).find('#timeIndicator')
  timeIndicator.text(timeIndicatorText)
  timeIndicator.removeClass().addClass('time-indicator ' + timeIndicatorClass)
  
  # Build HTML for current categories
  quotesHtml = ''
  totalQuotes = 0
  categoryColors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8']
  colorIndex = 0
  
  for category, quotes of categoriesToShow
    if quotes and quotes.length > 0
      color = categoryColors[colorIndex % categoryColors.length]
      quotesHtml += '<div class="category-group">'
      quotesHtml += '<div class="category-header" style="color: ' + color + '; border-left-color: ' + color + ';">'
      quotesHtml += category + ' (' + quotes.length + ')'
      quotesHtml += '</div>'
      quotesHtml += '<ul class="quotes-list">'
      
      for quote in quotes
        cleanLine = quote.replace(/^- /, '')
        if cleanLine.includes(' - ')
          parts = cleanLine.split(' - ')
          quoteText = parts[0]
          author = parts.slice(1).join(' - ')
          quotesHtml += '<li class="quote-item">'
          quotesHtml += '<div class="quote-text">' + quoteText + '</div>'
          quotesHtml += '<div class="quote-author">— ' + author + '</div>'
          quotesHtml += '</li>'
        else
          quotesHtml += '<li class="quote-item">'
          quotesHtml += '<div class="quote-text">' + cleanLine + '</div>'
          quotesHtml += '</li>'
        totalQuotes++
      
      quotesHtml += '</ul></div>'
      colorIndex++
  
  $(domEl).find('.quotes-content').html(quotesHtml)
  $(domEl).find('.quote-count').text(totalQuotes + ' quotes')
  
  # Add show all toggle functionality (only bind once)
  if !$(domEl).data('clickHandlerBound')
    showAllBtn.on 'click', (e) ->
      currentMode = $(domEl).data('showAllMode')
      $(domEl).data('showAllMode', !currentMode)
      
      # Immediate refresh without waiting for refreshFrequency
      # Get the current output again and update immediately
      currentOutput = $(domEl).data('currentOutput') || output
      update(currentOutput, domEl)
    
    $(domEl).data('clickHandlerBound', true)
  
  # Store current output for immediate refresh
  $(domEl).data('currentOutput', output)
