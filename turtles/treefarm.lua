os.loadAPI('apis/move')

local row = 5
local column = 5
local sleeptimer = 100

local function cutTree()
    turtle.dig()
    move.forward()
    turtle.digDown()
    while turtle.detectUp() do
        turtle.digUp()
        move.up()
    end
    move.toZ(1)
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
    while not move.toZ(20) do
        turtle.digUp()
    end
    move.toX(0)
    move.toY(0)
    move.toZ(0)
end

local function readyUp()
    move.faceDirection(2)
    unload()
    move.turnLeft()
    turtle.select(1)
    turtle.suck()
    turtle.select(3)
    turtle.drop()
    move.turnLeft()
    move.turnLeft()
    turtle.select(2)
    turtle.suck()
    if turtle.getFuelLevel() < 10000 then
        local amount = turtle.getItemCount() - 1
        turtle.refuel(amount)
    end
    turtle.select(3)
    turtle.drop()
    move.turnRight()
end

local function farmTrees()
    turtle.select(1)
    move.up()
    turtle.dig()
    move.forward()

    local i = 0
    while i < row do
        i = i + 1
        local j = 0
        while j < column do
            j = j + 1
            turtle.dig()
            move.forward()
            turtle.dig()
            move.forward()
            if turtle.detect() then
                cutTree()
            else 
                move.forward()
                turtle.placeDown()
            end
        end
        turtle.dig()
        move.forward()
        turtle.dig()
        move.forward()
        turtle.dig()
        move.forward()

        if i % 2 == 0 then
            move.turnLeft()
            turtle.dig()
            move.forward()
            turtle.dig()
            move.forward()
            turtle.dig()
            move.forward()
            move.turnLeft()
        else
            move.turnRight()
            turtle.dig()
            move.forward()
            turtle.dig()
            move.forward()
            turtle.dig()
            move.forward()
            move.turnRight()
        end
    end
end

local function startUp()
    if not (move.getX() == 0 and move.getY() == 0 and move.getZ() == 0 and move.getFd() == 0) then
        returnHome()
    end
    readyUp()
end

local function main()
    move.init()
    startUp()
    while true do
        farmTrees()
        returnHome()
        readyUp()
        local i = 0
        while i < 100 do
            term.clear()
            print('Wait time remaining: ' .. i .. '/' .. sleeptimer)
            i = i + 1
            sleep(1)
        end
    end

end


main()