local ImageManager = require "src.managers.image_manager.imageManager" 

Player = {
    health = 100,
    sprite = nil,
    isLive = true,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    origin = 56
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
    if love.keyboard.isDown ("a") then
        self.posX = self.posX - 300 * dt
        
    end
    if love.keyboard.isDown ("d") then
        self.posX = self.posX + 300 * dt
    
    end
    if love.keyboard.isDown ("w") then
       self.posY = self.posY - 300 * dt
        
    end
    if love.keyboard.isDown ("s") then
       self.posY = self.posY + 300 * dt
    end
end

return Player