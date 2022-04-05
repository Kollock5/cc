local coalChest = peripheral.wrap('left')
local itemChest = peripheral.wrap('top')
local outputChest = peripheral.wrap('bottom')
local furnace = peripheral.wrap('back')
local display = peripheral.wrap('left')

coalChest.pushItems(peripheral.getName(outputChest), 1)




