local Pigtauro = require("entities.enemy.pigtauro")
local Zomblizard = require("entities.enemy.zomblizard")
local Vegadante = require("entities.enemy.vegadante")

EnemyManager = {}
    
function EnemyManager:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function EnemyManager:getEnemies()
    return {
        Pigtauro:new({
            health = 100,
            sprite = "assets/images/pigtauro/pigtauro.png",
            isAlive = true,
            hitbox = 50,
            hurtbox = 50,
            speed = 80,    
            posX = 10,
            posY = 10,
            angle = 0,
            size = 4,
            origin = 56,
            originOffsetX = 19,
            originOffsetY = 19,
        }),
        Zomblizard:new({
            health = 100,
            sprite = "assets/images/zomblizard/sprt_zomblizard_prsg.png",
            isAlive = true,
            hitbox = 40,
            hurtbox = 40,
            speed = 120,
            posX = 1000,
            posY = 10,
            angle = 0,
            size = 4,
            origin = 56,
            originOffsetX = 18,
            originOffsetY = 19,
        }),
        Vegadante:new({
            health = 100,
            sprite = "assets/images/vegadante/vegadante.png",
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
            originOffsetY = 26,
        })
    }
end

return EnemyManager
