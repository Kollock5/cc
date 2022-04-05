local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/treefarm.lua')
end

os.loadAPI('api/gpsMove.lua')

local row = 5
local column = 5
local sleeptimer = 100

local function cutTree()
    turtle.dig()
    gpsMove.forward()
    turtle.digDown()
    while turtle.detectUp() do
        turtle.digUp()
        gpsMove.up()
    end
    gpsMove.toZ(1)
    turtle.placeDown()
end

local function unload()
    local i = 3
    while i <= 16 do
        turtle.select(i)
        turtle.drop()
        i = i + 1
    end
end

local function returnHome()
    while not gpsMove.toZ(20) do
        turtle.digUp()
    end
    gpsMove.toX(0)
    gpsMove.toY(0)
    gpsMove.toZ(0)
end

local function readyUp()
    gpsMove.faceDirection(2)
    unload()
    gpsMove.turnLeft()
    turtle.select(1)
    turtle.suck()
    turtle.select(3)
    turtle.drop()
    gpsMove.turnLeft()
    gpsMove.turnLeft()
    turtle.select(2)
    turtle.suck()
    if turtle.getFuelLevel() < 10000 then
        local amount = turtle.getItemCount() - 1
        turtle.refuel(amount)
    end
    turtle.select(3)
    turtle.drop()
    gpsMove.turnRight()
end

local function farmTrees()
    turtle.select(1)
    gpsMove.up()
    turtle.dig()
    gpsMove.forward()

    local i = 0
    while i < row do
        i = i + 1
        local j = 0
        while j < column do
            j = j + 1
            turtle.dig()
            gpsMove.forward()
            turtle.dig()
            gpsMove.forward()
            if turtle.detect() then
                cutTree()
            else 
                gpsMove.forward()
                turtle.placeDown()
            end
        end
        turtle.dig()
        gpsMove.forward()
        turtle.dig()
        gpsMove.forward()
        turtle.dig()
        gpsMove.forward()

        if i % 2 == 0 then
            gpsMove.turnLeft()
            turtle.dig()
            gpsMove.forward()
            turtle.dig()
            gpsMove.forward()
            turtle.dig()
            gpsMove.forward()
            gpsMove.turnLeft()
        else
            gpsMove.turnRight()
            turtle.dig()
            gpsMove.forward()
            turtle.dig()
            gpsMove.forward()
            turtle.dig()
            gpsMove.forward()
            gpsMove.turnRight()
        end
    end
end

local function startUp()
    if not (gpsMove.getX() == 0 and gpsMove.getY() == 0 and gpsMove.getZ() == 0 and gpsMove.getFd() == 0) then
        returnHome()
    end
    readyUp()
end

local function main()
    startUp()
    while true do
        farmTrees()
        returnHome()
        readyUp()
        local i = 0
        while i < sleeptimer do
            term.clear()
            print('Wait time remaining: ' .. i .. '/' .. sleeptimer)
            i = i + 1
            sleep(1)
        end
    end

end


main()