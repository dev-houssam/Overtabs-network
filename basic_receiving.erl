Pid = spawn(mod, fun, [args]).
Pid ! {message, "Hello process"}. 

receive 
  {message, Msg} ->
    io:format("Received: ~s", [Msg]) 
end
