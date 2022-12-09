local Concord = require("concord")

Concord.component("size", function(c, w, h)
    c.w = w or 0
    c.h = h or 0
end)
