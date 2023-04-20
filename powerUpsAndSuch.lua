require('globalVariables')
powerUpLibrary ={doublePoints}

function addPowerUp()
    
    local powerUp = {}
    powerUp.power = pFunction
    powerUp.time =  time

    powerUps[#powerUps+1] = powerUp

end

function updatePowerUps(dt)
    multiplierTimer = multiplierTimer - dt

    if multiplierTimer <= 0 then
        multiplier = 1
    end


    for _, power in pairs(powerUps) do
        power.time = power.time - dt

        if (power.time <=0) then
            power.powerOff()
        end

    end

end


function doublePoints()
    
    if multiplier  == 1 then
        
        multiplier = 2
        multiplierTimer = 5

    elseif multiplier  == 1 then

        multiplierTimer = 5

    end
    
    
end

