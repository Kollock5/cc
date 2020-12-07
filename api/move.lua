local fd = 0
local x = 0
local y = 0
local z = 0
debug = false

function getX()
    return x
end

function getZ()
    return z
end

function getY()
    return y
end

function getFd()
    return fd
end

function init()
    if not fs.exists('saves/localPos/save') then
        reset()
    end
    file = fs.open('saves/localPos/save', 'r')
    fd = file.readLine() + 0
    x = file.readLine() + 0
    y = file.readLine() + 0
    z = file.readLine() + 0
    file.close()
end

function reset()
    file = fs.open('saves/localPos/save', 'w')
    file.writeLine('0')
    file.writeLine('0')
    file.writeLine('0')
    file.writeLine('0')
    file.close()
end
 
local function save()
    file = fs.open('saves/localPos/save', 'w')
    file.writeLine(fd)
    file.writeLine(x)
    file.writeLine(y)
    file.writeLine(z)
    file.close()
    if debug then
        doDebug()
    end
end
 
function up()
    if turtle.up() then
        z = z + 1
        save()
        return z
    else
        return false
    end
end
 
function down()
    if turtle.down() then
        z = z - 1
        save()
        return z
    else
        return false
    end
end
 
function forward()
    if turtle.forward() then
        if fd + 0 == 0 then
            x = x + 1
            save()
            return x
        elseif fd + 0 == 1 then
            y = y + 1
            save()
            return y
        elseif fd + 0 == 2 then
            x = x - 1
            save()
            return x
        elseif fd + 0 == 3 then
            y = y - 1
            save()
            return y
        end
    else
        return false
    end
end
 
function back()
    if turtle.back() then
        if fd + 0 == 0 then
            x = x - 1
            save()
            return x
        elseif fd + 0 == 1 then
            y = y - 1
            save()
            return y
        elseif fd + 0 == 2 then
            x = x + 1
            save()
            return x
        elseif fd + 0 == 3 then
            y = y + 1
            save()
            return y
        end
        save()
    else
        return false
    end
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
    while not (fd == d) do
        if fd > d then
            turnLeft()
        else
            turnRight()
        end
    end
end

function toZ(targetZ)

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
    end
    return true
end

function toX(targetX)
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
    end
    return true
end

function toY(targetY)
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
    return true
end

function doDebug()
    print('d: ' .. fd .. ', x: ' .. x .. ', y: ' .. y .. ', z: ' .. z)
end

init()