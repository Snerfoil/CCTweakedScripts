# CCTweakedScripts
This is where I keep my CCTweaked lua scripts for quick access.
also I forgot what all of this did lol

okay I remember now. so this is an unfinished turtle remote control app thingy.

on the turtle you just run turtleHandle from the command line.

then on another computer you boot up an lua prompt and run this.

require("wifiBlaster")

it will ask you which side the endermodem is on.

then you can use

sendMsg(port,0,{"move","forward",1,"comment"}) -- these values can optionally be nil

to drive it around. I still need to finish this.

also in lua functions can return multiple values, (apparently python does this too.)
shove them in a table to capture everything

merp = {something()}

you can view a table with
for k,v in pairs(merp) do print(k,v); io.read() end

