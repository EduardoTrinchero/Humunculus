local ImageManager = require "src.managers.image_manager.imageManager" 
local AnimationManager = require "src.managers.animation_manager.animationManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Hurtbox = require "src.entities.hurtbox.hurtbox" 
local Entity = require "src.entities.entity.entity"

Enemy = Entity:new({})
    
function Enemy:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Enemy:load() 
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

    self.animations = {}
    self.deathAnimationTimer = 0
end

function Enemy:update(dt, player, enemies, enemyIndex)
    self:goForPlayer(dt, player)
    self:updateAnimation(dt)

    if not self.isAlive then
        self.deathAnimationTimer = self.deathAnimationTimer - dt
        if self.deathAnimationTimer <= 0 then
            self.deathAnimationTimer = false
            table.remove(enemies, enemyIndex)
        end
    end
end

function Enemy:goForPlayer(dt, player)
    if self.isAlive then
        if self.posX ~= player.posX then 
            if self.posX < player.posX then
                self.posX = self.posX + self.speed * dt 
            end 
            if self.posX > player.posX then
                self.posX = self.posX - self.speed * dt 
            end 
        end
    
        if self.posY ~= player.posY then 
            if self.posY < player.posY then
                self.posY = self.posY + self.speed * dt 
            end 
            if self.posY > player.posY then
                self.posY = self.posY - self.speed * dt 
            end 
        end
    end
end

function Enemy:goForPlayerNormalized(dt, player)
    local moveX, moveY = 0, 0

    if self.posX ~= player.posX then 
        if self.posX < player.posX then
            moveX = moveX + 1 
        end 
        if self.posX > player.posX then
            moveX = moveX -  1
        end 
    end

    if self.posY ~= player.posY then 
        if self.posY < player.posY then
            moveY = moveY +  1
        end 
        if self.posY > player.posY then
            moveY = moveY -  1
        end 
    end

    local length = math.sqrt(moveX^2 + moveY^2)
    if length > 0 then
        moveX = moveX / length
        moveY = moveY / length
    end

    self.posX = self.posX + moveX * self.speed * dt
    self.posY = self.posY + moveY * self.speed * dt

end


return Enemy