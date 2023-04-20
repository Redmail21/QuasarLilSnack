function addGuiElement(w, h, x, y,cFunction, imgPath)
    local guiElement = {}

    guiElement.x = x
    guiElement.y = y
    guiElement.sprite = love.graphics.newImage(imgPath)
    guiElement.width = w
    guiElement.height = h
    guiElement.isHovered = false
    
    guiElement.action = cFunction

    guiElements[#guiElements+1] = guiElement

    

end


function drawGui()

    love.graphics.setColor(1,1,1)
    for _,guiElement in pairs(guiElements) do
        --green activator
        if (guiElement.isHovered) then                     --testing
            --love.graphics.print("INSIDE!", 0, 50)
        end
        
        --love.graphics.rectangle('fill', guiElement.x, guiElement.y ,guiElement.width,guiElement.height)
        love.graphics.draw(guiElement.sprite, guiElement.x, guiElement.y, 0, 0.1, 0.1)
    end


    
end

function updateGui(me,ye)
    for _,guiElement in pairs(guiElements) do
        --green activator
        guiElement.isHovered = isCursorThere2(guiElement,me,ye)

    end
end

