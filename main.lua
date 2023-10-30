require("vector")
require("particle")
require("particleSystem")
require("repeller")
require("rectangle")

function love.load()

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.getFont()

    killCounter = 0

    MAX_OBJECTS = 100
    objects = {}
    isAlive = 0
    time = 0

    insider = nil
    keyInsider = nil

    particleSystem = ParticleSystem:create(Particle)
    repeller = Repeller:create(width /2 + 100, height /2 + 150)
end

function love.update(dt)

    if isAlive < MAX_OBJECTS then
        objects[isAlive] = Rectangle:create(Vector:create(math.random(0, width), math.random(0, height)), Vector:create(math.random(8, 30), math.random(8, 30)))
        isAlive = isAlive + 1
    end

    time = time + dt

    particleSystem:update()
    particleSystem:applyRepeller(repeller)
    x, y = love.mouse.getPosition()
    local isFind = false
    for k, v in pairs(objects) do

        if v:isInside(x, y) then
            insider = v
            keyInsider = k
            isFind = true
            break
        end
    end
    if isFind == false then
        insider = nil
    end
end

function love.draw()

    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(math.abs(math.cos(time * 10 / 90)), math.abs(1 - math.tan(time * 10 / 90)), math.abs(math.tan(time * 10 / 90)), 1)

    for k, v in pairs(objects) do

        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end

    love.graphics.setColor(r, g, b, a)

    if insider ~= nil then 
        
        love.graphics.setColor(math.abs(math.cos(time * 10 / 90)), math.abs(1 - math.tan(time * 10 / 90)), math.abs(math.tan(time * 10 / 90)), 1)
        love.graphics.rectangle("fill", insider.x, insider.y, insider.width, insider.height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", insider.x, insider.y, insider.width, insider.height)
        love.graphics.setColor(r, g, b, a)
    end
   
    particleSystem:draw()

    local text = "You kill " .. killCounter .. " objects"
    local textWidth = font:getWidth(text)
    love.graphics.print(text, width /2 - textWidth /2, 25)

    if killCounter > 5 then
        local text2 = "No bad, Alexander Viktorovich!"
        local textWidth = font:getWidth(text2)
        love.graphics.print(text2, width /2 - textWidth /2, 50)
    end

end

function love.mousepressed(x, y, button, istouch, presses)
    if insider ~= nil then
        particleSystem:addParticle(insider.x, insider.y, insider.x + insider.width, insider.y)
        particleSystem:addParticle(insider.x + insider.width, insider.y, insider.x + insider.width, insider.y + insider.height)
        particleSystem:addParticle(insider.x + insider.width, insider.y + insider.height, insider.x, insider.y + insider.height)
        particleSystem:addParticle(insider.x, insider.y + insider.height, insider.x, insider.y)
       objects[keyInsider] = Rectangle:create(Vector:create(math.random(0, width), math.random(0, height)), Vector:create(math.random(8, 30), math.random(8, 30)))
       killCounter = killCounter + 1
    end
end