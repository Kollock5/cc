local version = 1
if fs.exists('api/update.lua') then
    os.loadAPI('api/update.lua')
    update.checkForUpdate(version, 'turtle/move.lua')
end

os.loadAPI('api/gpsMove.lua')
local sleeptimer = 100
local args = {...}
local tX
local tY
local tZ
local tD
local tL



function moveToTarge()
    gpsMove.toCordZ(128, 'd')
    gpsMove.toCordX(tX, 'd')
    gpsMove.toCordY(tY, 'd')
    gpsMove.toCordZ(tZ, 'd')
    gpsMove.toCordD(tD)
end

function moveHome()
    gpsMove.toCordZ(128, 'd')
    gpsMove.toX(0, 'd')
    gpsMove.toY(0, 'd')
    gpsMove.toZ(0, 'd')
    gpsMove.faceDirection(0)
end

    tX = (args[1] + 0)
    tY = (args[2] + 0)
    tZ = (args[3] + 0)
    tD = (args[4] + 0)

print("the Turtle will move the following distance:")
print('x: ' .. math.abs(tX - gpsMove.getX()))
print('y: ' .. math.abs(tY - gpsMove.getY()))
print('z: ' .. math.abs(tZ - gpsMove.getZ()))
sleep(10)

gpsMove.reset()
moveToTarge()
    while i < sleeptimer do
        term.clear()
        print('Time until return: ' .. i .. '/' .. sleeptimer)
        i = i + 1
        sleep(1)
end
moveHome()