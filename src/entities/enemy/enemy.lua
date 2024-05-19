local ImageManager = require "src.managers.image_manager.imageManager" 

Enemey = {
    health = 100,
    sprite = nil,
    isLive = true,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    originOffsetX = 19,
    originOffsetY = 19,
    speed = 150
}
    
function Enemey:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()
    return obj
end

function Enemey:onHit(hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0 then
        self.kill()
    end 
end

function Enemey:kill ()
    self.isLive = false
end

function Enemey:goForPlayer(dt, player)

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

function Enemey:goForPlayerNormalized(dt, player)
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

return Enemey