t = fs.open("marks", "w")
p = peripheral.getNames()

t.write(p)
t.close()
