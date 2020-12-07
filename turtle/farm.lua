local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/farm.lua')
end

os.loadAPI('api/gpsMove.lua')

local length = 8
local width = 8

local function farm()

end

function unload()
    
end

function returnHome()
    gpsMove.toX(0)
    gpsMove.toY(0)
end