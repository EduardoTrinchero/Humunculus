local ImageManager = require "src.managers.image_manager.imageManager" 
local AnimationManager = require "src.managers.animation_manager.AnimationManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Entity = require "src.entities.entity.entity"
local Dispatcher = require "utils.Dispatcher"

Player = Entity:new({})
    
function Player:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self

    obj.sprite = ImageManager:new({
        path = obj.sprite
    }):getImage()

    obj.animation = AnimationManager:new({
    }):newAnimation(obj.sprite, 32, 32, 1)

    obj.hitbox = Hitbox:new({
        radius = obj.hitbox
    })

    obj.bulletRange = Hitbox:new({
        radius = obj.bulletRange
    })

    obj.isMoving = false

    return obj
end

function Player:checkMoves(dt)
    local moveX, moveY = 0, 0

    if love.keyboard.isDown("a") then
        self.isMoving = true
        moveX = moveX - 1
    elseif love.keyboard.isDown("d") then
        self.isMoving = true
        moveX = moveX + 1
    elseif love.keyboard.isDown("w") then
        self.isMoving = true
        moveY = moveY - 1
    elseif love.keyboard.isDown("s") then
        self.isMoving = true
        moveY = moveY + 1
    else
        self.isMoving = false
    end

    local length = math.sqrt(moveX^2 + moveY^2)
    if length > 0 then
        moveX = moveX / length
        moveY = moveY / length
    end

    self.posX = self.posX + moveX * self.speed * dt
    self.posY = self.posY + moveY * self.speed * dt
end

function Player:throwSpell(mouseX, mouseY)
    if not self.isLoading then
        self:onCast()
        initialX = self.posX  + self.size / 2
        initialY = self.posY  + self.size / 2

        local angle = math.atan2(mouseY-self.posY, mouseX-self.posX)

        directionX = 450 * math.cos(angle)
        directionY = 450 * math.sin(angle)

        bullet = Bullet:new({
            sprite = 'assets/images/bullet/sprt_magia.png',
            initialX = initialX,
            initialY = initialY,
            hurtbox = 50,
            angle = math.atan2(mouseY-self.posY,mouseX-self.posX),
            size = 2,
            damage = 10,

            currentX = self.posX,
            currentY = self.posY,

            directionX = directionX,
            directionY = directionY,

            originOffsetX = 20,
            originOffsetY = 20,
        })
        table.insert(self.bulletsStorage, bullet)
        self.isLoading = true
    else

    end
end

function Player:lookAtCursor(mouseX, mouseY)
    local angle = math.atan2(mouseY-self.posY,mouseX-self.posX)
    self.angle = angle
end

function Player:onLoading()

    if player.isLoading then 
        time = love.timer.getTime()

        if not self.initialLoadTime then 
            self.initialLoadTime = time
        else
            if time > self.initialLoadTime + self.attackRatio then
                self.isLoading = false
                self.initialLoadTime = nil
            end
        end
    end

end

function Player:onIdle()
    if self.isMoving == true then
        image = ImageManager:new({
            path = "assets/animations/marlon/marlonventoidle_sheet.png"
        }):getImage()
        self.animation = AnimationManager:new({
        }):newAnimation(image, 32, 32, 1)
    end
end

function Player:onMove()
    if self.isMoving == false then
        image = ImageManager:new({
            path = "assets/animations/marlon/marlonventoandando_sheet.png"
        }):getImage()
        self.animation = AnimationManager:new({
        }):newAnimation(image, 32, 32, 1)
    end
end

function Player:onCast()
    image = ImageManager:new({
        path = "assets/animations/marlon/marlonventocastando_sheet.png"
    }):getImage()
    self.animation = AnimationManager:new({
    }):newAnimation(image, 32, 32, 1)
end

return Player