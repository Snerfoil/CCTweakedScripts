function switch(n, ...)
  for _,v in ipairs {...} do
    if v[1] == n or v[1] == nil then
      return v[2]()
    end
  end
end

function case(n,f)
    return {n,f}
end

function default(f)
    return {nil,f}
end

--example usage

--action = "left"

--switch( action,
--  case( "up", function() print("one")     end),
--  case( "down", function() print("two")     end),
--  case( "left", function() print("three")   end),
--  default( function() print("default") end)
--)