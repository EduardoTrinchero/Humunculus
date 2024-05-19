Hitbox = {
    radio = 0
}


function Hitbox:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end



