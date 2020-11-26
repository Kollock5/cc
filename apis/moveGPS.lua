local facingDirection = 0
local x, y, z = gps.locate(5)
debug = false

function getX()
    updatePos()
    return x
end

function getZ()
    updatePos()
    return z
end

function getY()
    updatePos()
    return y
end

function getFd()
    return facingDirection
end

function updatePos()
    local newX, newZ, newY = gps.locate(5)
    x = newX
    z = newZ
    y = newY
end

function checkFD()
    print(gps.locate(5))
    updatePos()
    oldX = x
    oldY = y
    turtle.dig()
    if turtle.forward() then
        print(gps.locate(5))
        updatePos()
        print(oldY)
        print(y)
        print(oldX == y + 1)

        if oldX == (x + 1) then 
            facingDirection = 3
        end
        if oldY == (y + 1) then
            facingDirection = 0
        end
        if oldX == (x - 1) then
            facingDirection = 1
        end
        if oldY == (y - 1) then
            facingDirection = 2
        end
        turtle.back()
    else
        return false
    end
end

function init()
    if not fs.exists('data/gps/save') then
        reset()
    end
    file = fs.open('data/gps/save', 'r')
    facingDirection = file.readLine() + 0
    file.close()
end

function reset()
    checkFD()
    file = fs.open('data/gps/save', 'w')
    file.writeLine(facingDirection)
    file.close()
end
 
local function save()
    file = fs.open('data/gps/save', 'w')
    file.writeLine(facingDirection)
    file.close()
    if debug then
        doDebug()
    end
end
 
function up()
    return turtle.up()
end
 
function down()
    return turtle.down()
end
 
function forward()
    return turtle.forward()
end
 
function back()
    return turtle.back()
end
 
function turnLeft()
    turtle.turnLeft()
    facingDirection = facingDirection - 1
    if facingDirection < 0 then
        facingDirection = 3
    end
    save()
    return facingDirection
end
 
function turnRight()
    turtle.turnRight()
    facingDirection = facingDirection + 1
    if facingDirection == 4 then
        facingDirection = 0
    end
    save()
    return facingDirection
end

function faceDirection(d)
    while not (facingDirection == d) do
        if facingDirection > d then
            turnLeft()
        else
            turnRight()
        end
    end
end

function toZ(targetZ)
    updatePos()
    while not (targetZ == z) do
        if targetZ > z then
            if up() == false then
                return false
            end
        else
            if down() == false then
                return false
            end
        end
        updatePos()
    end
    return true
end

function toX(targetX)
    updatePos()
    if not (targetX == x) then
        if targetX > x + 0 then
            faceDirection(0)
        else
            faceDirection(2)
        end
        while not (targetX == x) do
            if forward() == false then
                return false
            end
        end
        updatePos()
    end
    return true
end

function toY(targetY)
    updatePos()
    if not (targetY == y) then
        if targetY > y  + 0 then
            faceDirection(1)
        else
            faceDirection(3)
        end
        while not (targetY == y) do
            if forward() == false then
                return false
            end
        end
    end
    updatePos()
    return true
end

function doDebug()
    updatePos()
    print('d: ' .. facingDirection .. ', x: ' .. x .. ', y: ' .. y .. ', z: ' .. z)
end