local myVesin = 1

function checkForUpdate(version, path)
    data = {file = path, version = version}
    modem.transmit(1213, 1214, data)
    modem.open(1214)
    local event, mSide, sCh, rCh, message, sD = os.pullEvent('modem_message')
    print(message.data)
    if message.update then
        local file = fs.open(path, 'w')
        file.write(message.data)
        file.close()
        return true
    end
    return false
end

local modem = peripheral.find('modem')
checkForUpdate(myVesin, 'api/update.lua')