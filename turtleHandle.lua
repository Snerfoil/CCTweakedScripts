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
replyData = {}

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
    print(x[1]) -- command name
    print(x[2]) -- direction
    print(x[3]) -- ammount
    print(x[4]) -- context
    print("===")
    
    --TODO: finish all of the actions. nuff said.
    
    switch( x[1],
    case( "move"      , function() moveAction(x)      end),
    case( "dig"       , function() digAction(x)       end),
    case( "place"     , function() placeAction(x)     end),
    case( "drop"      , function() dropAction(x)      end),
    case( "attack"    , function() attackAction(x)    end),
    case( "suck"      , function() suckAction(x)      end),
    case( "select"    , function() turtle.select(x[2])end),
    case( "refuel"    , function() turtle.refuel()    end),
    case( "equip"     , function() equipAction(x)     end),
    case( "craft"     , function() craftAction(x)     end),
    case( "inspect"   , function() inspectAction(x)   end),
    case( "swapTo"    , function() print("swapTo")    end), -- moves items with transferTo
    case( "poke"      , function() print("poke")      end), -- idk what this was ment to do.
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

function placeAction(x)
    switch( x[2],
    case( "up"     , function() turtle.placeUp()   end),
    case( "down"   , function() turtle.placeDown() end),
    case( "forward", function() turtle.place()     end),
    case( "left"   , function() turtle.turnLeft(1); turtle.place(); turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); turtle.place(); turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); turtle.place(); turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() turtle.back(0) end)
    )
end

function dropAction(x)
    switch( x[2],
    case( "up"     , function() turtle.dropUp(x[3])   end),
    case( "down"   , function() turtle.dropDown(x[3]) end),
    case( "forward", function() turtle.drop(x[3])     end),
    case( "left"   , function() turtle.turnLeft(1); turtle.drop(x[3]); turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); turtle.drop(x[3]); turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); turtle.drop(); turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() turtle.back(0) end)
    )
end

function attackAction(x)
    switch( x[2],
    case( "up"     , function() turtle.attackUp(x[4])   end),
    case( "down"   , function() turtle.attackDown(x[4]) end),
    case( "forward", function() turtle.attack(x[4])     end),
    case( "left"   , function() turtle.turnLeft(1); turtle.attack(x[4]); turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); turtle.attack(x[4]); turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); turtle.attack(x[4]); turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() turtle.back(0) end)
    )
end

function suckAction(x)
    switch( x[2],
    case( "up"     , function() turtle.suckUp(x[3])   end),
    case( "down"   , function() turtle.suckDown(x[3]) end),
    case( "forward", function() turtle.suck(x[3])     end),
    case( "left"   , function() turtle.turnLeft(1); turtle.suck(x[3]); turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); turtle.suck(x[3]); turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); turtle.suck(x[3]); turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() turtle.back(0) end)
    )
end

function equipAction(x)
    switch( x[2],
    case( "left"   , function() turtle.equipLeft()   end),
    case( "right"  , function() turtle.equipRight()  end),
    default( function() turtle.back(0) end)
    )
end

function craftAction(x)
    if(turtle.craft ~= nil)
    then do
        turtle.craft(x[3])
        end
    end
end

function inspectAction(x)
    switch( x[2],
    case( "up"     , function() replyData={turtle.inspectUp()}   end),
    case( "down"   , function() replyData={turtle.inspectDown()} end),
    case( "forward", function() replyData={turtle.inspect()}     end),
    case( "left"   , function() turtle.turnLeft(1); replyData={turtle.inspect()}; turtle.turnRight(1)  end),
    case( "right"  , function() turtle.turnRight(1); replyData={turtle.inspect()}; turtle.turnLeft(1)  end),
    case( "back"   , function() turtle.turnLeft(1); turtle.turnLeft(1); replyData={turtle.inspect()}; turtle.turnLeft(1); turtle.turnLeft(1) end),
    default( function() replyData={turtle.getItemDetail(x[2])} end)
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
    -- reply with stored info.
    sendMsg(reply[4],targPort,replyData)
end