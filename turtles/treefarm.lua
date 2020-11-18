os.loadAPI('apis/move')

local row = 5
local column = 5

local function cutTree()
    turtle.dig()
    move.forward()
    turtle.digDown()
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
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
    move.turnLeft()
    move.turnLeft()
    turtle.select(2)
    turtle.suck()
    local amount = turtle.getItemCount() - 1
    turtle.refuel(amount)
    move.turnRight()
end

local function farmTrees()
    move.up()
    move.forward()
    move.forward()
    move.forward()

    local i = 0
    while i < row do
        i = i + 1
        local j = 0
        while j < column do
            j = j + 1
            move.forward()
            move.forward()
            if turtle.detect() then
                cutTree()
            else 
                move.forward()
                turtle.placeDown()
            end
        end
        move.forward()
        if i % 2 == 0 then
            move.turnLeft()
            move.forward()
            move.forward()
            move.forward()
            move.turnLeft()
        else
            move.turnRight()
            move.forward()
            move.forward()
            move.forward()
            move.turnRight()
        end
    end
end

local function startUp()
    if not (move.x == 0 and move.y == 0 and move.z == 0) then
        returnHome()
    end
    readyUp()
end

local function main()
    startUp()
    farmTrees()
end


main()