local Concord = require("concord")

local MovePlayerControlledSystem = Concord.system({ pool = { "playerControlled", "position", "speed", "size" } })

function MovePlayerControlledSystem:update(dt)
    for _, e in ipairs(self.pool) do
        --playerControlled entities don't use a direction component it is calculated each frame from keyboard input
        local directionX = 0
        local directionY = 0
        if love.keyboard.isDown("w") then
            directionY = directionY - 1
        end
        if love.keyboard.isDown("a") then
            directionX = directionX - 1
        end
        if love.keyboard.isDown("s") then
            directionY = directionY + 1
        end
        if love.keyboard.isDown("d") then
            directionX = directionX + 1
        end

        --calculate direction vectors magnitude for normalization
        local magnitude = math.sqrt(directionX * directionX + directionY * directionY)

        --update entities position if it is moving
        if (magnitude > 0) then
            e.position.x = math.max(math.min(e.position.x + directionX / magnitude * e.speed.x * dt, MAX_X - e.size.w), 0)
            e.position.y = math.max(math.min(e.position.y + directionY / magnitude * e.speed.y * dt, MAX_Y - e.size.h), 0)
        end
    end
end

return MovePlayerControlledSystem
