require("switchCase")
require("wifiBlaster")
print("targetPort")
targPort = tonumber(read())

if(wifi.isOpen(targPort) == false)
then do
  togglePort(targPort)
end
end  

delay = 0
reply = {}

seconds = 10
defaultAction = {"nothing","left",0,"Sample Text"}

function refresh()
    delay = os.startTimer(seconds)
    os.pullEvent("timer")
end

function captureReq()
    reply = {os.pullEvent("modem_message")}
end

--mainServerProg

function turtleHandleFunct(x)
    --x is a list formatted like
    --in my notes.
    --stuff that isnt formmated
    --correctly returns all nil
    print(x[1])
    print(x[2])
    print(x[3])
    print(x[4])
    print("===")
    
    --TODO: finish all of the actions. nuff said.
    
    switch( x[1],
    case( "move"      , function() moveAction(x)      end),
    case( "dig"       , function() digAction(x)       end),
    case( "place"     , function() print("place")     end),
    case( "drop"      , function() print("drop")      end),
    case( "attack"    , function() print("attack")    end),
    case( "suck"      , function() print("succ")      end),
    case( "select"    , function() print("select")    end),
    case( "refuel"    , function() print("refuel")    end),
    case( "equip"     , function() print("equip")     end),
    case( "craft"     , function() print("craft")     end),
    case( "swapTo"    , function() print("swapTo")    end),
    case( "poke"      , function() print("poke")      end),
    case( "shutdown"  , function() print("shutdown")  end),
    case( "reboot"    , function() print("reboot")    end),
    case( "setLabel"  , function() print("setLabel")  end),
    case( "cd"        , function() print("cd")        end),
    case( "setDispMsg", function() print("setDispMsg")end),
    case( "getDir"    , function() print("getDir")    end),
    default(       function() print("nothin") end)
    )
end    

function moveAction(x)
    --BUG: movement functions can only do single steps.
    --the parameter there doesnt do anything. this needs
    --to actually loop for x[3] times.
    switch( x[2],
    case( "up"     , function() turtle.up(x[3])        end),
    case( "down"   , function() turtle.down(x[3])      end),
    case( "forward", function() turtle.forward(x[3])   end),
    case( "back"   , function() turtle.back(x[3])      end),
    case( "left"   , function() turtle.turnLeft(x[3])  end),
    case( "right"  , function() turtle.turnRight(x[3]) end),
    default( function() turtle.back(0) end)
    )
end

function digAction(x)
    --This should condense many of the actions
    --ima do this in a big boi editor.
    switch( x[2],
    case( "up"     , function() turtle.digUp()   end),
    case( "down"   , function() turtle.digDown() end),
    case( "forward", function() turtle.dig()     end),
    case( "left"   , function() turtle.turnLeft(1); turtle.dig(); turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); turtle.dig(); turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); turtle.dig(); turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() turtle.back(0) end)
    ) 
end

--loop cycle

while(true)
do
    status = parallel.waitForAny(captureReq,refresh)
    if(status == 1)
    then do
        pcall(turtleHandleFunct,reply[5])
    end
    else do
        pcall(turtleHandleFunct,defaultAction)
    end
    end    
end