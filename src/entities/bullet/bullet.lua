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

function Bullet:update(dt, bulletsStorage, targets)
    self.currentX = self.currentX + (self.directionX * dt)
    self.currentY = self.currentY + (self.directionY * dt)  

    if targets then
        for i, target in ipairs(targets) do
            if target.hitbox:hit(target.posX, target.posY, self.currentX, self.currentY) and target.isAlive then 
                target:onHit(self.damage)
                table.remove(bulletsStorage, i)
            end
        end
    end
end

return Bullet
