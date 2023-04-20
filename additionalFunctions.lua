require('powerUpsAndSuch')

function distanceBetween(x1,y1, x2,y2)
    return math.sqrt( ((x2 - x1)^2) + ((y2 - y1)^2) )
end

function isCursorThere2(self,mx, my)
    return mx >= self.x and mx <= (self.x + self.width) and my>= self.y and my<= (self.y+ self.height)
end

function turnPortalOn()
    if portalIsOpen == false then
        portalIsOpen = true
        portalOpenTime = 10
    end
end


function nothing()
    return nil
end

function ScreenRandomY()

    local numy = love.math.random( 0, 10 )

    if (numy < 5) then

        local result = love.math.random(screen_height,(screen_height + (screen_height*0.15)))

        return result

    else 
        
        local result = love.math.random( (-1*(screen_height*0.15 )), 0)

        return result

    end

end

function ScreenRandomX()

    local numx = love.math.random( 0, 10 )


    
    if (numx < 5) then

        local result = love.math.random(screen_width,(screen_width + (screen_width*0.15)))

        return result

    else 
        
        local result = love.math.random( (-1*(screen_width*0.15)), 0)

        return result

    end


end

function oneorminus()

    if (love.math.random(0, 10) >= 5) then

        return 1

    else 
        return -1
    end

end

function powerUpOrNothing()
    local randNum = math.random(1,10)

    if randNum < 8 then
    
        return nothing
        
    else
    
        return doublePoints

    end
end

function randomspeed()
    local num = love.math.random(-10, 10) 
    if(num) >= 0  then
        return 60
    else 
        return -60
    end
end

function randomRotationIncrease (curr)
    if curr >= 360 then
        curr = 0
        return curr
    else
        curr = curr + (love.math.random(1,5))
        return curr
    end

end

