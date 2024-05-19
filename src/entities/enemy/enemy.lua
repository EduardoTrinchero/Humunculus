local ImageManager = require "src.managers.image_manager.imageManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Hurtbox = require "src.entities.hurtbox.hurtbox" 

Enemy = {
    health = 100,
    sprite = nil,
    isLive = true,
    hitbox = nil,
    hurtbox = nil,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    originOffsetX = 19,
    originOffsetY = 19,
    speed = 100
}
    
function Enemy:new (obj)
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

function Enemy:onHit(hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0  then
        self:kill()
    end
end

function Enemy:kill ()
    self.isLive = false
    self:onDeath()
end

function Enemy:onDeath()
    if not self.isLive then
        self.sprite = ImageManager:new({
            path = "assets/images/pigtauro_morto.png",
        }):getImage()
    end
end

function Enemy:goForPlayer(dt, player)
    if self.isLive then
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