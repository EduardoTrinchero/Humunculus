local Player = require("entities.player.player")
local Enemey = require("entities.enemy.enemy")

function love.load()

    player = Player:new({
        health = 100,
        sprite = "assets/images/sprt_marlon_2.png",
        isLive = true,
        posX = 250,
        posY = 250,
        angle = 0,
        size = 6,
        origin = 56
    })

    enemy = Enemey:new({
        health = 100,
        sprite = "assets/images/pigtauro.png",
        isLive = true,
        posX = 10,
        posY = 10,
        angle = 0,
        size = 4,
        origin = 56
    })

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
    love.graphics.setBackgroundColor(1,1,1)
end

function love.update( dt )
    player:checkMoves(dt)
    enemy:goForPlayer(dt, player)
end

function love.draw ()
    love.graphics.draw( enemy.sprite, enemy.posX, enemy.posY, enemy.angle, enemy.size)
    love.graphics.draw( player.sprite, player.posX, player.posY, player.angle, player.size)
end