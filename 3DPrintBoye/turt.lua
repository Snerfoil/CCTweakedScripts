TurtBoi = {
    facing = 0, 
    fuelType = "minecraft:coal",
    block = {
        "minecraft:stone",
        "minecraft:dirt"
    },
    turtWifi = peripheral.wrap("right"),
    wifiChannel = 149,
    turtFaceFile = "temp2.txt"
}
function TurtBoi:recalibrate(invID,facing)
    lastInv = turtle.getSelectedSlot()
    turtle.select(invID)
    turtle.equipLeft()
    checc = peripheral.wrap("left")
    while(not(checc.getFacing() == facing)) do
        turtle.turnRight()
    end
    turtle.equipLeft()
    turtle.select(lastInv)
end
function TurtBoi:recFace()
    f = io.open(self.turtFaceFile,"w")
    f:write(self.facing)
    f:close()
end
function TurtBoi:request(blockID,invID)
    turtle.select(16)
    turtle.place() --doing this forward as not to get blocked by the print head
    --print(blockID," ",invID)
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
    --print(invID)
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
        self.facing = 3
        self:recFace()
        turtle.turnRight()
        self.facing = 0
        self:recFace()
    end if(self.facing==2) then
        turtle.turnRight()
        self.facing = 0
        self:recFace()
    end if(self.facing==3) then
        turtle.turnLeft()
        self.facing = 0
        self:recFace()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    
end
function TurtBoi:moveNorth()
    if(self.facing==0) then
        turtle.turnRight()
        self.facing = 2
        self:recFace()
        turtle.turnRight()
        self.facing = 1
        self:recFace()
    end if(self.facing==2) then
        turtle.turnLeft()
        self.facing = 1
        self:recFace()
    end if(self.facing==3) then
        turtle.turnRight()
        self.facing = 1
        self:recFace()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    
end
function TurtBoi:moveEast()
    if(self.facing==0) then
        turtle.turnLeft()
        self.facing = 2
        self:recFace()
    end if(self.facing==1) then
        turtle.turnRight()
        self.facing = 2
        self:recFace()
    end if(self.facing==3) then
        turtle.turnRight()
        self.facing = 0
        self:recFace()
        turtle.turnRight()
        self.facing = 2
        self:recFace()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    
end
function TurtBoi:moveWest()
    if(self.facing==0) then
        turtle.turnRight()
        self.facing = 3
        self:recFace()
    end if(self.facing==1) then
        turtle.turnLeft()
        self.facing = 3
        self:recFace()
    end if(self.facing==2) then
        turtle.turnRight()
        self.facing = 1
        self:recFace()
        turtle.turnRight()
        self.facing = 3
        self:recFace()
    end
    if(not turtle.forward()) then
        self:request(self.fuelType,15)
        turtle.refuel()
        turtle.forward()
    end
    
end