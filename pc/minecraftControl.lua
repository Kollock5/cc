mouseWidth = 0
mouseHeight = 0

monitor = peripheral.find('monitor')
monitor.clear()

monitor.setCursorPos(1, 1)

local w, h = monitor.getSize()
state = 0

function draw()
    monitor.setCursorPos(1, 2)
    monitor.setBackgroundColour((colours.red))
    if state == 1 then monitor.setBackgroundColour((colours.lime)) end
    monitor.write(" Marc  ")
    monitor.setCursorPos(1, 4)
    monitor.setBackgroundColour((colours.red))
    if state == 2 then monitor.setBackgroundColour((colours.lime)) end
    monitor.write(" Peda  ")
    monitor.setBackgroundColour((colours.red))
    if state == 3 then monitor.setBackgroundColour((colours.lime)) end
    monitor.setCursorPos(1, 6)
    monitor.write(" Max   ")
    monitor.setBackgroundColour((colours.black))
end

function checkClickPosition()
    state = 0

    if mouseWidth > 0 and mouseWidth < 9 and mouseHeight == 2 then
        rs.setOutput("front", false)
        rs.setOutput("back", false)
        state = 1
    elseif mouseWidth > 0 and mouseWidth < 9 and mouseHeight == 4 then
        rs.setOutput("front", false)
        rs.setOutput("back", true)
        state = 2
    elseif mouseWidth > 0 and mouseWidth < 9 and mouseHeight == 6 then
        rs.setOutput("front", true)
        rs.setOutput("back", false)
        state = 3
    end
    draw()
    if not (state == 0) then
        rs.setOutput("right", true)
        sleep(1)
        rs.setOutput("right", false)
    end
end


while true do
    event, p1, p2, p3 = os.pullEvent()
    if event == "monitor_touch" then
        mouseWidth = p2
        mouseHeight = p3
        checkClickPosition()
    end
    draw()
end


