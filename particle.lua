Particle = {}
Particle.__index = Particle

function Particle:create(x1, y1, x2, y2)
    local particle = {}
    setmetatable(particle, Particle)

    particle.locationStart = Vector:create(x1, y1)
    particle.locationEnd = Vector:create(x2, y2)
    
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) /100, math.random(-1, 0))
    particle.lifespan = 200 * math.random(1, 1.9)

    return particle
end

function Particle:applyForce(force)

    self.acceleration:add(force)
end

function Particle:update()

    self.velocity:add(self.acceleration)

    self.locationStart:add(self.velocity)
    self.locationEnd:add(self.velocity)

    self.lifespan = self.lifespan - 1
end

function Particle:isDead()

    return self.lifespan <= 0
end

function Particle:draw()

    r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(self.lifespan /100, self.lifespan /200, self.lifespan * math.atan(self.lifespan), 1)
    love.graphics.line(self.locationStart.x, self.locationStart.y, self.locationEnd.x, self.locationEnd.y)

    love.graphics.setColor(r, g, b, a)
end