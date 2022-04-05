local trees = 20

local function farmTree()
    local movement = 0
    if turtle.dig() then
        turtle.forward()
        turtle.digDown()
        while turtle.digUp() do
            movement = movement + 1
            while not turtle.up() do
                turtle.digUp()
            end
        end
        for i = 1, movement, 1 do
            while not turtle.down() do
                turtle.digDown()
            end
        end
    else
        turtle.forward()
    end
    turtle.suckDown()
    turtle.select(1)
    turtle.placeDown()
end

local function suckItUp()
    turtle.forward()
    turtle.suckDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    for i = 1, trees, 1 do
        turtle.forward()
        turtle.suckDown()
    end
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    for i = 1, trees, 1 do
        turtle.forward()
        turtle.suckDown()
    end
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    for i = 1, trees, 1 do
        turtle.forward()
        turtle.suckDown()
    end
    turtle.forward()
    turtle.suckDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnLeft()
    for i = 1, trees, 1 do
        turtle.forward()
        turtle.suckDown()
    end
    turtle.forward()
    turtle.suckDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.suckDown()
    turtle.turnRight()
    turtle.forward()
    turtle.suckDown()
    turtle.forward()
    turtle.suckDown()
    turtle.turnLeft()
    turtle.turnLeft()

end

local function unload()
    for i = 2,  16, 1 do
        turtle.select(i)
        turtle.dropDown()
    end
    turtle.select(1)
end

local function autoRefuel()
    local currentSlot = turtle.getSelectedSlot()
    local chest = peripheral.wrap('bottom')
    for slot, item in pairs(chest.list()) do
        if item.name == 'minecraft:charcoal' then
            if slot == 1 then
                turtle.select(15)
                turtle.suckDown()
            else
                turtle.select(16)
                turtle.suckDown()
                chest.pushItems(peripheral.getName(chest), slot)
                turtle.select(15)
                turtle.suckDown()
                turtle.select(16)
                turtle.dropDown()
                turtle.select(15)
            end
            turtle.refuel()
            turtle.dropDown()
            turtle.select(currentSlot)
            break
        end
    end
end

local function main()
    while true do
        turtle.forward()
        turtle.forward()
        for i = 1, trees, 1 do
            farmTree()
        end
        turtle.turnLeft()
        turtle.turnLeft()
        for i = 1, trees - 1, 1 do
            farmTree()
        end
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
        turtle.turnLeft()
        sleep(180)
        suckItUp()
        unload()
        autoRefuel()
    end
end

main()