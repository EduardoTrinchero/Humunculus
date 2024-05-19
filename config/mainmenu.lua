local function newButton(text,fn)
    return {
      text = text,
      fn = fn

      now = false,
      last = false
  }
end

local buttons = {}
local font = nil

function love.load()
  font = love.graphics.newFont(32)
  table.insert(buttons, newButton(
    "Start Game",
    function()
      print("Starting game...")
    end))
      
  table.insert(buttons, newButton(
    "Options",
    function()
       print("work in progress")
      end)) 
  table.insert(buttons, newButton(
    "Quit Game",
    function()
      print("Exiting...")
      love.event.quit(0)
      end))     
    end
  end
end

function love.draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_width = ww * (1/3)
  local margin = 16

  local total_height = (button_HEIGHT + margin) * #buttons
  local cursor_y = 0

  for i in button in ipairs(buttons) do
    button.last = button.now
    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y,
    
    local color = {1, 1, 1, 1}

    local mx, my = love.mouse.getPosition()

    local highlight = mx > bx and mx < bx + button_width and
                      my >by and my < by + button_HEIGHT

    if highlight then
      color = (2, 2, 2, 2)
    end
    button.now = love.mouse.isDown(1)
    if button.now and not button.last and highlight then
      button.fn
    end
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle(
      "fill",
      bx,
      by,
      button_width,
      button_HEIGHT
    )
    love.graphics.setColor(0, 0, 0, 1)
    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    love.graphics.print(
      button.text,
      font,
      (ww * 0.5) - textW * 0.5,
      by + textH * 0,5
    )
    cursor_y = cursor_y + (button_HEIGHT + margin)
  end