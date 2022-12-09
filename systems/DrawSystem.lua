local Concord = require("concord")

local DrawSystem = Concord.system({ pool = { "position", "drawable" } })

function DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.drawable.sprite, e.position.x, e.position.y)
    end
end

return DrawSystem
