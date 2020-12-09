local version = 4

if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'pc/chatClient.lua')
end

local m = peripheral.find('monitor')
local w, h = m.getSize()
local msgList = {}
local modem = peripheral.find('modem')
local blocked = false
local user = 'No User'
local userColor = colors.green

local function loadUser()
    local file = fs.open('data/chatClient/user', 'r')
    local data = file.readAll()
    file.close()
    local data = textutils.unserialize(data)
    user = data.user
    userColor = data.color
end

local function createUser()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.purple)
    print('ENDERCHAT')
    term.setTextColor(colors.white)
    print('Enter a User name:')
    local tw, th = term.getSize()
    term.setCursorPos(1, th)
    local newUser = read()
    local data = {user = newUser, color = 8192}
    local file = fs.open('data/chatClient/user', 'w')
    file.write(textutils.serialize(data))
    file.close()
    user = data.user
    userColor = data.color
end

function getTime()
    local hours = textutils.formatTime(os.time(), true)
    if #hours == 4 then
        hours = ' ' + hours
    end
    return ('day: ' .. os.day() .. ' time: ' .. hours)
end

function init()
    m.setTextScale(0.5)
    m.setBackgroundColor(colors.black)
    m.clear()
    m.setCursorPos(1,1)
    if fs.exists('data/chatClient/user') then
        loadUser()
    else
        createUser()
    end
    termDisplay()
end

function nextLine()
    local x, y = m.getCursorPos()
    m.setCursorPos(1, y+1)
end

function title()
    m.setBackgroundColor(colors.black)
    m.setTextColor(colors.purple)
    fill('-')
    nextLine()
    m.write(' ENDERCHAT ')
    m.setTextColor(colors.lightGray)
    writeRight(getTime())
    m.setTextColor(colors.purple)
    nextLine()
    fill('-')
    nextLine()
    m.setTextColor(colors.white)
end

function printMessageBoard(msgList)
local myColor = colors.black
for i = 1, #msgList do
    m.setBackgroundColor(myColor)
    message(msgList[i])
    if myColor == colors.black then
        myColor = colors.black
    else
        myColor = colors.black
    end
    nextLine()
    fill('-')

end
end

function message(msg)
    nextLine()
    m.setTextColor(msg.userColor)
    m.write(msg.user)
    m.setTextColor(colors.lightGray)
    writeRight(msg.time)
    fill()
    nextLine()
    m.setTextColor(colors.white)
    writeLine(msg.msg)
end

function writeLine(text)
    local x, y = m.getCursorPos()
    local first = string.sub(text, 1, w - x + 1)
    m.write(first)
    local next = string.sub(text, w - x + 1)
    if not (next == '') then
        nextLine()
        writeLine(next)
    else
        fill()
    end
end

function writeRight(text)
    local x, y = m.getCursorPos()
    m.setCursorPos(w - #text + 1, y)
    m.write(text)
end

function fill(myFiller)
    local filler = ' '
    if not (myFiller == nil) then
        filler = myFiller
    end
    local x, y = m.getCursorPos()
    for i = 1, (w - x + 1) do
        m.write(filler)
    end
end

function drawNewScreen()
    m.setBackgroundColor(colors.black)
    m.clear()
    m.setCursorPos(1,1)
    title()
    if blocked then
        nextLine()
        writeLine('Waiting for your new message! look at your computer')
    else
        printMessageBoard(msgList)
    end
end

function createNewMsg()
    blocked = true
    drawNewScreen()

    local tw, th = term.getSize()
    print('type now!')
    term.setCursorPos(1, th)
    local text = read()
    if not (text == nil) then
        local msg = {user = user, userColor = userColor, time = getTime() , msg = text}
        modem.transmit(4546, 0, msg)
    end
    blocked = false
    termDisplay()
end

function termDisplay()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.purple)
    print('ENDERCHAT')
    term.setTextColor(colors.white)
    term.write('Press ')
    term.setTextColor(colors.blue)
    term.write('Enter ')
    term.setTextColor(colors.white)
    print('to send new Message!')
end

init()
sleep(1)

modem.open(4545)
while true do
    local myTimer = os.startTimer(1)
    while true do
        local event, mSide, sCh, rCh, message, sD = os.pullEvent()
        if event == "timer" and mSide == myTimer then
            drawNewScreen()
            break
        end
        if event == 'modem_message' then
            msgList = message
            drawNewScreen()

        end
        if event == 'key' and mSide == keys.enter then
            createNewMsg()
        end
        if event == 'monitor_resize' then  
            w, h = m.getSize()
        end
    end
end

