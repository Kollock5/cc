os.loadAPI('api/move')
local args = {...}
local tL = 8
move.reset()

function clearInventory()
    turtle.digUp()
    turtle.select(1)
    turtle.placeUp()
    local i = 2
    while i <= 16 do
        turtle.select(i)
        turtle.dropUp()
        i = i + 1
    end
    turtle.select(1)
    turtle.digUp()
end

function mineBlock()
    while turtle.detect() do
        if turtle.dig() == false then
            return false
        end
    end
    return true
end

function moveHome()
    move.toX(0, 'd')
    move.toY(0, 'd')
    move.toZ(0, 'd')
    move.faceDirection(0)
end

function excavate()
    local turn = false
    while move.getZ()  > 1 do
        for j = 1, tL do
            for k = 1, tL - 1 do
                if not (turtle.getItemDetail(16) == nil) then
                    clearInventory()
                end
                if mineBlock() == false then
                    return true
                end
                move.forward()
            end
            if not (j == tL) then
                if turn then
                    move.turnLeft()
                    if mineBlock() == false then
                        return true
                    end
                    move.forward()
                    move.turnLeft()
                else
                    move.turnRight()
                    if mineBlock() == false then
                        return true
                    end
                    move.forward()
                    move.turnRight()
                end
            else
                while turtle.detectDown() do
                    if turtle.digDown() == false then
                        return false
                    end
                end
                move.down()
                if turn then
                    move.turnRight()
                else
                    move.turnLeft()
                end
            end
            turn = not turn
        end

    end
end

tL = (args[1] + 0)
move.reset()
excavate()
moveHome()
