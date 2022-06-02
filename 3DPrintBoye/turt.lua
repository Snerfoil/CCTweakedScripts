TurtBoi = {
    facing = 0, 
    fuelType = "minecraft:coal",
    block = {
        "minecraft:stone",
        "minecraft:dirt"
    },
    turtWifi = peripheral.wrap("right"),
    wifiChannel = 149
}

function TurtBoi:request(blockID,invID)
    turtle.select(16)
    turtle.place() --doing this forward as not to get blocked by the print head
    
    --TODO: write the call to the item distributor, the turtle awaits a response.
    self.turtWifi.transmit(self.wifiChannel,0,blockID)
    --serverside gets the msg with ({os.pullEvent("modem_message")})[5] this doesnt seem to piss of the watchdog
    --refStore.exportItem({name=msg,count=64},"up") where refStore is the bound interface.
    turtle.select(invID)
    while(not turtle.suck()) do end --await the items
    --also this can crash the turtle after a while. check implementation
    turtle.select(16)
    turtle.dig()
    turtle.select(invID)
end
function TurtBoi:placeBlock(invID)
    turtle.select(invID)
    if(not turtle.placeDown()) then
        self:request(self.block[invID],invID)
        turtle.placeDown()
    end
end
function TurtBoi:moveUp()
    if(not turtle.up()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.up()
    end
end
function TurtBoi:moveDown()
    if(not turtle.down()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.down()
    end
end
function TurtBoi:moveSouth()
    if(self.facing==1) then
        turtle.turnRight()
        turtle.turnRight()
    end if(self.facing==2) then
        turtle.turnRight()
    end if(self.facing==3) then
        turtle.turnLeft()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    self.facing = 0
end
function TurtBoi:moveNorth()
    if(self.facing==0) then
        turtle.turnRight()
        turtle.turnRight()
    end if(self.facing==2) then
        turtle.turnLeft()
    end if(self.facing==3) then
        turtle.turnRight()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    self.facing = 1
end
function TurtBoi:moveEast()
    if(self.facing==0) then
        turtle.turnLeft()
    end if(self.facing==1) then
        turtle.turnRight()
    end if(self.facing==3) then
        turtle.turnRight()
        turtle.turnRight()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    self.facing = 2
end
function TurtBoi:moveWest()
    if(self.facing==0) then
        turtle.turnRight()
    end if(self.facing==1) then
        turtle.turnLeft()
    end if(self.facing==2) then
        turtle.turnRight()
        turtle.turnRight()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    self.facing = 3
end