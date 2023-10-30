Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:create(vlocation, vsize)
    local rectangle = {}
    setmetatable(rectangle, Rectangle)

    rectangle.x = vlocation.x
    rectangle.y = vlocation.y

    rectangle.width = vsize.x
    rectangle.height = vsize.y

    return rectangle
end

function Rectangle:isInside(x, y)

    if x > self.x and y > self.y and x < (self.x + self.width) and y < (self.y + self.height) then
        return true
    end

    return false
end