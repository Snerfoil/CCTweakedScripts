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
redLeft = 0
redRight = 0
redUp = 0
redDown = 0
redForward = 0
redBackward = 0

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

function serverHandleFunct(x)
    --x is a list formatted like
    --in my notes.
    --stuff that isnt formmated
    --correctly returns all nil
    print(x[1])
    print(x[2])--left
    print(x[3])--right
    print(x[4])--up
	print(x[5])--down
	print(x[6])--forward
	print(x[7])--back
    print("===")
    
    --TODO: finish all of the actions. nuff said.
    
    switch( x[1],
    case( "get"      , function() setState(x)      end),
    case( "set"       , function() getState(x)       end),
    default(       function() print("nothin") end)
    )
end    

function setState(x)
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

function getState(x)
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
        pcall(serverHandleFunct,reply[5])
    end
    else do
        pcall(serverHandleFunct,defaultAction)
    end
    end
	--set the redstone values here.
end