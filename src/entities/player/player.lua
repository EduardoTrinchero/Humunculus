local ImageManager = require "src.managers.image_manager.imageManager" 

Player = {
    health = 100,
    sprite = nil,
    isLive = true,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    originOffsetX = 19,
    originOffsetY = 19,
    speed = 300
}
    
function Player:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()
    return obj
end

function Player:onHit (hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0 then
        self.kill()
    end 
end

function Player:kill ()
    self.isLive = false
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
return Player