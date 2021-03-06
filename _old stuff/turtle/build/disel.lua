local version = 4
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/buildDisel.lua')
end

local radiator, redstone, engine, heavy, pipe, scaffolding

local function build()
    turtle.up()
    turtle.forward()
    turtle.forward()
    turtle.forward()

    turtle.select(radiator)
    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.placeDown()
    turtle.placeUp()
    turtle.turnLeft()
    turtle.back()
    turtle.place()


    turtle.turnLeft()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.placeUp()
    turtle.select(pipe)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.turnRight()
    turtle.back()
    turtle.select(heavy)
    turtle.place()


    turtle.turnRight()
    turtle.placeUp()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.placeUp()
    turtle.select(pipe)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.placeUp()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.turnLeft()
    turtle.back()
    turtle.select(redstone)
    turtle.place()


    turtle.turnLeft()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.placeUp()
    turtle.select(pipe)
    turtle.placeDown()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.turnRight()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    
    turtle.turnRight()
    turtle.select(pipe)
    turtle.placeDown()
    turtle.select(engine)
    turtle.back()
    turtle.place()

    turtle.placeDown()
    turtle.back()
    turtle.place()

    turtle.select(pipe)
    turtle.placeDown()
    turtle.select(engine)
    turtle.back()
    turtle.place()
    turtle.down()
end

for i = 1, 16  do
     local item = turtle.getItemDetail(i)
    if item == nil then
    elseif item.name == 'immersiveengineering:radiator' then
        if item.count >= 9 then
            radiator = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:steel_scaffolding_standard' then
        if item.count >= 6 then
            scaffolding = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:heavy_engineering' then
        if item.count >= 13 then
            heavy = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:fluid_pipe' then
        if item.count >= 5 then
            pipe = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:rs_engineering' then
        if item.count >= 1 then
            redstone = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:generator' then
        if item.count >= 4 then
            engine = i
        else
            print('not enough ' .. item.name)
        end
    end
end

if not (radiator == nil or redstone == nil or scaffolding == nil or
    heavy ==  nil or pipe == nil or engine == nil) then
    build()
end