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

function Bullet:dispatch(dt, bulletsStorage, target)
    for i, bullet in ipairs(bulletsStorage) do
        bullet.currentX = bullet.currentX + (bullet.directionX * dt)
        bullet.currentY = bullet.currentY + (bullet.directionY * dt)

        if target.hitbox:hit(target.posX, target.posY, bullet.currentX, bullet.currentY) and target.isAlive then 
            target:onHit(bullet.damage)
            table.remove(bulletsStorage, i)
        end
    end
end

return Bullet
