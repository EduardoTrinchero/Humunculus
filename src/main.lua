local Player = require("entities.player.player")
local Enemey = require("entities.enemy.enemy")


posX = 250
posY = 250
angulo = 0
tam = 1
origem = 56


function love.load()

    player = Player:new({
        health = 100,
        sprite = "assets/images/Denzel.png",
        isLive = true
    })

    enemy = Enemey:new({
        health = 100,
        sprite = "assets/images/pigtauro.png",
        isLive = true
    })

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
end

function love.update( dt )
    if love.keyboard.isDown ("left") then
        posX = posX - 300 * dt
        
    end
    if love.keyboard.isDown ("right") then
        posX = posX + 300 * dt
    
    end
    if love.keyboard.isDown ("up") then
        posY = posY - 300 * dt
        
    end
    if love.keyboard.isDown ("down") then
        posY = posY + 300 * dt
    
    end

    if love.mouse.isDown (1) then
        local x, y = love.mouse.getPosition()
        posY = y
        posX = x
    end

end

function love.draw ()
    love.graphics.draw( enemy.sprite, 10, 10, 0, 4)
    love.graphics.draw( player.sprite, posX, posY, 0, 4)
end