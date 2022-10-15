-module(client).
-compile(export_all).
-import(string,[concat/2,substr/3]).
-import(lists,[duplicate/2]).


boss(Num) ->
    
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
        NodeName=node(),    
    if 
        Isequal->
            {Time1, _} = statistics(runtime),
            {Time2,_ } = statistics(wall_clock),
            U1 = Time1,
            U2 = Time2,
            U3 = U2/U1, 
            io:format("Node used is ~s ~n Cpu time to Real time is ~w ~n Input number was: ~w ~n random string generated was: ~s ~n And the generated coin is: ~s ~n",[NodeName,U3,Num,InputString2,GeneratedSha256]),
            boss(Num);

    true ->   
                boss(Num)
    end.          
   
main(0, _) ->
    io:fwrite("worker with this PID is getting closed::~w~n",[self()]),
    exit(self());
    
main(N, K) ->
    % io:fwrite("Searching coin on ~w~n", [self()]),
    boss(K),
    main(N-1, K).

for_initiate(0,_,_) ->  
        io:fwrite("All the remote workers are done with their work and spawned properly~n");

for_initiate(Worker,K,Workload) when Worker > 0 -> 
    Pid = spawn(client, main, [Workload, K]), 
    io:fwrite("A new remote worker of the following PID: ~w is generated ~n  ", [Pid]),
    for_initiate(Worker-1,K,Workload).

initiate() ->
    receive
        {Client, {Workload, K, generated_bitcoin}} ->
            for_initiate(8,K,Workload)

end.

