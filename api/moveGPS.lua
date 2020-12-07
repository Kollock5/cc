local version = 1

local fd = 0
local x, z, y = gps.locate(5)

local homeX = 0
local homeY = 0
local homeZ = 0
local homeFd = 0

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
    return fd
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
            fd = 3
        end
        if oldY == (y + 1) then
            fd = 0
        end
        if oldX == (x - 1) then
            fd = 1
        end
        if oldY == (y - 1) then
            fd = 2
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
    local file = fs.open('data/gps/save', 'r')
    fd = file.readLine() + 0
    file.close()

    if not fs.exists('data/gps/home') then
        setHome()
    end
    local file = fs.open('data/gps/home', 'r')
    homeFd = file.readLine() + 0
    homeX = file.readLine() + 0
    homeY = file.readLine() + 0
    homeZ = file.readLine() + 0
    file.close()
end

function setHome()
    local file = fs.open('data/gps/home', 'w')
    file.writeLine(fd)
    file.writeLine(x)
    file.writeLine(y)
    file.writeLine(z)
    file.close()
    if debug then
        doDebug()
    end
end

function reset()
    updatePos()
    checkFD()
    local file = fs.open('data/gps/save', 'w')
    file.writeLine(fd)
    file.close()
    sleep(1)
    setHome()
end
 
local function save()
    local file = fs.open('data/gps/save', 'w')
    file.writeLine(fd)
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
    fd = fd - 1
    if fd < 0 then
        fd = 3
    end
    save()
    return fd
end
 
function turnRight()
    turtle.turnRight()
    fd = fd + 1
    if fd == 4 then
        fd = 0
    end
    save()
    return fd
end

function faceDirection(d)
    local targetD = d + homeFd
    if targetD >= 4 then
        targetD = targetD - 4
    end
    while not (fd == targetD) do
        if fd > targetD then
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
            faceDirection(1)
        else
            faceDirection(3)
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


function toCordD(d)
    while not (fd == d) do
        if fd > d then
            turnLeft()
        else
            turnRight()
        end
    end
end

function toCordZ(targetZ, mode)
    updatePos()
    while not (targetZ == z) do
        if targetZ > z  then
            if mode == 'd' then
                turtle.digUp()
            end
            if up() == false then
                return false
            end
        else
            if mode == 'd' then
                turtle.digDown()
            end
            if down() == false then
                return false
            end
        end
        updatePos()
    end
    return true
end

function toCordX(targetX, mode)
    updatePos()
    if not (targetX == x) then
        if targetX > x then
            faceDirection(1)
        else
            faceDirection(3)
        end
        while not (targetX == x) do
            if mode == 'd' then
                turtle.dig()
            end
            if forward() == false then
                return false
            end
            updatePos()
        end
    end
    return true
end

function toCordY(targetY, mode)
    updatePos()
    if not (targetY == y) then
        if targetY > y then
            faceDirection(2)
        else
            faceDirection(0)
        end
        while not (targetY == y) do
            if mode == 'd' then
                turtle.dig()
            end
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
        print('d: ' .. fd .. ', x: ' .. x .. ', y: ' .. y .. ', z: ' .. z)
        local targetD = fd - homeFd
        if targetD <= 0 then
            targetD = targetD + 4
        end
        print('Local d: ' .. targetD .. ', x: ' .. (x - homeX) .. ', y: ' .. (y - homeY) .. ', z: ' .. (z - homeZ))

    end
end

init()