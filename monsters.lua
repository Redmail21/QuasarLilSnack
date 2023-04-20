function monstersload ()
    monstersAtlas = love.graphics.newImage('sprites/entities/Entities_Texture_atlas2.png')
    love.graphics.setDefaultFilter("nearest", "nearest")
    monsterSprite = love.graphics.newQuad((512-64),0, 64,64, monstersAtlas:getDimensions())
    monsterSpriteCodes = {
        [0] ='enemy', [1] = 'eye', [2] = 'cheese', [3] = 'crown', [4]='moon', [5]='person', [6] ='tree', [7]='star'
    }

    thrashBinSprite = love.graphics.newImage('sprites/entities/thrashBin.png')

   
end


function addmonster(x,y)
    local monster = {}
    monster.x = x
    monster.y = y
    monster.spd = 0.02
    monster.rotX = 0.1 * oneorminus()
    monster.rotY = 0.1 * oneorminus()
    monster.sx = love.math.random(27,35)
    monster.sy = love.math.random(27,35)
    monster.spriteRot = love.math.random(1, 360)
    monster.spdEnemy = love.math.random(3,7)
    monster.type = randomMonsterType()
    monster.isOnX = false
    monster.isOnY = false
    monster.xSideDir = oneorminus()
    monster.sidewayAmount = horizontalRandomPos() 
    monster.isGrabbed = false
    monster.size = 38

    monster.move = function (self, portal_x, portal_y, dt, cond)
   

        if (cond) then 
            
            if self.type == 'enemy' then
                
                enemyMovement(self,dt)                

            else
                commonMovement(self, dt)                
               
            end

                    
        end
    end
    
    monsters[#monsters+1] = monster
    
end



function auto_addmonster(x, y, time, cond)
    
    if time <= 0 and cond then
       
        addmonster(x,y)
        propsx	= x
        propsy = y
        spawntime = 0.45

    end

end


function drawMonsters()

    love.graphics.setColor(1,1,1)    
    for _,monster in pairs(monsters) do
        
        if thrashBinLifeTime > 0 then                       --Draws the enemy thrashbin
            --love.graphics.setColor(1,0,0)    
            --love.graphics.circle('fill',  thrashBinX, thrashBinY, thrashBinSize)
            love.graphics.setColor(1,1,1, thrashBinLifeTime/5)   
            love.graphics.draw(thrashBinSprite, thrashBinX, thrashBinY, 0, 0.245, 0.245, 400/2, 400/2)
        else 
            love.graphics.setColor(1,1,1, thrashBinLifeTime/5)   
            love.graphics.draw(thrashBinSprite, thrashBinX, thrashBinY, 0, 0.245, 0.245, 400/2, 400/2)
        end

        -- if monster.isOnX then
        --     love.graphics.print("ITS ON X", screen_width/2, 20)  FOR TESTING PURPOSES
        -- end    

        love.graphics.setColor(1,1,1)
        monsterSprite = love.graphics.newQuad((64*monsterSpriteValue(monsterSpriteCodes,monster.type)),0, 64,64, monstersAtlas:getDimensions())
        love.graphics.draw(monstersAtlas,monsterSprite, monster.x,  monster.y, (monster.spriteRot) *math.pi/180,0.9,0.9, 64/2,64/2) 
        --love.graphics.circle('line', monster.x, monster.y, monster.size)
        
        if thrashbin == false then
            love.graphics.print(thrashBinLifeTime, 300, 400)
        end
    end

    
end

function updateMonsters(dt)
    
    local me,ye = love.mouse.getPosition()
    enemyClickHeld(me,ye,dt)
    
    for _,monster in pairs(monsters) do
        
        if (thrashBinLifeTime >= 0 and thrashBin == false) then
            thrashBinLifeTime = thrashBinLifeTime - (dt * 0.25)
        end

        monster.spriteRot = randomRotationIncrease(monster.spriteRot)
        monster:move(portal.x,portal.y, dt, portalIsOpen)
        
        if(portalIsOpen == false) then       --remueve las entidades al cerrar el portal.          
            table.remove(monsters, _)
        end

    end

    
end

function randomMonsterType()
    num = love.math.random(1,10)

    if num <=5 then  --If equal or less to 5 then it is a common entity
        
        num2 = love.math.random(1,10)  --pick between star and person

        if num2 < 5 then
            
            return 'person'

        else

            return 'star'

        end

    -- elseif num >=6 and num<=8 then

    --     num3 = love.math.random(1,5)
    --                                  --Cheese and powerups
    --     -- if num3 == 1  then
    --     --     return 'eye'
    --     -- elseif num3 == 2 then  
    --     --     return 'cheese'
    --     -- elseif num3 == 3 then
    --     --     return 'crown' 
    --     -- elseif num3 == 4 then
    --     --     return 'moon'
    --     -- elseif num3 == 5 then
    --     --     return 'tree'
    --     -- end 
            
    --     if num3 <= 4 then
    --         return 'cheese'
    --     elseif num3 == 4 then
    --         return 'moon'
    --     elseif num3 == 5 then
    --         return 'eye'
    --     end
    
    else

        return 'enemy' --bad entity
    end

end


function monsterSpriteValue (table, value)

    for _,v in pairs(table) do
        
        if v == value then
            return _
        end
    end
    
end


function enemyMovement(self, dt)

    if self.isGrabbed == false then
        if math.floor(self.x) ~= (portal.x) and self.isOnX == false  then   --Monster movement
            
            self.x = self.x + portal.x - self.x 

            
        elseif math.floor(self.x) == (portal.x) and self.isOnX == false  then

            self.isOnX = true

        elseif self.isOnX == true then

            self.sidewayAmount =  self.sidewayAmount + (dt)*self.xSideDir
                    
            self.x = self.x + math.cos(self.sidewayAmount * 0.5) * 1.5

        end

        

        if math.floor(self.y) ~= (portal.y)  then
            
            local roty = (math.sin((dt*self.spdEnemy)) * ((portal.y - self.y)*1) ) * self.rotY     
            self.y = self.y + roty
            
        end


    end
    

end

function commonMovement(self, dt)

    if math.floor(self.x) ~= (portal_x)  then
        self.x = self.x + (math.cos((dt *5) * self.sx) * ((portal.x - self.x) *1) ) * self.rotX
                             
     end
     

     if math.floor(self.y) ~= portal_y then
         self.y = self.y + (math.sin((dt*5 ) * self.sy ) * ((portal.y - self.y)*1) ) * self.rotY
     
     end
end


function horizontalRandomPos()
    
    local val = oneorminus()
        if val == 1 then 
            return 0 
        else 
            return 360 
        end  

    
end

function enemyClickHeld(me, ye, dt)
    for _,monster in pairs(monsters) do        
        if monster.isGrabbed == true and monster.type == 'enemy'  then
            if (love.mouse.isDown(1)) then        
                
                if math.floor(monster.x) ~= (me) then   --Monster movement
            
                    monster.x = me - monster.x * dt * 1
                end

                if math.floor(monster.y) ~= (ye) then   --Monster movement
            
                    monster.y = ye - monster.y * dt * 1
                end

            end
        end
    end
end


function enemyClickReleased(me,ye)
    for _,monster in pairs(monsters) do
        
        if distanceBetween(thrashBinX, thrashBinY, monster.x, monster.y) <= thrashBinSize then
            table.remove(monsters, _)
            globalScore = globalScore + 3500
        end
        monster.isGrabbed = false
        thrashBin = false
        

    end
end

function enemyClickPressed(me,ye)
    for _,monster in pairs(monsters) do       
        if (distanceBetween(monster.x, monster.y,me,ye) <= monster.size) and monster.type == 'enemy'  then
            monster.isGrabbed = true
            thrashBin = true
            thrashBinLifeTime = 5
        end
    end
end

 