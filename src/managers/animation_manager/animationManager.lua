AnimationManager = {
    path = '',
    image = nil
}
    
function AnimationManager:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    self.image = obj.image
    return obj
end

function AnimationManager:newAnimation(width, height, duration)
    local animation = {}
    animation.spriteSheet = self.image;
    animation.quads = {};

    for y = 0, self.image:getHeight() - height, height do
        for x = 0, self.image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, self.image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0
    return animation
end

return AnimationManager
