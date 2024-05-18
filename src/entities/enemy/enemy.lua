local ImageManager = require "src.managers.image_manager.imageManager" 

Enemey = {
    health = 100,
    sprite = nil,
    isLive = true,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    origin = 56
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

function Enemey:onHit(hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0 then
        self.kill()
    end 
end

function Enemey:kill ()
    self.isLive = false
end

function Enemey:goForPlayer(dt, player)

    if self.posX ~= player.posX then 
        if self.posX < player.posX then
            self.posX = self.posX + 125 * dt 
        end 
        if self.posX > player.posX then
            self.posX = self.posX - 125 * dt 
        end 
    end

    if self.posY ~= player.posY then 
        if self.posY < player.posY then
            self.posY = self.posY + 125 * dt 
        end 
        if self.posY > player.posY then
            self.posY = self.posY - 125 * dt 
        end 
    end

end

return Enemey