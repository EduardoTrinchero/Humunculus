posX = 250
posY = 250
angulo = 0
tam = 1
origem = 56
function love.load()
    imagem = love.graphics.newImage ( "assets/images/Denzel.png" )
    love.mouse.setVisible ( false )

end

function love.update( dt )
    if love.keyboard.isDown ("left") then
        posX = posX - 200 * dt
        
    end
    if love.keyboard.isDown ("right") then
        posX = posX + 200 * dt
    
    end
    if love.keyboard.isDown ("up") then
        posY = posY - 200 * dt
        
    end
    if love.keyboard.isDown ("down") then
        posY = posY + 200 * dt
    
    end

end

function love.draw ()
    rot = 0
    love.graphics.draw( imagem, posX, posY, 0, 10)

end