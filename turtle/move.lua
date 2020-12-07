os.loadAPI('api/move')
local sleeptimer = 100
local args = {...}
local tX
local tY
local tZ
local tD
local tL



function moveToTarge()
    move.toCordZ(128, 'd')
    move.toCordX(tX, 'd')
    move.toCordY(tY, 'd')
    move.toCordZ(tZ, 'd')
    move.toCordD(tD)
end

function moveHome()
    move.toCordZ(128, 'd')
    move.toX(0, 'd')
    move.toY(0, 'd')
    move.toZ(0, 'd')
    move.faceDirection(0)
end

    tX = (args[1] + 0)
    tY = (args[2] + 0)
    tZ = (args[3] + 0)
    tD = (args[4] + 0)

print("the Turtle will move the following distance:")
print('x: ' .. math.abs(tX - move.getX()))
print('y: ' .. math.abs(tY - move.getY()))
print('z: ' .. math.abs(tZ - move.getZ()))
sleep(10)

move.reset()
moveToTarge()
    while i < sleeptimer do
        term.clear()
        print('Time until return: ' .. i .. '/' .. sleeptimer)
        i = i + 1
        sleep(1)
end
moveHome()