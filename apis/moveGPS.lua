local facingDirection = 0
local x, z, y = gps.locate(5)

local homeX = 0
local homeY = 0
local homeZ = 0
local homeFd = 0

debug = true

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
    doDebug()
end

function checkFD()
    updatePos()
    oldX = x
    oldY = y
    turtle.dig()
    if turtle.forward() then
        updatePos()
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

    if not fs.exists('data/gps/home') then
        setHome()
    end
    file = fs.open('data/gps/home', 'r')
    homeFd = file.readLine() + 0
    homeX = file.readLine() + 0
    homeY = file.readLine() + 0
    homeZ = file.readLine() + 0
    file.close()
end

function setHome()
    file = fs.open('data/gps/home', 'w')
    file.writeLine(facingDirection)
    file.writeLine(x)
    file.writeLine(y)
    file.writeLine(z)
    file.close()
    if debug then
        doDebug()
    end
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
    local targetD = d + homeFd
    if targetD >= 4 then
        targetD = targetD - 4
    end
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
    while not (targetZ == (z - homeZ)) do
        if targetZ > (z - homeZ) then
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
    if not (targetX == (x - homeX)) then
        if targetX > (x - homeX) then
            faceDirection(3)
        else
            faceDirection(1)
        end
        while not (targetX == (x - homeX)) do
            if forward() == false then
                return false
            end
            updatePos()
        end
    end
    return true
end

function toY(targetY)
    updatePos()
    if not (targetY == (y - homeY)) then
        if targetY > (y - homeY) then
            faceDirection(2)
        else
            faceDirection(0)
        end
        while not (targetY == (y - homeY)) do
            if forward() == false then
                return false
            end
            updatePos()
        end
    end
    return true
end

function doDebug()
    if debug then
        print('d: ' .. facingDirection .. ', x: ' .. x .. ', y: ' .. y .. ', z: ' .. z)
        local targetD = faceDirection - homeFd
        if targetD <= 0 then
            targetD = targetD + 4
        end
        print('Local d: ' .. targetD .. ', x: ' .. (x - homeX) .. ', y: ' .. (y - homeY) .. ', z: ' .. (z - homeZ))

    end
end