local ImageManager = require "src.managers.image_manager.imageManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Entity = require "src.entities.entity.entity"

Player = Entity:new({})
    
function Player:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    obj.hitbox = Hitbox:new({
        radius = obj.hitbox
    })

    obj.bulletRange = Hitbox:new({
        radius = obj.bulletRange
    })

    return obj
end

function Player:checkMoves(dt)
    local moveX, moveY = 0, 0

    if love.keyboard.isDown("a") then
        moveX = moveX - 1
    end
    if love.keyboard.isDown("d") then
        moveX = moveX + 1
    end
    if love.keyboard.isDown("w") then
        moveY = moveY - 1
    end
    if love.keyboard.isDown("s") then
        moveY = moveY + 1
    end

    local length = math.sqrt(moveX^2 + moveY^2)
    if length > 0 then
        moveX = moveX / length
        moveY = moveY / length
    end

    self.posX = self.posX + moveX * self.speed * dt
    self.posY = self.posY + moveY * self.speed * dt
end

function Player:throwSpell(mouseX, mouseY)
    if not self.isLoading then
        initialX = self.posX  + self.size / 2
        initialY = self.posY  + self.size / 2

        local angle = math.atan2(mouseY-self.posY, mouseX-self.posX)

        directionX = 450 * math.cos(angle)
        directionY = 450 * math.sin(angle)

        bullet = Bullet:new({
            sprite = 'assets/images/bullet/sprt_magia.png',
            initialX = initialX,
            initialY = initialY,
            hurtbox = 50,
            angle = 0,
            size = 2,
            damage = 10,

            currentX = self.posX,
            currentY = self.posY,

            directionX = directionX,
            directionY = directionY,

            originOffsetX = 1,
            originOffsetY = 1,
        })
        table.insert(self.bulletsStorage, bullet)
        self.isLoading = true
    else

    end
end

function Player:lookAtCursor(mouseX, mouseY)
    local angle = math.atan2(mouseY-self.posY,mouseX-self.posX)
    self.angle = angle
end

function Player:onLoading()

    if player.isLoading then 
        time = love.timer.getTime()

        if not self.initialLoadTime then 
            self.initialLoadTime = time
        else
            if time > self.initialLoadTime + self.attackRatio then
                self.isLoading = false
                self.initialLoadTime = nil
            end
        end
    end

end

return Player