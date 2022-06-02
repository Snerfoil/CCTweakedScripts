function peek(x)
    for k,v in pairs(x)
    do
        print(k,"::",type(v),"::",v)
        if(type(v) == "table")
        then do
            peek(v)
            end
        end
        io.read()
    end
end
