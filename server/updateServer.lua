local modem = peripheral.wrap('top')

local function checkVersion(message)
    print(message.file)
    if fs.exists(message.file) then
        local file = fs.open(message.file, 'r')
        sVersion = (string.sub(file.readLine(), 11)) + 0
        file.close()
        if not (sVersion == (message.version + 0)) then
            return true
        end
    end
    return false
end 
 
local function sendUpdate(message, modem, rCh)
    local file = fs.open(message.file, 'r')
    local msg = {update = true, data = file.readAll()} 
    modem.transmit(rCh, 0, msg) 
end

modem.open(1213)

while true do
    local event, mSide, sCh, rCh, message, sD = os.pullEvent('modem_message')
    if checkVersion(message) then
        sendUpdate(message, modem, rCh)
    else
        local msg = {update = false}
        modem.transmit(rCh, 0, msg)
    end
end