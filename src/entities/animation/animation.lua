local AnimationManager = require "src.managers.animation_manager.animationManager" 

Animation = Entity:new({})

function Animation:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = AnimationManager:new({
        path = obj.sprite
    }):getImage()

    obj.hurtbox = Hurtbox:new({
        radius = obj.hurtbox
    })

    return obj
end

return Animation
