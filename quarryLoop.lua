--simple quarry loop I wrote so I can use these things to mine for me while im away.

function digSeq()
    currentSlot = turtle.getSelectedSlot()
    turtle.select(16)
    turtle.placeUp()
    turtle.select(currentSlot)
    turtle.digDown()
    turtle.dropUp()
    turtle.digUp()
    turtle.transferTo(16)
end

doLeft = true --do width on left side?
length = 2 --how deep it goes
width = 3 --how long it goes to its left
height = 7 --how long it goes forward

for i = 1,length,1
do
    for j = 1,width,1
    do
        for k = 1,height,1
        do
            digSeq()
            if(k~=height) then
                if(not turtle.forward()) then
                    --refuel
                    turtle.forward()
                end
            end
            
        end
        
        if(doLeft) then
            turtle.turnLeft()
        else
            turtle.turnRight()
        end
        
        if(j~=width) then
            if(not turtle.forward()) then
                --refuel
                turtle.forward()
            end
        else
            if(not turtle.down()) then
                --refuel
                turtle.down()
            end
            doLeft = not doLeft
            if(doLeft) then
                turtle.turnLeft()
                turtle.turnLeft()
            else
                turtle.turnRight()
                turtle.turnRight()
            end
        end
        
        if(doLeft) then
            turtle.turnLeft()
        else
            turtle.turnRight()
        end
        doLeft = not doLeft
        
    end
end