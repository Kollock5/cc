local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/QuickFuel.lua')
end

while true do
    turtle.refuel(64)
    term.clear()
    term.setCursorPos(1, 1)
    print('Fuel Level: ' .. turtle.getFuelLevel() .. '/' .. turtle.getFuelLimit())
    print('Press E to exit')
    local event, key = os.pullEvent( "key" )
    if key == keys.e then
        print('Program stoped')
        break
    end
end
