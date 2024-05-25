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

    if obj.sprite then
        obj.sprite = ImageManager:new({
            path = obj.sprite
        }):getImage()
    end

    if obj.hitbox then
        obj.hitbox = Hitbox:new({
            radius = obj.hitbox
        })
    end
    
    return obj
end

function Entity:draw()
    love.graphics.draw(
        self.sprite, 
        self.posX, self.posY, 
        self.angle, self.size, self.size, 
        self.originOffsetX, self.originOffsetY
    )
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

return Entity