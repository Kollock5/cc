facingDirection = 0
x = 0
y = 0
z = 0

function init()
    if not fs.exists('saves/localPos/save') then
        reset()
    end
    file = fs.open('saves/localPos/save', 'r')
    facingDirection = file.readLine() + 0
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
    file.writeLine(facingDirection)
    file.writeLine(x)
    file.writeLine(y)
    file.writeLine(z)
    file.close()
    debug()
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
        if facingDirection + 0 == 0 then
            x = x + 1
            save()
            return x
        elseif facingDirection + 0 == 1 then
            y = y + 1
            save()
            return y
        elseif facingDirection + 0 == 2 then
            x = x - 1
            save()
            return x
        elseif facingDirection + 0 == 3 then
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
        if facingDirection + 0 == 0 then
            x = x - 1
            save()
            return x
        elseif facingDirection + 0 == 1 then
            y = y - 1
            save()
            return y
        elseif facingDirection + 0 == 2 then
            x = x + 1
            save()
            return x
        elseif facingDirection + 0 == 3 then
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

function debug()
    print('d: ' .. facingDirection .. ', x: ' .. x .. ', y: ' .. y .. ', z: ' .. z)
end