local stoargeChests = {}
local itemsChest = nil
local equipmentChest = nil

local garbageChests = {}

local function init()
    local peripheralNames = peripheral.getNames()

    for i, name in pairs(peripheralNames) do
        if peripheral.getType(name) == "minecraft:chest" then
            table.insert(stoargeChests, peripheral.wrap(name))
        elseif peripheral.getType(name) == "minecraft:barrel" then
            table.insert(garbageChests, peripheral.wrap(name))
        elseif peripheral.getType(name) == "ironchest:diamond_chest" then
            itemsChest = peripheral.wrap(name)
        elseif peripheral.getType(name) == "ironchest:obsidian_chest" then
            equipmentChest = peripheral.wrap(name)
        end
    end
end

local function fillTargetItems(chest, storageItem, storageSlot, target)
    local targetItems = target.list()
    local foundItem = false
    if targetItems ~= nil then
        for targetSlot, targetItem in pairs(targetItems) do
            if storageItem.name == targetItem.name then
                chest.pushItems(peripheral.getName(target), storageSlot, 64, targetSlot)    
                foundItem = true
                break
            end
        end
    end
    if foundItem == false then
        chest.pushItems(peripheral.getName(target), storageSlot)
    end
end

local function getItems() 
    for i, chest in pairs(stoargeChests) do
        local items = chest.list()
        if items ~= nil then
            for storageSlot, storageItem in pairs(items) do
                if chest.getItemDetail(storageSlot).maxCount > 1 then
                    fillTargetItems(chest, storageItem, storageSlot, itemsChest)                    
                else
                    fillTargetItems(chest, storageItem, storageSlot, equipmentChest)
                end

            end
        end
    end
end

local function cleanGarbage()
    for i, chest in pairs(garbageChests) do
        local items = chest.list()
        if items ~= nil then
            for slot, item in pairs(items) do
                for i, storage in pairs(stoargeChests) do
                    t = chest.pushItems(peripheral.getName(storage), slot)
                    print("hello" .. t)
                    if t ~= 0 then
                        break
                    end
                end
            end
        end
    end
end

local function main()
    while true do
        getItems()
        cleanGarbage()
    end
end

init()
main()