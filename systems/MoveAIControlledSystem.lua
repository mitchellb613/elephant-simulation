local Concord = require("concord")

local MoveAIControlledSystem = Concord.system({ pool = { "aiControlled", "position", "speed", "size" } })

function MoveAIControlledSystem:update(dt)
    for _, e in ipairs(self.pool) do
        --if ai doesn't have a direction give it one
        if (e.direction == nil) then
            e:give("direction", math.random(0, 1) * 2 - 1, math.random(0, 1) * 2 - 1)
        end

        --calculate direction vectors magnitude for normalization
        local magnitude = math.sqrt(e.direction.x * e.direction.x + e.direction.y * e.direction.y)

        --update entities position if it is moving
        if (magnitude > 0) then
            e.position.x = math.max(math.min(e.position.x + e.direction.x / magnitude * e.speed.x * dt, MAX_X - e.size.w)
                , 0)
            e.position.y = math.max(math.min(e.position.y + e.direction.y / magnitude * e.speed.y * dt, MAX_Y - e.size.h)
                , 0)
        end

        --when ai hits an edge change it's direction
        if (e.position.x == MAX_X - e.size.w or e.position.x == 0) then
            e.direction.x = e.direction.x * -1
        end
        if (e.position.y == MAX_Y - e.size.h or e.position.y == 0) then
            e.direction.y = e.direction.y * -1
        end
    end
end

return MoveAIControlledSystem
