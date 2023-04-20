require('powerUpsAndSuch')
require('additionalFunctions')

function buttonsLoad()
    clickSound = love.audio.newSource("sfx/click.wav", "static")
end

function addbutton()
    local button={}

    local locsqx = love.math.random(40,  (screen_width - 80) )
    local locsqy = love.math.random(40, (screen_height - 80))

    button.x = locsqx
    button.y = locsqy
    button.xSpd = randomspeed()
    button.ySpd = randomspeed()
    button.lifetime = 12
    button.isHovered = false
    button.action = powerUpOrNothing()
    button.size = 25
    button.size2= love.math.random(5, 35)
    button.opacity = 0
    button.insideOrOut = love.math.random(0,1)
    button.incDecSpd = 9
    
    button.move = function(self, delta, cond)
        if (cond) then
            repeat 

                self.x = self.x + (self.xSpd * delta)
                self.y = self.y + (-self.ySpd * delta)
                

                if(self.x> (screen_width - button.size) or self.x < self.size ) then
                    self.xSpd = -1*self.xSpd
                end
                                                                    --try with different speeds for each axis?
                if(self.y > (screen_height - button.size) or self.y < self.size ) then
                    self.ySpd = -1*self.ySpd
                end


                
            until (cond)
        end
    end
    

    buttons[#buttons+1] = button
end



 



function drawButtons()

        
    for _,button in pairs(buttons) do
        love.graphics.setColor(1,0.5,1,button.opacity)    
        love.graphics.circle('line', button.x, button.y, button.size)
        love.graphics.circle('line', button.x, button.y, button.size2)
        love.graphics.print(button.lifetime, button.x, button.y)
    end

end

function updateButtons(dt)

    ButtonSpawnTime = ButtonSpawnTime - dt

    if(ButtonSpawnTime <= 0 and portalIsOpen) then
        addbutton()
        local beginTime = 1   --timeInterval for the mathRandom
        local endTime = 5
        ButtonSpawnTime = love.math.random(beginTime, endTime) 
    end   


    for _,button in pairs(buttons) do          
        if button.opacity <=1 and button.lifetime > 2 then
            button.opacity = button.opacity + (dt*1.5)          
        end

        if button.lifetime <=2 then
            button.opacity = button.opacity - (dt*0.55)          
        end



        if button.insideOrOut == 0 then                               --makes secondary radius increase or decrease
            button.size2 = button.size2 - (dt * button.incDecSpd)

        else
            button.size2 = button.size2 + (dt * button.incDecSpd)
        end

        if button.size2 <= 1 then
            button.insideOrOut = 1

        elseif button.size2 >= 35 then
            button.insideOrOut = 0
        end


        button:move(dt, portalIsOpen)              --Los botones se mueven, podríamos añadir patrones de movimiento.
        button.lifetime = button.lifetime - dt

        if(button.lifetime) <= 0 then       --Codigo para remover los botones de la pantalla cada cierto tiempo.
            portalOpenTime = portalOpenTime - timeForcedDecrease
            timeForcedDecrease = timeForcedDecrease + 0.5
            table.remove(buttons,_)
        end

        if(portalIsOpen == false) then       --Remueve los botones al cerrar el portal.
            table.remove(buttons, _)
        end

    end

end


function buttonClickFunc(me,ye)
    for _,button in pairs (buttons) do
        
        if (distanceBetween(button.x, button.y,me,ye) <= button.size) and button.size<=button.size2 then
            table.remove(buttons,_)
            button.action()
            globalScore = globalScore + (100 * multiplier)
            portalOpenTime = portalOpenTime + 1.5 * (love.math.random(1,2))
            clickSound:play()
        end
    end
end