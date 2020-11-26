os.loadAPI('apis/move')

local args = (...)
local tX
local tY
local tZ
local tD
local tL

function setTarget()
    file = fs.open('data/rMine/target', 'w')
    file.writeLine(tX)
    file.writeLine(tY)
    file.writeLine(tZ)
    file.writeLine(tD)
    file.writeLine(tL)
    file.close()
    if debug then
        print('target set')
    end
end

function loadTarget()
    file = fs.open('data/rMine/target', 'r')
    tX = file.readLine() + 0
    tY = file.readLine() + 0
    tZ = file.readLine() + 0
    tD = file.readLine() + 0
    tL = file.readLine() + 0
    file.close()
end



function clearInventory()
    turtle.digUp()
    turtle.select(1)
    turtle.placeUp()
    local i = 2
    while i <= 16 do
        turtle.select(i)
        turtle.dropUp()
        i = i + 1
    end
    turtle.select(1)
    turtle.digUp()
end

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



if args[1] == nil then
    if fs.exists('data/gps/save') then
        loadTarget() 
    end
elseif args[5] == nil then
    print('rMine X Y Z D L')
else
    tX = args[1]
    tY = args[2]
    tZ = args[3]
    tD = args[4]
    tL = args[5]
end
move.init()
moveToTarge()
moveHome()
