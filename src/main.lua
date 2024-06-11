local EnemyManager = require("managers.enemy_manager.enemyManager")
local PlayerManager = require("managers.player_manager.playerManager")

local Bullet = require("entities.bullet.bullet")
local Background = require("entities.background.background")


bulletsStorage = {}

function love.load()
    enemies = EnemyManager:new():getEnemies()
    player = PlayerManager:new():getPlayer()

    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
    background = Background:new({
        sprite="assets/images/background/sala2.png"
    })
end

function love.update( dt )
    mouseX, mouseY = love.mouse.getPosition()

    player:update(dt)

    for i, enemy in ipairs(enemies) do
        enemy:goForPlayer(dt, player)
        enemy:updateAnimation(dt)

        if player.bulletsStorage then
            Bullet:dispatch(dt, player.bulletsStorage, enemy)
        end
    end
end

function love.draw()
    background:draw()

    player:draw()
    -- player:onDebug()
    print(string.format('health %s', player.health))
    for i, enemy in ipairs(enemies) do
        enemy:draw()

        if player.hitbox:hit(player.posX, player.posY, enemy.posX, enemy.posY) and player.isAlive then 
            player:onHit(1)
        end
        -- enemy:onDebug()
    end

    if player.bulletsStorage then
        for i, bullet in ipairs(player.bulletsStorage) do  
            love.graphics.draw( bullet.sprite, bullet.currentX, bullet.currentY, bullet.angle, bullet.size,  bullet.size, bullet.originOffsetX, bullet.originOffsetY)
            -- love.graphics.circle("line", bullet.currentX, bullet.currentY, 10)
        end
    end    

end