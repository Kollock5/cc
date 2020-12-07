local version = 2
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'pocket/zollstock.lua')
end

local x1, y1, z1

function draw()
    local x, y, z = gps.locate(5)
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(32)
    print('Current position:')
    print('X: ' .. math.floor(x))
    print('Y: ' .. math.floor(z))
    print('Z: ' .. math.floor(y))
    print('Point 1 position:')
    print('X: ' .. math.floor(x1))
    print('Y: ' .. math.floor(z1))
    print('Z: ' .. math.floor(y1))
    print('Distance:')
    print('X: ' .. math.floor(x1) - math.floor(x))
    print('Y: ' .. math.floor(z1) - math.floor(z))
    print('Z: ' .. math.floor(y1) - math.floor(y))
    print('Press E to set Point 1')
end

draw()
while true do
    local myTimer = os.startTimer(1)
    while true do
        local event, par1 = os.pullEvent()
      
        if event == "timer" and par1 == myTimer then
            draw()
            break
        elseif event == "key" and par1 == keys.e then
            x1, y1, z1 = gps.locate()
            draw()
            break
        end
      end
end