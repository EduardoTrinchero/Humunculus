posX = 250
posY = 250
angulo = 0
tam = 1
origem = 56


function love.load()
    imagem = love.graphics.newImage ( "assets/images/sprt_marlon.png" )
    mouse = love.mouse.getSystemCursor('crosshair')
    love.mouse.setVisible ( true )
end

function love.update( dt )
    if love.keyboard.isDown ("left") then
        posX = posX - 300 * dt
        
    end
    if love.keyboard.isDown ("right") then
        posX = posX + 300 * dt
    
    end
    if love.keyboard.isDown ("up") then
        posY = posY - 300 * dt
        
    end
    if love.keyboard.isDown ("down") then
        posY = posY + 300 * dt
    
    end

    if love.mouse.isDown (1) then
        local x, y = love.mouse.getPosition()
        posY = y
        posX = x
    end

end

function love.draw ()
    rot = 0
    love.graphics.draw( imagem, posX, posY, 0, 4)
    
end