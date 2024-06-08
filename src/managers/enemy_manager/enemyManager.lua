local Pigtauro = require("entities.enemy.pigtauro")
local Zomblizard = require("entities.enemy.zomblizard")
local Vegadante = require("entities.enemy.vegadante")
local Tomatoso = require("entities.enemy.tomatoso")

EnemyManager = {}
    
function EnemyManager:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function EnemyManager:getEnemies()
    return {
        Tomatoso:new({
            health = 100,
            sprite = "assets/animations/tomatoso/tomatoso.png",
            isAlive = true,
            hitbox = 40,
            hurtbox = 40,
            speed = 60,
            posX = 800,
            posY = 600,
            angle = 0,
            size = 4,
            origin = 56,
            originOffsetX = 16,
            originOffsetY = 16,
        })
    }
end

return EnemyManager
