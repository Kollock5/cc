os.loadAPI('api/move')

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
    move.toCordZ(128, 'd')
    move.toCordX(tX, 'd')
    move.toCordY(tY, 'd')
    move.toCordZ(tZ, 'd')
    move.toCordD(tD)
end

function moveHome()
    move.toCordZ(128, 'd')
    move.toX(0, 'd')
    move.toY(0, 'd')
    move.toZ(0, 'd')
    move.faceDirection(0)
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

    tX = (args[1] + 0)
    tY = (args[2] + 0)
    tZ = (args[3] + 0)
    tD = (args[4] + 0)
    tL = (args[5] + 0)

print("the Turtle will move the following distance:")
print('x: ' .. math.abs(tX - move.getX()))
print('y: ' .. math.abs(tY - move.getY()))
print('z: ' .. math.abs(tZ - move.getZ()))
sleep(10)

moveToTarge()
excavate()
moveHome()