local ImageManager = require "src.managers.image_manager.imageManager" 

Background = Entity:new({})

function Background:new ( obj )
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    return obj
end

function Background:draw()
    for i = 0, love.graphics.getWidth() / self.sprite:getWidth() do
        for j = 0, love.graphics.getHeight() / self.sprite:getHeight() do
            love.graphics.draw(self.sprite, i * self.sprite:getWidth(), j * self.sprite:getHeight())
        end
    end
end

return Background
