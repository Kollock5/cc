local args = {...}

if args[2] == nil then
    print('Error try: wall [length] [heigth]')
    return false
end

local targetWidth = (args[1] + 0)
local targetHeigth = (args[2] + 0)
local currentWidth = 0
local currentHeigth = 1

function mineBlock()
    while turtle.detect() do
        if turtle.dig() == false then
            return false
        end
    end
    return true
end

function getStuff()
    turtle.select(1)
    turtle.place()
    turtle.select(2)
    turtle.suck(63)
    turtle.select(1)
    turtle.dig()
    turtle.select(2)
end

turtle.select(3)
turtle.dig()
turtle.select(2)
local item = turtle.getItemCount()
if item < 2 then
    getStuff()
end

while targetWidth > currentWidth do
    currentWidth = currentWidth + 1

    turtle.dig()
    local item = turtle.getItemCount()
    if item < 2 then
        getStuff()
    end
    turtle.place()
    while targetHeigth > currentHeigth do
        turtle.up()
        currentHeigth = currentHeigth + 1

        turtle.dig()
        local item = turtle.getItemCount()
        if item < 2 then
            getStuff()
        end
        turtle.place()
    end
    while currentHeigth > 1 do
        currentHeigth = currentHeigth - 1
        turtle.down()
    end
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end
