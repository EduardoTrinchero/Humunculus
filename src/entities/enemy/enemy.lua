local ImageManager = require "src.managers.image_manager.imageManager" 

Enemey = {
    health = 100,
    sprite = nil,
    isLive = true
}
    
function Enemey:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()
    return obj
end

function Enemey:onHit (hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0 then
        self.kill()
    end 
end

function Enemey:kill ()
    self.isLive = false
end

return Enemey