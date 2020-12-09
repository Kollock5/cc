local version = 3

if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'server/chatServer.lua')
end

local modem = peripheral.find('modem')

msgList = {}

local function loadData()
    if fs.exists('data/chatServer/msg') then
        local file = fs.open('data/chatServer/msg', 'r')
        local data = file.readAll()
        file.close()
        msgList = textutils.unserialize(data)
    end
end

local function saveData()
    local file = fs.open('data/chatServer/msg', 'w')
    file.write(textutils.serialize(msgList))
    file.close()
end

local function msgReceived(message)
    table.insert(msgList, 1, message)
    if #msgList > 26 then
        table.remove(msgList, 27)
    end
    saveData(message)
end


loadData()
modem.open(4546)
term.setTextColor(colors.purple)
term.clear()
term.setCursorPos(1,1)
print('ENDERCHAT-Server')
term.setTextColor(colors.white)

while true do
    local myTimer = os.startTimer(1)
    while true do
        local event, mSide, sCh, rCh, message, sD = os.pullEvent()
        if event == "timer" and mSide == myTimer then
            modem.transmit(4545, 0, msgList)
            break
        end
        if event == 'modem_message' then
            if not (message.user == nil) then
                term.setTextColor(message.userColor)
                term.write(message.user)
                term.setTextColor(colors.white)
                print(' send ' .. message.msg .. ' at ' ..  message.time)
                msgReceived(message)
            end
        end
        if event == 'key' and mSide == 85 then

        end
    end
end

test