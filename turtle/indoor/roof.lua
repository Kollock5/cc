local args = {...}

if args[2] == nil then
    print('Error try: wall [length] [heigth]')
    return false
end

local targetWidth = (args[1] + 0)
local targetHeigth = (args[2] + 0)
local currentWidth = 0
local direction = 0

function getStuff()
    turtle.select(1)
    turtle.placeUp()
    turtle.select(2)
    turtle.suckUp(63)
    turtle.select(1)
    turtle.digUp()
    turtle.select(2)
end

turtle.select(3)
turtle.digUp()
turtle.select(2)
local item = turtle.getItemCount()
if item < 2 then
    getStuff()
end



while targetWidth > currentWidth do
    local currentHeigth = 1

    currentWidth = currentWidth + 1

    turtle.digUp()
    local item = turtle.getItemCount()
    if item < 2 then
        getStuff()
    end
    turtle.placeUp()
    while targetHeigth > currentHeigth do
        turtle.forward()
        currentHeigth = currentHeigth + 1

        turtle.digUp()
        local item = turtle.getItemCount()
        if item < 2 then
            getStuff()
        end
        turtle.placeUp()
    end

    if direction == 0 then
        direction = 1
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
    else
        direction = 0
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    end
end
