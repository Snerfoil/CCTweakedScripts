--use require("wifiBlaster")
--gives you access to these functions
print("specify wifi: ")
wifi = peripheral.wrap(read())

function togglePort(x)
    if(wifi.isOpen(x))
    then do
        wifi.close(x)
    end
    else do
        wifi.open(x)
    end
    end
end

function getMsg()
    return {os.pullEvent("modem_message")}
end

function sendMsg(x,y,z)
    wifi.transmit(x,y,z)
end

--print("toggle port: ")
--portNo = tonumber(read())
--togglePort(portNo)
--print("sendMsgChannel: ")
--sendPort = tonumber(read())
--print("sendMsgReplyCh: ")
--sendReplyPort = tonumber(read())
--print("sendMsg: ")
--msgText = read()
--sendMsg(sendPort,sendReplyPort,msgText)
--print("await response...")
--replyText = getMsg()[5]
--print(replyText)
--print("closingPort")
--togglePort(portNo)
--print("end test")
--read()