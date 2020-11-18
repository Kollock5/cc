while turtle.detectUp() do
    turtle.digUp()
    turtle.up()
end
while not turtle.detectDown() do
    turtle.down()
end

local savePos = fs.open('saves/treefarm/pos', 'w')
savePos.writeLine('test')
savePos.close()