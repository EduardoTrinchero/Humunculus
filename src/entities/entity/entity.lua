Entity = {
    health = 100,
    sprite = nil,
    isAlive = true,
    hitbox = nil,
    hurtbox = nil,
    posX = 0,
    posY = 0,
    angle = 0,
    size = 1,
    originOffsetX = 19,
    originOffsetY = 19,
    speed = 100,
    bulletsStorage = {}
}
Entity.__index = Entity

function Entity:new(obj)
    obj = obj or {}
    setmetatable(obj, self)    
    obj:load()
    return obj
end

function Entity:load()
    if self.sprite then
        self.sprite = ImageManager:new({
            path = self.sprite
        }):getImage()
    end

    if self.hitbox then
        self.hitbox = Hitbox:new({
            radius = self.hitbox
        })
    end
end

function Entity:draw()
    
    if self.animation then 
        local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1
        love.graphics.draw(
            self.animation.spriteSheet, 
            self.animation.quads[spriteNum],
            self.posX, self.posY, 
            self.angle, self.size, self.size, 
            self.originOffsetX, self.originOffsetY
        )
    else            
        love.graphics.draw(
            self.sprite, 
            self.posX, self.posY, 
            self.angle, self.size, self.size, 
            self.originOffsetX, self.originOffsetY
        )
    end
end

function Entity:onHit(hitDamage)
    self.health = self.health - hitDamage
    if self.health < 0 then
        self:kill()
    end 
end

function Entity:kill()
    self.isAlive = false
    self:onDeath()
end

function Entity:onDebug()
    love.graphics.circle("line", self.posX, self.posY, 10)
    love.graphics.circle("line", self.posX, self.posY, 40)
end

function Entity:updateAnimation(dt)
    self.animation.currentTime = self.animation.currentTime + dt
    if self.animation.currentTime >= self.animation.duration then
        self.animation.currentTime = self.animation.currentTime - self.animation.duration
    end
end

function Entity:setState(state)
    if self.state ~= state then
        self.state = state
        self.animation = self.animations[state]
    end
end

return Entity