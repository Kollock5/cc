--wget https://raw.githubusercontent.com/Kollock5/cc/main/updater/updateInit.lua up/init

function updateMove()
    file = fs.open('up/upMove', 'w')
    file.writeLine('shell.run("rm apis/move")')
    file.writeLine('shell.run("wget https://raw.githubusercontent.com/Kollock5/cc/main/apis/move.lua apis/move")')
    file.close()
end

function updateGPS()
    file = fs.open('up/upGPS', 'w')
    file.writeLine('shell.run("rm apis/move")')
    file.writeLine('shell.run("wget https://raw.githubusercontent.com/Kollock5/cc/main/apis/moveGPS.lua apis/move")')
    file.close()
end

function updateTree()
    file = fs.open('up/upTree', 'w')
    file.writeLine('shell.run("rm turtles/tree")')
    file.writeLine('shell.run("wget https://raw.githubusercontent.com/Kollock5/cc/main/turtles/tree.lua turtles/tree")')
    file.close()
end

function updateFarm()
    file = fs.open('up/upFarm', 'w')
    file.writeLine('shell.run("rm turtles/farm")')
    file.writeLine('shell.run("wget https://raw.githubusercontent.com/Kollock5/cc/main/turtles/farm.lua turtles/farm")')
    file.close()
end

function updateMine()
    file = fs.open('up/upMine', 'w')
    file.writeLine('shell.run("rm turtles/mine")')
    file.writeLine('shell.run("wget https://raw.githubusercontent.com/Kollock5/cc/main/turtles/mine.lua turtles/mine")')
    file.close()
end

updateMove()
updateTree()
updateFarm()
updateMine()
updateGPS()
