os.loadAPI('apis/move')

move.toX(10)
move.toY(15)
returnHome()
readyUp()

function cutTree()
    end
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end
    while not turtle.detectDown() do
        turtle.down()
    end
end

function unload()
    local i = 3
    while i <= 16 do
        turtle.select(i)
        turtle.drop()
        i = i + 1
    end
end

function returnHome()
    while not move.toZ(20) do
        turtle.digUp()
    end
    move.toX(0)
    move.toY(0)
    move.toZ(0)
end

function readyUp()
    move.faceDirection(2)
    unload()
    move.turnLeft()
    turtle.select(1)
    turtle.suck()
    move.turnLeft()
    move.turnLeft()
    turtle.select(2)
    turtle.suck()
    local amount = turtle.getItemCount() - 1
    turtle.refuel(amount)
    move.turnRight()
end