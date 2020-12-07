local modem = peripheral.wrap('top')
local git = 'https://raw.githubusercontent.com/Kollock5/cc/main/'

local function checkGitForUpdate()
    shell.run('rm data/updateServer/files')
    shell.run('wget '.. git ..'files.txt data/updateServer/files')
    local file = fs.open('data/updateServer/files', 'r')
    local nextFile = file.readLine()
    while not (nextFile == nil) do
        shell.run('rm ' .. nextFile)
        shell.run('wget '.. git .. nextFile .. ' ' .. nextFile)
        nextFile = file.readLine()
    end
end

local function checkVersion(message)
    print('Updating ' .. message.file)
    if fs.exists(message.file) then
        local file = fs.open(message.file, 'r')
        sVersion = (string.sub(file.readLine(), 17)) + 0
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

checkGitForUpdate()

while true do
    local event, mSide, sCh, rCh, message, sD = os.pullEvent()
    if event == 'modem_message' then
        if checkVersion(message) then
            sendUpdate(message, modem, rCh)
        else
            local msg = {update = false}
            modem.transmit(rCh, 0, msg)
        end
    end
    if event == 'key' and mSide == 85 then
        print('Update triggert')
        checkGitForUpdate()
        term.clear()
        term.setCursorPos(1,1)
    end
end