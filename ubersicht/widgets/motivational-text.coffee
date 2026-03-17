# Motivational Text Widget for Übersicht
# Save as: motivational-text.coffee

command: "echo ''"
refreshFrequency: false  # Static content, no need to refresh

style: """
  top: 28%
  left: 22%
  width: 220px
  transform: translateY(-50%)
  z-index: 100
  font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace

  .motivational-container
    background: rgba(40, 44, 52, 0.95)
    border: 2px solid #4a5568
    border-radius: 8px
    padding: 25px
    height: 280px
    box-shadow: 0 8px 32px rgba(0,0,0,0.5)
    backdrop-filter: blur(10px)
    display: flex
    flex-direction: column
    justify-content: center

  .motivational-header
    display: flex
    align-items: center
    margin-bottom: 12px

  .motivational-icon
    width: 20px
    height: 20px
    margin-right: 12px
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
    border-radius: 50%
    display: flex
    align-items: center
    justify-content: center
    font-size: 12px

  .motivational-text
    color: #e2e8f0
    font-size: 14px
    line-height: 1.6
    text-align: left
    padding: 12px
    background: rgba(0,0,0,0.3)
    border-radius: 6px
    border-left: 3px solid #667eea

  .motivational-text strong
    color: #f7fafc
    font-weight: bold
    text-shadow: 0 0 8px rgba(102, 126, 234, 0.5)
"""

render: (output) ->
  """
  <div class="motivational-container">
    <div class="motivational-header">
      <div class="motivational-icon">💪</div>
    </div>

    <div class="motivational-text">
      <strong>Push yourself everyday</strong> to make it happen. Work for it with <strong>consistency and patience</strong>. And one day, you will reach exactly what you're aiming for.
    </div>
  </div>
  """
