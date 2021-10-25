print("specify wifi dongle: ")
wifi = peripheral.wrap(read())
print("open port no: ")
wifi.open(tonumber(read()))
print("send or get [s/g]:")
if(read()=="s")
then do
    --this
    print("send file: ")
    doc = fs.open(read(),"r")
    wifi.transmit(0,0,doc.readAll())
    doc.close()
end
else do
    --that
    print("write file: ")
    doc = fs.open(read(),"w")
    print("awating transmission...")
    reply = {os.pullEvent("modem_message")}
    print("msg get: ")
    print(reply[5])
    doc.write(reply[5])
    doc.close()
end
end
print("transmission done\nPress any key to continue")
read()
wifi.close(0)