local ImageManager = require "src.managers.image_manager.imageManager" 
local AnimationManager = require "src.managers.animation_manager.animationManager" 
local Hitbox = require "src.entities.hitbox.hitbox"
local Entity = require "src.entities.entity.entity"

Player = Entity:new({})

  
function Player:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj:load()
    return obj
end

function Player:load()
    self.sprite = ImageManager:new({
        path = self.sprite
    }):getImage()
    self.animation = AnimationManager:new({
        }):newAnimation(self.sprite, 32, 32, 1)
    self.hitbox = Hitbox:new({
        radius = self.hitbox
    })
    self.bulletRange = Hitbox:new({
        radius = self.bulletRange
    })
    self.entityStates = {
        IDLE = "idle_",
        MOVE = 'move_',
        CAST = "cast_",
        DEAD = 'dead',
        DEBASE = 'debase'
    }
    self.animations = {
        idle_r = AnimationManager:new({
            }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonventoidle_sheet.png"
        }):getImage(), 32, 32, 1),
        idle_l = AnimationManager:new({
        }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonventoidlereverso_sheet.png"
        }):getImage(), 32, 32, 1),

        move_r = AnimationManager:new({
            }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonventoandando_sheet.png"
        }):getImage(), 32, 32, 0.5),
        move_l = AnimationManager:new({
        }):newAnimation(ImageManager:new({
            path = "assets/animations/marlon/marlonventoandandoreverso_sheet.png"
        }):getImage(), 32, 32, 0.5),


        cast_r = AnimationManager:new({
            }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonventocastando_sheet.png"
        }):getImage(), 32, 32, self.attackRatio),
        cast_l = AnimationManager:new({
        }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonventocastandoreverso_sheet.png"
        }):getImage(), 32, 32, self.attackRatio),

        dead = AnimationManager:new({
        }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonmorto.png"
        }):getImage(), 32, 32, self.attackRatio),
        debase = AnimationManager:new({
        }):newAnimation(ImageManager:new({
                path = "assets/animations/marlon/marlonmorto1.png"
        }):getImage(), 32, 32, self.attackRatio),
    }

    self.animation = self.animations['idle_r']

    self.isCasting = false
    self.castTimer = 0
    self.deathAnimationTimer = 1
end

function Player:update(dt)
    self:checkMoves(dt)
    self:onLoading()
    self:updateAnimation(dt)

    if love.mouse.isDown(1) then
        self:throwSpell(mouseX, mouseY)
    end

    if self.isCasting then
        self.castTimer = self.castTimer - dt
        if self.castTimer <= 0 then
            self.isCasting = false
        end
    end

    if not self.isAlive and not self.debase then
        self.deathAnimationTimer = self.deathAnimationTimer - dt
        if self.deathAnimationTimer <= 0 then
            self.deathAnimationTimer = false
            self.debase = true
        end
    end

    if self.isCasting then
        self:setState(self.entityStates.CAST .. self:checkSideAnimation(mouseX, mouseY))
    elseif not self.isAlive and not self.debase then    
        self:setState(self.entityStates.DEAD)
    elseif self.isMoving then
        self:setState(self.entityStates.MOVE .. self:checkSideAnimation(mouseX, mouseY))
    elseif self.debase then
        self:setState(self.entityStates.DEBASE)
    else
        self:setState(self.entityStates.IDLE .. self:checkSideAnimation(mouseX, mouseY))
    end

end

function Player:checkMoves(dt)
    local moveX, moveY = 0, 0

    if self.isAlive then
        if love.keyboard.isDown("a") then
            self.isMoving = true
            moveX = moveX - 1
        end
        if love.keyboard.isDown("d") then
            self.isMoving = true
            moveX = moveX + 1
        end
        if love.keyboard.isDown("w") then
            self.isMoving = true
            moveY = moveY - 1
        end
        if love.keyboard.isDown("s") then
            self.isMoving = true
            moveY = moveY + 1
        end

        if not love.keyboard.isDown('a') and 
        not love.keyboard.isDown('d') and 
        not love.keyboard.isDown('w') and 
        not love.keyboard.isDown('s') then 
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
end

function Player:throwSpell(mouseX, mouseY)
    if not self.isLoading and self.isAlive then
        -- self:onCast(1)
        initialX = self.posX  + self.size / 2
        initialY = self.posY  + self.size / 2

        local angle = math.atan2(mouseY-self.posY, mouseX-self.posX)

        directionX = 450 * math.cos(angle)
        directionY = 450 * math.sin(angle)

        bullet = Bullet:new({
            sprite = 'assets/images/bullet/marlonventobala.png',
            initialX = initialX,
            initialY = initialY,
            hurtbox = 50,
            angle = math.atan2(mouseY-self.posY,mouseX-self.posX),
            size = 2,
            damage = 100,

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

return Player