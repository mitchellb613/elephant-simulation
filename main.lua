local Concord = require("concord")

--global variables for max screen size
MAX_X = 1600
MAX_Y = 900

--load all modules
local Assemblages = {}
local Systems = {}
Concord.utils.loadNamespace("components")
Concord.utils.loadNamespace("assemblages", Assemblages)
Concord.utils.loadNamespace("systems", Systems)

--initialize a concord world and add our systems to it
local world = Concord.world()
world:addSystems(Systems.DrawSystem, Systems.MovePlayerControlledSystem, Systems.MoveAIControlledSystem)

--add player at (0, 0) as an elephant
local player_1 = Concord.entity(world)
    :give("playerControlled")
    :give("position", 0, 0)
    :assemble(Assemblages.elephant)

--add 5 ai controlled elephants at random locations
for i = 1, 5, 1 do
    Concord.entity(world)
        :give("aiControlled")
        :give("position", math.random(0, MAX_X), math.random(0, MAX_Y))
        :assemble(Assemblages.elephant)
end

love.window.setMode(MAX_X, MAX_Y)

function love.update(dt)
    world:emit("update", dt)
end

function love.draw()
    world:emit("draw")
end
