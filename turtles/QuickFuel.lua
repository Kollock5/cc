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
