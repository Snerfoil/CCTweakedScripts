mux = require("muxzcat")
require("turt")

seq = mux.DecompressXzOrLzmaFileTemp("test.7zmcbs")
trackFile = "temp.txt"
rotFile = "temp2.txt"
f = io.open(trackFile,"r")
f2 = io.open(rotFile,"r")
startPos = 1
if(not(f == nil)) then
    startPos = tonumber(f:read())
    f:close()
end
if(not(f2 == nil)) then
    TurtBoi.facing = tonumber(f2:read())
    f2:close()
end
f = io.open(trackFile,"w")
f2 = io.open(rotFile,"w")
for i = startPos,string.len(seq),1
do
    --write the value of i to a file. read from this when the program bootsup
    f:write(i)
    f:flush()
    f2:write(TurtBoi.facing)
    f2:flush()
    --os.sleep(0.001)
    --print(string.byte(seq,i))
    --255 up
    --254 down
    --253 south
    --252 north
    --251 east
    --250 west
    --others indicate block placement corrisponding to the index number.
    --turtles start facing south, aka +z (in blender this is the -y direction or "forward" rather.)
    if(string.byte(seq,i)==255) then
        TurtBoi:moveUp()
    elseif(string.byte(seq,i)==254) then
        TurtBoi:moveDown()
    elseif(string.byte(seq,i)==253) then
        TurtBoi:moveSouth()
    elseif(string.byte(seq,i)==252) then
        TurtBoi:moveNorth()
    elseif(string.byte(seq,i)==251) then
        TurtBoi:moveEast()
    elseif(string.byte(seq,i)==250) then
        TurtBoi:moveWest()
    else
        TurtBoi:placeBlock(string.byte(seq,i)+1)
    end
end
f:close()
