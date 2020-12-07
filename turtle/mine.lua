local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/mine.lua')
end

os.loadAPI('api/gpsMove.lua')
local args = {...}
local tL = 8
gpsMove.reset()

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
    gpsMove.toX(0, 'd')
    gpsMove.toY(0, 'd')
    gpsMove.toZ(0, 'd')
    gpsMove.faceDirection(0)
end

function excavate()
    local turn = false
    while gpsMove.getZ()  > 1 do
        for j = 1, tL do
            for k = 1, tL - 1 do
                if not (turtle.getItemDetail(16) == nil) then
                    clearInventory()
                end
                if mineBlock() == false then
                    return true
                end
                gpsMove.forward()
            end
            if not (j == tL) then
                if turn then
                    gpsMove.turnLeft()
                    if mineBlock() == false then
                        return true
                    end
                    gpsMove.forward()
                    gpsMove.turnLeft()
                else
                    gpsMove.turnRight()
                    if mineBlock() == false then
                        return true
                    end
                    gpsMove.forward()
                    gpsMove.turnRight()
                end
            else
                while turtle.detectDown() do
                    if turtle.digDown() == false then
                        return false
                    end
                end
                gpsMove.down()
                if turn then
                    gpsMove.turnRight()
                else
                    gpsMove.turnLeft()
                end
            end
            turn = not turn
        end

    end
end

tL = (args[1] + 0)
gpsMove.reset()
excavate()
moveHome()
