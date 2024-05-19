local ImageManager = require "src.managers.image_manager.imageManager" 

Bullet = {
    sprite = nil,

    posX = 0,
    posy = 0
}


function Bullet:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    return obj
end

function Bullet:go(targetX, targetY)
    
end

return Bullet
