-- title:  Procedural DFS
-- author: David Mekersa
-- script: lua

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local grid = {}

local cs = 8
local nbcol
local nblig
local explored = 0

-- Options
local seed = 1
local bLines = false

function GetDirections(pLig,pCol)
    local freeDirs = {}
    if pLig > 2 then
        if grid[pLig-2][pCol] == "wall" then
            table.insert(freeDirs, "up")
        end
    end
    if pCol < nbcol - 2 then
        if grid[pLig][pCol+2] == "wall" then
            table.insert(freeDirs, "right")
        end
    end
    if pLig < nblig - 2 then
        if grid[pLig+2][pCol] == "wall" then
            table.insert(freeDirs, "down")
        end
    end
    if pCol > 2 then
        if grid[pLig][pCol-2] == "wall" then
            table.insert(freeDirs, "left")
        end
    end
    return freeDirs
end

function DigWall(pLig,pCol)
  grid[pLig][pCol] = "floor"
end

function Explore(pLig,pCol)
    DigWall(pLig,pCol)
    explored = explored + 1
    while explored < (nblig*nbcol)/2  do
        local Dirs = GetDirections(pLig,pCol)
        if #Dirs ~= 0 then
            local r = love.math.random(1,#Dirs)
            local d = Dirs[r]
            if d == "up" then
                DigWall(pLig-1,pCol)
                Explore(pLig-2, pCol)
            elseif d == "right" then
                DigWall(pLig,pCol+1)
                Explore(pLig, pCol+2)
            elseif d == "down" then
                DigWall(pLig+1,pCol)
                Explore(pLig+2, pCol)           
            elseif d == "left" then
                DigWall(pLig,pCol-1)
                Explore(pLig, pCol-2)
            end
        else
            break
        end
    end
end

function Init()
  -- Fix the seed for demo purpose
  love.math.setRandomSeed(seed)
  
  -- Initialize globals
  explored = 0
  
  -- Create/Reset all the tables
  grid = {}
  
  -- Fit to screen size
  nbcol = math.floor(love.graphics.getWidth()/cs)
  if nbcol%2 == 0 then nbcol = nbcol-1 end
  nblig = math.floor(love.graphics.getHeight()/cs)
  if nblig%2 == 0 then nblig = nblig-1 end
  
  -- Fill with walls
  for l=1,nblig do
      grid[l] = {}
      for c=1,nbcol do
          grid[l][c] = "wall"
      end
  end
  
  -- Explore from the uppr-left corner
  Explore(2,2)

end

function love.load()
  love.window.setTitle("Gamecodeur DFS")
  --love.window.setFullscreen(bFullScreen)
  
  Init()
end

function love.update(dt)
end

function love.draw()
    for l=1,nblig do
        for c=1,nbcol do
      local cell = grid[l][c]
            if cell ~= "wall" then
        love.graphics.setColor(150/255,150/255,150/255)
        love.graphics.rectangle("fill",cs*(c-1),cs*(l-1),cs,cs)
            end
      if bLines then
        love.graphics.setColor(50/255,50/255,50/255)
        love.graphics.line(cs*(c-1), cs*(l-1), cs*(c-1), cs*nblig)
      end
        end -- end of c
    if bLines then
      love.graphics.setColor(50/255,50/255,50/255)
      love.graphics.line(0, cs*(l-1), cs*nbcol, cs*(l-1))
    end
    end -- end of l
end

function love.keypressed(k)
  if k == "escape" then
    love.event.quit()
  end
end
