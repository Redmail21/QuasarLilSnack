require('powerUpsAndSuch')
require('additionalFunctions')

function addCButton()
    local CButton={}

    local locsqx = love.math.random(40,  (screen_width - 80) )
    local locsqy = love.math.random(40, (screen_height - 80))

    CButton.x = locsqx
    CButton.y = locsqy
    CButton.xSpd = randomspeed()
    CButton.ySpd = randomspeed()
    CButton.lifetime = 12
    CButton.isHovered = false
    CButton.action = powerUpOrNothing()
    CButton.size = 30
    CButton.size2= 20
    CButton.opacity = 0
    CButton.colours = { 'red', 'green', 'blue', }
    CButton.colourOutside = CButton.colours[love.math.random(1, #CButton.colours)]
    CButton.currValue = love.math.random(1, #CButton.colours)
    CButton.colourInside = CButton.colours[CButton.currValue]
    CButton.colourMatched = false --Extra gameplay implementation
    
    CButton.move = function(self, delta, cond)
        if (cond) then
            repeat 

                self.x = self.x + (self.xSpd * delta)
                self.y = self.y + (-self.ySpd * delta)
                

                if(self.x> (screen_width - CButton.size) or self.x < self.size ) then
                    self.xSpd = -1*self.xSpd
                end
                                                                    --try with different speeds for each axis?
                if(self.y > (screen_height - CButton.size) or self.y < self.size ) then
                    self.ySpd = -1*self.ySpd
                end


                
            until (cond)
        end
    end
    

    CButtons[#CButtons+1] = CButton

end



function drawCButtons()

        
    for _,CButton in pairs(CButtons) do 

        if CButton.colourInside == 'red' then
            
            love.graphics.setColor(1,0,0,CButton.opacity)   
            
        elseif CButton.colourInside == 'green' then

            love.graphics.setColor(0,1,0,CButton.opacity)   
            
        elseif CButton.colourInside == 'blue' then
            
            love.graphics.setColor(0,0,1,CButton.opacity)   
            
        end

        --love.graphics.setColor(0,0,1,CButton.opacity)   
        love.graphics.circle('fill', CButton.x, CButton.y, CButton.size)

        
        

        if CButton.colourOutside == 'red' then
            
            love.graphics.setColor(1,0,0,CButton.opacity)   
            
        elseif CButton.colourOutside == 'green' then

            love.graphics.setColor(0,1,0,CButton.opacity)   
            
        elseif CButton.colourOutside == 'blue' then
            
            love.graphics.setColor(0,0,1,CButton.opacity)   
            
        end


        love.graphics.circle('fill', CButton.x, CButton.y, CButton.size2)
        
        --love.graphics.setColor(0.5,1,1,CButton.opacity)    
        love.graphics.print(CButton.lifetime, CButton.x, CButton.y)
    end

end



function updateCButtons(dt)

    
      

    CButtonSpawnTime = CButtonSpawnTime - dt

    if(CButtonSpawnTime <= 0 and portalIsOpen) then
        addCButton()
        CButtonSpawnTime = love.math.random(6, 8) 
    end   


    for _,CButton in pairs(CButtons) do       
        
         if CButton.colourInside == CButton.colourOutside and CButton.lifetime >11 then --Checks that they don't share the same colour
            table.remove(CButtons, _)
            addCButton()
         end

        if CButton.opacity <=1 and CButton.lifetime > 2 then
            CButton.opacity = CButton.opacity + (dt*1.5)          
        end

        if CButton.colourInside == CButton.colourOutside and CButton.lifetime <=11 then
            globalScore = globalScore + 3000
            portalOpenTime = portalOpenTime + 3
            table.remove(CButtons, _)
        end

        if CButton.lifetime <=2 then
            CButton.opacity = CButton.opacity - (dt*0.55)          
        end


        CButton:move(dt, portalIsOpen)              --Los botones se mueven, podríamos añadir patrones de movimiento.
        CButton.lifetime = CButton.lifetime - dt

        if(CButton.lifetime) <= 0 then       --Codigo para remover los botones de la pantalla cada cierto tiempo.
            portalOpenTime = portalOpenTime - 1
            table.remove(CButtons,_)
        end

        if(portalIsOpen == false) then       --Remueve los botones al cerrar el portal.
            table.remove(CButtons, _)
        end

    end

end



function CButtonClickFunc(me,ye)
    for _, CButton in pairs (CButtons) do

        if (distanceBetween(CButton.x, CButton.y,me,ye) <= CButton.size) then
           
            if CButton.currValue == #CButton.colours then
                CButton.currValue = 1
            else    
                CButton.currValue = CButton.currValue + 1
            end

            CButton.colourOutside = CButton.colours[CButton.currValue]
            --DO SOMETHING
        end
    end
end