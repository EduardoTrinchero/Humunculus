local Player = require("entities.player.player")
local Enemey = require("entities.enemy.enemy")
local Bullet = require("entities.bullet.bullet")


bulletsStorage = {}

function love.load()

    player = Player:new({
        health = 100,
        sprite = "assets/images/sprt_marlon.png",
        isLive = true,
        hitbox = 65,

        posX = 250,
        posY = 250,
        angle = 0,
        size = 3,
        originOffsetX = 19,
        originOffsetY = 19,
    })

    enemy = Enemey:new({
        health = 100,
        sprite = "assets/images/pigtauro.png",
        isLive = true,

        posX = 10,
        posY = 10,
        angle = 0,
        size = 4,
        origin = 56,
        originOffsetX = 19,
        originOffsetY = 19,
    })

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
    love.graphics.setBackgroundColor(1,1,1)
end

function lookAtCursor(mousex, mousey)
    local angle = math.atan2(mousey-player.posY,mousex-player.posX)
    player.angle = angle
end

function love.update( dt )
    player:checkMoves(dt)
    enemy:goForPlayer(dt, player)


    mousex, mousey = love.mouse.getPosition()
    lookAtCursor(mousex, mousey)


    -- if player.hitbox:hit(player.posX, player.posY, enemy.posX, enemy.posY) then 
    --     love.graphics.setColor(255, 0, 0)
    -- else
    --     love.graphics.setColor(0, 255, 0)
    -- end

    
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()

        initialX = player.posX  + player.size / 2
        initialY = player.posY  + player.size / 2

        local angle = math.atan2(mousey-player.posY,mousex-player.posX)

        directionX = 450 * math.cos(angle)
        directionY = 450 * math.sin(angle)


        bullet = Bullet:new({
            sprite = 'assets/images/sprt_magia.png',
            initialX = initialX,
            initialY = initialY,

            currentX = player.posX,
            currentY = player.posY,

            directionX = directionX,
            directionY = directionY,

            x = x,
            y = y
        })
        table.insert(bulletsStorage, bullet)
    end

    for i, bullet in ipairs(bulletsStorage) do
		bullet.currentX = bullet.currentX + (bullet.directionX * dt)
		bullet.currentY = bullet.currentY + (bullet.directionY * dt)
        if bullet.currentX == bullet.x and bullet.directionY == bullet.y then
            table.remove(bulletsStorage, i)
        end
	end

end

function love.draw ()
    love.graphics.draw( enemy.sprite, enemy.posX, enemy.posY, enemy.angle, enemy.size, enemy.size, enemy.originOffsetX, enemy.originOffsetY)
    love.graphics.draw( player.sprite, player.posX, player.posY, player.angle, player.size, player.size, player.originOffsetX, player.originOffsetY)

    love.graphics.circle("line", player.posX, player.posY, 65)
    love.graphics.circle("line", enemy.posX, enemy.posY, 65)

    love.graphics.circle("line", player.posX, player.posY, 10)
    love.graphics.circle("line", enemy.posX, enemy.posY, 10)


    for i, bullet in ipairs(bulletsStorage) do  
        love.graphics.draw( bullet.sprite, bullet.currentX, bullet.currentY)
	end

end