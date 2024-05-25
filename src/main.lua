local Camera = require "lib.hump.camera"

local EnemyManager = require("managers.enemy_manager.enemyManager")
local Player = require("entities.player.player")
local Enemy = require("entities.enemy.enemy")
local Bullet = require("entities.bullet.bullet")


bulletsStorage = {}

function love.load()
    enemies = EnemyManager:new():getEnemies()

    player = Player:new({
        health = 100,
        sprite = "assets/images/marlon/sprt_marlon.png",
        isAlive = true,
        hitbox = 65,
        attackRatio = 0.5,
        speed = 300,
        posX = 250,
        posY = 250,
        angle = 0,
        size = 3,
        originOffsetX = 19,
        originOffsetY = 19,
    })

    camera = Camera(player.posX, player.posY)

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
    local r, g, b = love.math.colorFromBytes(242, 245, 66)
    love.graphics.setBackgroundColor(r, g, b)
end

function love.update( dt )
    mouseX, mouseY = love.mouse.getPosition()
    local cameraX, cameraY = player.posX - camera.x, player.posY - camera.y

    player:checkMoves(dt)
    player:lookAtCursor(mouseX, mouseY)
    player:onLoading()

    if love.mouse.isDown(1) then
        player:throwSpell(mouseX, mouseY)
    end

    for i, enemy in ipairs(enemies) do
        enemy:goForPlayer(dt, player)

        if player.bulletsStorage then
            for i, bullet in ipairs(player.bulletsStorage) do
                bullet.currentX = bullet.currentX + (bullet.directionX * dt)
                bullet.currentY = bullet.currentY + (bullet.directionY * dt)
        
                if enemy.hitbox:hit(enemy.posX, enemy.posY, bullet.currentX, bullet.currentY) and enemy.isAlive then 
                    enemy:onHit(bullet.damage)
                    table.remove(player.bulletsStorage, i)
                end
            end
        end
    end

    camera:move(cameraX/2, cameraY/2)
end

function love.draw()
    -- camera:attach()
        player:draw()
        player:onDebug()

        for i, enemy in ipairs(enemies) do
            enemy:draw()
            enemy:onDebug()
        end

        if player.bulletsStorage then
            for i, bullet in ipairs(player.bulletsStorage) do  
                love.graphics.draw( bullet.sprite, bullet.currentX, bullet.currentY, bullet.angle, bullet.size,  bullet.size, bullet.originOffsetX, bullet.originOffsetY)
                love.graphics.circle("line", bullet.currentX, bullet.currentY, 10)
            end
        end
    -- camera:detach()

    

end