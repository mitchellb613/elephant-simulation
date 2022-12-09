local speedX = 128
local speedY = 128
local sprite = love.graphics.newImage("sprites/elephant.png")

--this function appends components to an entity 'e' to make it an elephant
return function(e)
    e
        :give("speed", speedX, speedY)
        :give("drawable", sprite)
        :give("size", sprite:getDimensions())
end
