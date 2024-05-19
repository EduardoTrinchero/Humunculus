local ImageManager = require "src.managers.image_manager.imageManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Hurtbox = require "src.entities.hurtbox.hurtbox" 

local Enemy = require 'src.entities.enemy.enemy'

Zomblizard = Enemy:new({
    health = 100,
    sprite = "assets/images/zomblizard/sprt_zomblizard_prsg.png",
    isLive = true,
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

function Zomblizard:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    obj.hitbox = Hitbox:new({
        radius = obj.hitbox
    })

    obj.hurtbox = Hurtbox:new({
        radius = obj.hurtbox
    })

    return obj
end

function Zomblizard:onDeath()
    if not self.isLive then
        self.sprite = ImageManager:new({
            path = "assets/images/zomblizard/sprt_zomblizard_morto.png",
        }):getImage()
    end
end


return Zomblizard
