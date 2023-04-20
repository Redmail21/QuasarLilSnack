function saveHighScore(Score)
    love.filesystem.write("highScore.txt", tostring(Score))
  end

function loadHighScore()
    local score = tonumber("1")
    
    if love.filesystem.getInfo("highScore.txt") then
      score = love.filesystem.read("highScore.txt")
    
    else

      love.filesystem.write("highScore.txt", 10)
      
    end

    return tonumber(score)
end