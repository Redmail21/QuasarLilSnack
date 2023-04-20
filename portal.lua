require('globalVariables')
require('additionalFunctions')
require('libs/anim8')
portal = {}
portal.x = screen_width/2
portal.y = screen_height/2
portal.spriteSheet = love.graphics.newImage('sprites/entities/Daemon.png')
portal.sprite = love.graphics.newQuad(0, 0, 425, 320, portal.spriteSheet:getDimensions())
portal.zzzSprite = love.graphics.newImage('sprites/entities/sleepyDaemonAtlas.png')
portal.zzzGrid = anim8.newGrid(400, 400, portal.zzzSprite:getWidth(), portal.zzzSprite:getHeight() )
portal.animations = {}
portal.animations.closed = anim8.newAnimation(portal.zzzGrid('1-3', 1), 0.3)
portal.width = 425/5
portal.height = 320/5
portal.zzzSpriteOpacity = 1
portal.isHovered = False

function portalLoad()
    menuMusic = love.audio.newSource("sfx/CUSTOM bgm_action_2.mp3", "stream")
    gameMusic = love.audio.newSource("sfx/bgm_menu.mp3", "stream")
end

function portalDraw()
    love.graphics.setColor(1,1,1)
    --love.graphics.circle('line', portal.x, portal.y - 25, screen_width/8)
    
    if portalIsOpen then

        local sprite = love.graphics.newQuad(0, 320, 425, 320, portal.spriteSheet:getDimensions())        
        love.graphics.draw(portal.spriteSheet, sprite, portal.x, portal.y, 0, 0.5, 0.5, (portal.spriteSheet:getDimensions()/2), (portal.spriteSheet:getDimensions()/2))
        
        love.graphics.setColor(255, 255, 255, portal.zzzSpriteOpacity)
        portal.animations.closed:draw(portal.zzzSprite, portal.x, portal.y, 0,0.3,0.3, -screen_width*0.15, portal.zzzSprite:getHeight()*1.5) --portal sleepy, offset by some strange amounts, should test other screens
    else 
        local sprite = love.graphics.newQuad(0, 0, 425, 320, portal.spriteSheet:getDimensions())
        love.graphics.draw(portal.spriteSheet, sprite, portal.x, portal.y, 0, 0.5, 0.5, (portal.spriteSheet:getDimensions()/2), (portal.spriteSheet:getDimensions()/2))
        --love.graphics.draw(portal.extraSpriteSheet00, portal.extraSprite00, portal.x, portal.y, 0, 0.2,0.2)
        
        portal.animations.closed:draw(portal.zzzSprite, portal.x, portal.y, 0,0.3,0.3, -screen_width*0.15, portal.zzzSprite:getHeight()*1.5) --portal sleepy, offset by some strange amounts, should test other screens
        
    end

   
end

function portalUpdate(dt,xe, ye)

    if portalIsOpen == false then
        menuMusic:play()
        gameMusic:stop()
    end

    if (portalOpenTime <=0) then
        portalIsOpen = false
        
        if globalScore > highScore then
            highScore = globalScore
            saveHighScore(highScore)
        end
        
        globalScore = 0
        
    end

    if portalIsOpen then
        portal.zzzSpriteOpacity = portal.zzzSpriteOpacity - dt*1.5
        menuMusic:stop()
        gameMusic:play()
    end
 
    if (portalOpenTime > 0) then
        portalOpenTime = portalOpenTime - dt
    end

    for _,monster in pairs(monsters) do

        if distanceBetween(portal.x, portal.y, monster.x, monster.y) <= portal.width then --corregir con el nuevo radio del circulo
            
            if monster.type == 'enemy' and monster.isGrabbed ~= true then
                globalScore = globalScore - 5000
                portalOpenTime = portalOpenTime - 2.5
                table.remove(monsters, _)
            elseif monster.type ~= 'enemy' then
                globalScore = globalScore + (100 * multiplier)
                --portalOpenTime = portalOpenTime + 1.5
                table.remove(monsters, _)
            end

            
        end

    end

   portal.animations.closed:update(dt)
end