local ImageManager = require "src.managers.image_manager.imageManager" 
local Hurtbox = require "src.entities.hurtbox.hurtbox" 


Bullet = {
    sprite = nil,
    hurtbox = nil,
    damage = 0,
    posX = 0,
    posy = 0,
    angle = 0,
    size = 0
}


function Bullet:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    obj.hurtbox = Hurtbox:new({
        radius = obj.hurtbox
    })

    return obj
end

function Bullet:onHit(targetX, targetY)
    
end

return Bullet
