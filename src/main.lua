local EnemyManager = require("managers.enemy_manager.enemyManager")
local PlayerManager = require("managers.player_manager.playerManager")

local Bullet = require("entities.bullet.bullet")


bulletsStorage = {}

function love.load()
    enemies = EnemyManager:new():getEnemies()
    player = PlayerManager:new():getPlayer()

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
    local r, g, b = love.math.colorFromBytes(242, 245, 66)
    love.graphics.setBackgroundColor(r, g, b)
end

function love.update( dt )
    mouseX, mouseY = love.mouse.getPosition()

    player:checkMoves(dt)
    player:lookAtCursor(mouseX, mouseY)
    player:onLoading()

    if love.mouse.isDown(1) then
        player:throwSpell(mouseX, mouseY)
    end

    for i, enemy in ipairs(enemies) do
        enemy:goForPlayer(dt, player)

        enemy.animation.currentTime = enemy.animation.currentTime + dt
        if enemy.animation.currentTime >= enemy.animation.duration then
            enemy.animation.currentTime = enemy.animation.currentTime - enemy.animation.duration
        end

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
end

function love.draw()
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

end