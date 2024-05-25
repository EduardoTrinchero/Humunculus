local ImageManager = require "src.managers.image_manager.imageManager" 
local Hurtbox = require "src.entities.hurtbox.hurtbox" 
local Entity = require "src.entities.entity.entity"

Bullet = Entity:new({})

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

return Bullet
