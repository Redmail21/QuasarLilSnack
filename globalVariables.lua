--Main Window dimensions
screen_width = love.graphics.getWidth()
screen_height = love.graphics.getHeight()


--debugging
propsx = love.math.random( (screen_width * -1), (screen_width  + (screen_width * 0.5)))
propsy = love.math.random( (screen_height *-1), (screen_height  + (screen_height * 0.5)))

--fundamental variables
monsters = {}
monsterCount = 0
spawntime = 0.5
gameTime = 0
--button variables
buttons = {}
CButtons = {}
buttonCount = 0
CButtonSpawnTime = 1
ButtonSpawnTime = 1.5


--portal variables
portalIsOpen = false
portalOpenTime = 0
timeForcedDecrease = 1

--gui Elements
guiElements = {}

--score
globalScore = 0
highScore = 0

--powerupsAndSuch
powerUps = {}
--score multiplier
multiplier = 1
multiplierTimer = 0

--trashPortal
thrashBin = false
thrashBinLifeTime = 0
thrashBinSize = 50
thrashBinX = screen_width/2
thrashBinY = screen_height*0.80
