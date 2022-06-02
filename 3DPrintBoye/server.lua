wifi = peripheral.wrap("back")
wifi.open(149)
refStore = peripheral.wrap("right")
while(true) do
    msg = ({os.pullEvent("modem_message")})[5]
    refStore.exportItem({name=msg,count=64},"up")
end
