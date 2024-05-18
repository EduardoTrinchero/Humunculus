ImageManager = {
    path = '',
    image = nil
}
    
function ImageManager:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.image = love.graphics.newImage(obj.path)
    return obj
end

function ImageManager:applyFilters()
    self.image:setFilter("nearest", "nearest")
    return self.image
end

function ImageManager:getImage()
    return self:applyFilters()
end

return ImageManager
