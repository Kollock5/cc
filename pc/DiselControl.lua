local version = 1
-- wget https://raw.githubusercontent.com/Kollock5/cc/main/pc/DiselControl.lua startup.lua

if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'pc/DiselControl.lua')
end

local m = peripheral.wrap('left')
local power = false
local r = 0
 
local function display()
    m.clear()
    m.setCursorPos(1,1)
    m.write('Charge')
    m.setCursorPos(1,2)
    m.write(math.floor((r/15)*100) .. '%')
    m.setCursorPos(1,4)
    m.write('Engine')
 
    m.setCursorPos(1,5)
    if power then
        m.setTextColor(32)
        m.write('On')
    else
        m.setTextColor(16384)
        m.write('Off')
    end
    m.setTextColor(1)
end
while true do
    r = rs.getAnalogInput('back')
    if r <= 5 and not power then
        power = true
        redstone.setOutput('right', power)
    elseif r >= 14 then
        power = false
        redstone.setOutput('right', power)
    end
    display()
    sleep(1)
end