ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(cls)
    local system = {}
    setmetatable(system, ParticleSystem)

    system.cls = cls or Particle

    system.index = 0

    system.particles = {}

    return system
end

function ParticleSystem:addParticle(x1, y1, x2, y2)

    self.particles[self.index] = self.cls:create(x1, y1, x2, y2)
    self.index = self.index + 1

end

function ParticleSystem:applyRepeller(repeller)

    for k, v in pairs(self.particles) do

        local force = repeller:repel(v)
        v:applyForce(force)
    end
end

function ParticleSystem:update()

    for k, v in pairs(self.particles) do

        self.particles[k]:update()
    end
end

function ParticleSystem:draw()

    for k, v in pairs(self.particles) do
        if not v:isDead() then
            v:draw()
        end
    end
end