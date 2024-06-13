local ImageManager = require "src.managers.image_manager.imageManager" 
local AnimationManager = require "src.managers.animation_manager.animationManager"  

local Hitbox = require "src.entities.hitbox.hitbox"
local Hurtbox = require "src.entities.hurtbox.hurtbox" 

local Enemy = require 'src.entities.enemy.enemy'

Tomatoso = Enemy:new({
    health = 100,
    sprite =  "assets/animations/tomatoso/tomatoso.png",
    animation = nil,
    isAlive = true,
    hitbox = 65,
    hurtbox = 50,

    posX = 10,
    posY = 10,
    angle = 0,
    size = 4,
    origin = 56,
    originOffsetX = 19,
    originOffsetY = 19,
})

function Tomatoso:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    obj.animation = AnimationManager:new({
    }):newAnimation(obj.sprite, 32, 32, 1)

    obj.hitbox = Hitbox:new({
        radius = obj.hitbox
    })

    obj.hurtbox = Hurtbox:new({
        radius = obj.hurtbox
    })

    self.animations = {
        moving = AnimationManager:new({
            }):newAnimation(ImageManager:new({
                path = "assets/animations/tomatoso/tomatoso.png"
        }):getImage(), 32, 32, 1),
        dead = AnimationManager:new({
            }):newAnimation(ImageManager:new({
                path = "assets/animations/tomatoso/tomatosomorto.png"
        }):getImage(), 32, 32, 1),
        f = AnimationManager:new({
        }):newAnimation(ImageManager:new({
            path = "assets/animations/tomatoso/tomatosomorto1.png"
    }):getImage(), 32, 32, 1),
    }

    self.animation = self.animations['moving']
    return obj
end

return Tomatoso
