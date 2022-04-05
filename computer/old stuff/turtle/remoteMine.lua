local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/remoteMine.lua')
end

os.loadAPI('api/gpsMove.lua')

local args = {...}
local tX
local tY
local tZ
local tD
local tL

function setTarget()
    local file = fs.open('data/rMine/target', 'w')
    file.writeLine(tX)
    file.writeLine(tY)
    file.writeLine(tZ)
    file.writeLine(tD)
    file.writeLine(tL)
    file.close()
    if debug then
        print('target set')
    end
end

function loadTarget()
    local file = fs.open('data/rMine/target', 'r')
    tX = file.readLine() + 0
    tY = file.readLine() + 0
    tZ = file.readLine() + 0
    tD = file.readLine() + 0
    tL = file.readLine() + 0
    file.close()
end



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

function moveToTarge()
    gpsMove.toCordZ(128, 'd')
    gpsMove.toCordX(tX, 'd')
    gpsMove.toCordY(tY, 'd')
    gpsMove.toCordZ(tZ, 'd')
    gpsMove.toCordD(tD)
end

function moveHome()
    gpsMove.toCordZ(128, 'd')
    gpsMove.toX(0, 'd')
    gpsMove.toY(0, 'd')
    gpsMove.toZ(0, 'd')
    gpsMove.faceDirection(0)
end

function mineBlock()
    while turtle.detect() do
        if turtle.dig() == false then
            return false
        end
    end
    return true
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

    tX = (args[1] + 0)
    tY = (args[2] + 0)
    tZ = (args[3] + 0)
    tD = (args[4] + 0)
    tL = (args[5] + 0)

print("the Turtle will move the following distance:")
print('x: ' .. math.abs(tX - gpsMove.getX()))
print('y: ' .. math.abs(tY - gpsMove.getY()))
print('z: ' .. math.abs(tZ - gpsMove.getZ()))
sleep(10)

moveToTarge()
excavate()
moveHome()