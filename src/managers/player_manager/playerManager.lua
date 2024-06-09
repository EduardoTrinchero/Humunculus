local Player = require("entities.player.player")

PlayerManager = {}
    
function PlayerManager:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function PlayerManager:getPlayer()
    return  Player:new({
            health = 100,
            sprite = "assets/animations/marlon/marlonventoidle_sheet.png",
            isAlive = true,
            hitbox = 65,
    
            posX = 250,
            posY = 250,
            angle = 0,
            size = 3,
            originOffsetX = 19,
            originOffsetY = 19,
            attackRatio = 1
    })
end

return PlayerManager
