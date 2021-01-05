local slot = 1
 
args = { ... }
 
length = (args[1] + 1)
 
function getStuff()
    turtle.select(1)
    turtle.placeDown()
    turtle.select(2)
    turtle.suckDown(63)
    turtle.select(1)
    turtle.digDown()
    turtle.select(2)
end
turtle.select(2)
 
function mineBlock()
    while turtle.detect() do
        if turtle.dig() == false then
            return false
        end
    end
    return true
end
 
function mineBlockUp()
    while turtle.detectUp() do
        if turtle.digUp() == false then
            return false
        end
    end
    return true
end

local modem = peripheral.find('modem')
modem.open(666)

while true do
    mineBlock()
    turtle.forward()
    mineBlockUp()
    turtle.digDown()
    local item = turtle.getItemCount()
    if item < 2 then
        getStuff()
    end
    turtle.placeDown()

    modem.transmit(665, 666, 'test')
    while true do
        local event, mSide, sCh, rCh, message, sD = os.pullEvent()
        if event == 'modem_message' then
            if message == 'stop' then
                --TODO implement Stop
            end
            break
        end
    end
end





