local ImageManager = require "src.managers.image_manager.imageManager" 

Player = {
    health = 100,
    sprite = nil,
    isLive = true
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

return Player