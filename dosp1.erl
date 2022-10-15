-module(dosp1).
-compile(export_all).
-import(string,[concat/2,substr/3]).
-import(lists,[duplicate/2]).

run(Num)->
   Pid1= spawn(dosp1,boss,[]),
   Pid1 ! {self(),{Num,temp_atom}}.

boss() ->
    receive
        {Client,{Num,temp_atom}}->
                Ufid="a.rathore;",
                Length=12,
                AllowedChars="qwertyQWERTY1234567890",
                Rand=lists:foldl(fun(_, Acc) ->
                    [lists:nth(rand:uniform(length(AllowedChars)),AllowedChars)]
                        ++ Acc
                    end, [], lists:seq(1, Length)),
                InputString=concat(Ufid,Rand),
                InputString2=concat(Ufid,Rand),
                GeneratedSha256= io_lib:format("~64.16.0b", [binary:decode_unsigned(crypto:hash(sha256,InputString))]),
                Str2 = substr(GeneratedSha256,1,Num),
                Strzero=lists:flatten(lists:join("", [integer_to_list(I) || I <- duplicate(Num,0)])),
                Isequal=string:equal(Str2,Strzero),    
            if 
                Isequal->
                    {Time1, _} = statistics(runtime),
                    {Time2,_ } = statistics(wall_clock),
                    U1 = Time1,
                    U2 = Time2,
                    U3 = U2/U1, 
                    io:format("Cpu time to Real time is ~w ~n Input number was: ~w ~n random string generated was: ~s ~n And the generated coin is: ~s ~n",[U3,Num,InputString2,GeneratedSha256]),
            
                    Pid2= spawn(dosp1,boss,[]),
                    Pid2 ! {self(),{Num,temp_atom}};
            true ->   
                    Pid3= spawn(dosp1,boss,[]),
                    Pid3 ! {self(),{Num,temp_atom}}
            end          
           
end.











   

