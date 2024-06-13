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
            speed = 200,
            posX = 250,
            posY = 250,
            size = 5,
    })
end

return PlayerManager
