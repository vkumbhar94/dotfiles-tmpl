# Rubber Duck Debugging Desktop Widget for Übersicht
# Save as: rubber-duck-debug.widget/index.coffee

command: ""
refreshFrequency: false

style: """
  top: 0
  left: 0
  width: 100vw
  height: 100vh
  z-index: -1000
  pointer-events: none
  
  .rubber-duck-container
    position: relative
    width: 100%
    height: 100%
    background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 30%, #16213e 70%, #0f0f23 100%)
    overflow: hidden
    
  .circuit-pattern
    position: absolute
    top: 0
    left: 0
    width: 100%
    height: 100%
    background-image: 
      linear-gradient(90deg, rgba(0,255,65,0.08) 1px, transparent 1px),
      linear-gradient(rgba(0,255,65,0.08) 1px, transparent 1px)
    background-size: 60px 60px
    opacity: 0.4
    
  .code-lines
    position: absolute
    font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace
    font-size: 16px
    color: #00ff41
    opacity: 0.7
    text-shadow: 0 0 8px rgba(0,255,65,0.4)
    font-weight: 400
    
  .line1
    top: 15%
    left: 8%
    transform: rotate(-2deg)
    
  .line2
    top: 30%
    left: 5%
    transform: rotate(1deg)
    
  .line3
    top: 45%
    left: 12%
    transform: rotate(-1deg)
    
  .line4
    top: 55%
    left: 6%
    transform: rotate(0.5deg)
    
  .floating-brackets
    position: absolute
    font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace
    font-size: 24px
    color: #ff6b6b
    opacity: 0.6
    text-shadow: 0 0 12px rgba(255,107,107,0.5)
    animation: float 8s ease-in-out infinite
    
  .bracket1
    top: 12%
    right: 25%
    animation-delay: 0s
    
  .bracket2
    top: 65%
    left: 15%
    animation-delay: 2s
    
  .bracket3
    top: 25%
    left: 65%
    animation-delay: 4s
    
  .bracket4
    top: 75%
    right: 40%
    animation-delay: 6s
    
  .debug-text
    position: absolute
    top: 15%
    right: 8%
    font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace
    font-size: 18px
    color: #00ff41
    opacity: 0.8
    text-align: right
    line-height: 1.6
    text-shadow: 0 0 10px rgba(0,255,65,0.5)
    
  .scatter-code
    position: absolute
    font-family: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace
    font-size: 14px
    color: #64b5f6
    opacity: 0.5
    text-shadow: 0 0 6px rgba(100,181,246,0.4)
    
  .code-var
    top: 70%
    left: 25%
    transform: rotate(-1deg)
    
  .code-if
    top: 40%
    right: 15%
    transform: rotate(2deg)
    
  .code-return
    bottom: 15%
    left: 45%
    transform: rotate(-0.5deg)
    
  .rubber-duck
    position: absolute
    bottom: 8%
    right: 8%
    width: 240px
    height: 240px

  .rubber-duck2
    position: absolute
    top: 8%
    left: 20%
    width: 240px
    height: 240px
    
  .duck-body
    width: 140px
    height: 120px
    background: linear-gradient(145deg, #ffeb3b 0%, #ffc107 50%, #ff9800 100%)
    border-radius: 70px 70px 50px 50px
    position: relative
    box-shadow: 
      inset -15px -15px 30px rgba(0,0,0,0.3),
      0 10px 30px rgba(0,0,0,0.4)
    
  .duck-head
    width: 90px
    height: 80px
    background: linear-gradient(145deg, #ffeb3b 0%, #ffc107 50%, #ff9800 100%)
    border-radius: 50%
    position: absolute
    top: -40px
    left: 25px
    box-shadow: 
      inset -8px -8px 20px rgba(0,0,0,0.25),
      0 8px 20px rgba(0,0,0,0.3)
    
  .duck-beak
    width: 30px
    height: 15px
    background: linear-gradient(145deg, #ff9800 0%, #f57c00 100%)
    border-radius: 0 20px 20px 0
    position: absolute
    left: -25px
    top: 30px
    box-shadow: 0 3px 8px rgba(0,0,0,0.3)
    
  .duck-eye
    width: 16px
    height: 16px
    background: #000
    border-radius: 50%
    position: absolute
    top: 22px
    left: 18px
    box-shadow: 0 2px 4px rgba(0,0,0,0.5)
    
  .eye-highlight
    width: 6px
    height: 6px
    background: #fff
    border-radius: 50%
    position: absolute
    top: 3px
    left: 3px
    
  .duck-wing
    width: 35px
    height: 45px
    background: linear-gradient(145deg, #ffc107 0%, #ff9800 100%)
    border-radius: 20px 5px 25px 15px
    position: absolute
    right: 15px
    top: 20px
    transform: rotate(-15deg)
    box-shadow: inset -5px -5px 10px rgba(0,0,0,0.2)
    
  @keyframes float
    0%, 100%
      transform: translateY(0px) rotate(0deg)
    25%
      transform: translateY(-8px) rotate(1deg)
    50%
      transform: translateY(-12px) rotate(0deg)
    75%
      transform: translateY(-8px) rotate(-1deg)
      
  @media (max-width: 1366px)
    .debug-text
      font-size: 16px
      right: 6%
      
    .rubber-duck
      width: 200px
      height: 200px
      bottom: 6%
      right: 6%
      
    .duck-body
      width: 120px
      height: 100px
      
    .duck-head
      width: 75px
      height: 65px
      
  @media (max-width: 1024px)
    .code-lines
      font-size: 14px
      
    .debug-text
      font-size: 14px
      
    .floating-brackets
      font-size: 20px
"""

render: (output) ->
  """
  <div class="rubber-duck-container">
    <div class="circuit-pattern"></div>
    
    <div class="code-lines line1">function debugThis() {</div>
    <div class="code-lines line2">  // Tell the duck about it...</div>
    <div class="code-lines line3">  console.log("What am I missing?");</div>
    <div class="code-lines line4">}</div>
    
    <div class="floating-brackets bracket1">{</div>
    <div class="floating-brackets bracket2">}</div>
    <div class="floating-brackets bracket3">[]</div>
    <div class="floating-brackets bracket4">()</div>
    
    <div class="debug-text">
      // Rubber Duck Debugging<br>
      // Explain your code line by line<br>
      // The answer will come to you<br>
      // <br>
      // "The debugger is you"
    </div>

    <div class="rubber-duck2">
      <div class="duck-body">
        <div class="duck-head">
          <div class="duck-beak"></div>
          <div class="duck-eye">
            <div class="eye-highlight"></div>
          </div>
        </div>
        <div class="duck-wing"></div>
      </div>
    </div>
    
    <div class="rubber-duck">
      <div class="duck-body">
        <div class="duck-head">
          <div class="duck-beak"></div>
          <div class="duck-eye">
            <div class="eye-highlight"></div>
          </div>
        </div>
        <div class="duck-wing"></div>
      </div>
    </div>
    
    <div class="scatter-code code-var">let solution = null;</div>
    <div class="scatter-code code-if">if (talking_to_duck) {</div>
    <div class="scatter-code code-return">return enlightenment;</div>
  </div>
  """

update: (output, domEl) ->
  # Optional: Dynamic opacity based on time of day
  currentHour = new Date().getHours()
  opacity = if 9 <= currentHour <= 17 then 0.25 else 0.4
  $(domEl).css('opacity', opacity)
