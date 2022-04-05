local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/buildDisel.lua')
end

local radiator, redstone, light, heavy, steel, scaffolding, sheet

local function build()
    turtle.up()
    turtle.select(steel)
    turtle.placeDown()
    turtle.up()
    turtle.forward()
    turtle.forward()
    turtle.placeDown()
    turtle.back()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.back()
    turtle.placeDown()
    turtle.back()
    turtle.placeDown()
    turtle.back()
    turtle.select(steel)
    turtle.placeDown()
    

    turtle.up()
    turtle.back()
    turtle.back()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.select(radiator)
    turtle.placeDown()
    turtle.select(sheet)
    turtle.placeUp()
    turtle.back()
    turtle.select(redstone)
    turtle.place()

    turtle.select(sheet)
    turtle.placeDown()
    turtle.select(radiator)
    turtle.placeUp()
    turtle.back()
    turtle.placeUp()
    turtle.select(sheet)
    turtle.place()
    turtle.placeDown()

    turtle.back()
    turtle.place()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(light)
    turtle.placeUp()

    turtle.back()
    turtle.place()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(light)
    turtle.placeUp()

    turtle.back()
    turtle.place()
    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(light)
    turtle.placeUp()
    turtle.back()
    turtle.place()


    turtle.back()
    turtle.turnRight()
    turtle.back()
    turtle.turnRight()
    turtle.back()
    turtle.select(steel)
    turtle.place()

    turtle.select(scaffolding)
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
    turtle.back()
    turtle.select(steel)
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.back()
    turtle.select(steel)
    turtle.place()

    turtle.select(sheet)
    turtle.placeDown()
    turtle.placeUp()
    turtle.turnLeft()
    turtle.back()
    turtle.select(heavy)
    turtle.place()
    turtle.turnLeft()


    turtle.select(sheet)
    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.select(light)
    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.select(sheet)
    turtle.placeDown()
    turtle.placeUp()
    turtle.back()
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(sheet)
    turtle.placeUp()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(sheet)
    turtle.placeUp()
    turtle.back()
    turtle.select(heavy)
    turtle.place()

    turtle.select(scaffolding)
    turtle.placeDown()
    turtle.select(sheet)
    turtle.placeUp()
    turtle.back()
    turtle.select(heavy)
    turtle.place()


    turtle.up()
    turtle.up()
    turtle.turnLeft()
    turtle.back()
    turtle.turnLeft()
    turtle.back()

    turtle.select(steel)
    turtle.place()
    turtle.back()
    turtle.placeUp()
    turtle.select(scaffolding)
    turtle.place()
    turtle.back()
    turtle.place()
    turtle.back()
    turtle.place()
    turtle.back()
    turtle.select(steel)
    turtle.place()

    turtle.back()
    turtle.back()
    turtle.down()
    turtle.down()
    turtle.down()
end

for i = 1, 16  do
     local item = turtle.getItemDetail(i)
    if item == nil then
    elseif item.name == 'immersiveengineering:radiator' then
        if item.count >= 3 then
            radiator = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:steel_scaffolding_standard' then
        if item.count >= 26 then
            scaffolding = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:heavy_engineering' then
        if item.count >= 4 then
            heavy = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:light_engineering' then
        if item.count >= 9 then
            light = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:sheetmetal_steel' then
        if item.count >= 16 then
            sheet = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:rs_engineering' then
        if item.count >= 1 then
            redstone = i
        else
            print('not enough ' .. item.name)
        end
    elseif item.name == 'immersiveengineering:storage_steel' then
        if item.count >= 9 then
            steel = i
        else
            print('not enough ' .. item.name)
        end
    end
end

if not (radiator == nil or redstone == nil or scaffolding == nil or
    heavy ==  nil or sheet == nil or steel == nil or light == nil) then
    build()
end