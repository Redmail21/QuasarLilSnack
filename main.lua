
function love.load()
    
    anim8 = require('libs/anim8')
    sti = require('libs/sti')
    --gameMap = sti('sprites/Map/Test01.lua')
    camera = require('libs/hump-master/camera')
    cam = camera()
    require('requirements')
    monstersload ()
    buttonsLoad()
    portalLoad()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.mouse.setVisible( true )
    stars = love.graphics.newImage('sprites/entities/stars.png')
    crosshair = love.graphics.newImage('sprites/crosshairs/cross.png')
    font1 = love.graphics.newFont('fonts/nokiafc22.ttf', 13)

    addGuiElement(753*0.1,456*0.1, (screen_width - 120), 30,turnPortalOn, "sprites/Portal/switch.png") --adds the green opener

    highScore = loadHighScore()

    
    
    
end






function love.update(dt)

    local me, ye = love.mouse.getPosition()         
    --variables that change overtime
    spawntime = spawntime - dt
    gameTime = gameTime + dt
    monsterCount = table.getn(monsters)
    buttonCount = table.getn(buttons)
     
    --update portal
    portalUpdate(dt, me, ye)    
    --update buttons
    updateButtons(dt)   
    updateCButtons(dt)
    --update Gui Elements
    updateGui(me,ye)
    --automatic props/bodies/monster insertions
    auto_addmonster(ScreenRandomX(),ScreenRandomY(),spawntime, portalIsOpen)
    --update monsters etc
    updateMonsters(dt)
    --update powerUps
    updatePowerUps(dt)

    --sfx/music
    
            
end



function love.draw()
    
    love.graphics.setFont( font1 )
    local xe, ye = love.mouse.getPosition() 
    
    --dev info and the score
    -- love.graphics.setColor(1,1,1)
    -- love.graphics.print(propsx, 0, 0)
    -- love.graphics.print(propsy, 0, 10)
    -- love.graphics.setColor(0,0.8,1)
    -- love.graphics.print(monsterCount, 0, 20)
    -- love.graphics.print(buttonCount, 0, 30)
    -- love.graphics.print(highScore, 0, 40)
    -- love.graphics.print(thrashBinLifeTime, 0, 70)
    -- love.graphics.setColor(255,255,0)   --gameTime
    -- love.graphics.printf(gameTime, 0, 60,150,left, 0, 0,0, 40)
    
    
    if portalOpenTime == 0 then
        love.graphics.setColor(140,140,140)
        love.graphics.print(math.floor(portalOpenTime), screen_width/2, 20,0,1,1, 40)
    else
        love.graphics.setColor(140,140,0)
        love.graphics.print(math.floor(portalOpenTime), screen_width/2, 20,0,1,1, 40)
    end


    if globalScore == 0 then
        --love.graphics.print(globalScore, screen_width/2, 40,0,1.5,1.5, 0)
        love.graphics.printf(globalScore, screen_width/2, 40, 150, left, 0,  1.5, 1.5, 40, 0)
    else
        --love.graphics.print(globalScore, screen_width/2, 40,0,1.5,1.5, 0)
        local sizex, sizey = 40,40
        love.graphics.printf(globalScore, screen_width/2, 40, 150, left, 0,  1.5, 1.5, 40, 0)


    end
    
    portalDraw()

    --green activator
    drawGui()

    --buttons
    drawButtons()
    drawCButtons()
    --monsters/entities
    drawMonsters()

  
    --draws the crosshair
    love.graphics.setColor(1,1,1)
    --love.graphics.draw(crosshair, (xe) , (ye), 0, 0.5,0.5, crosshair:getWidth()/2,crosshair:getHeight()/2) 

    --love.graphics.circle('line', portal.x, portal.y, portal.width)
    if distanceBetween(portal.x, portal.y, xe, ye) <= portal.width then                     --testing
        --love.graphics.print("cursor inside the portal!", 0, 70)
    end

    if multiplier == 2 then                                                         --testing
        love.graphics.print("Double points!", 0, 80)              
    end

end







function love.mousereleased(x, y, mbutton)
    
    local me, ye = love.mouse.getPosition()

    if mbutton == 1 then   
        
        for _,guiElement in pairs(guiElements) do
            --green activator
            if guiElement.isHovered then
                guiElement.action()                        
            end 

        end

        buttonClickFunc(me,ye)

        CButtonClickFunc(me,ye)

        enemyClickReleased(me,ye)

    end
    
end

function love.mousepressed(x, y, mbutton, istouch)
    
    local me, ye = love.mouse.getPosition()

    if mbutton == 1 then   
        enemyClickPressed(me,ye)
    end
end


-- function love.touchpressed( id, x, y, dx, dy, pressure ) 
--     local me, ye = love.mouse.getPosition()

--     if mbutton == 1 then   
--         enemyClickPressed(me,ye)
--     end
    
-- end

-- function love.touchreleased( id, x, y, dx, dy, pressure )

--     local me, ye = love.mouse.getPosition()

--     if mbutton == 1 then   
        
--         for _,guiElement in pairs(guiElements) do
--             --green activator
--             if guiElement.isHovered then
--                 guiElement.action()                        
--             end 
--         end
--     end

--     buttonClickFunc(me,ye)

--     CButtonClickFunc(me,ye)

--     enemyClickReleased(me,ye)
-- end