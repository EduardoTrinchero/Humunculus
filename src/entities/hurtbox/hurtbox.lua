Hurtbox = {
    radius = 0
}


function Hurtbox:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end


function Hurtbox:hit(posX, posY, refX, refY)
    local distance = math.sqrt((refX - posX)^2 + (refY - posY)^2)
    if distance <= self.radius then
        return true
    else
        return false 
    end
end


return Hurtbox
