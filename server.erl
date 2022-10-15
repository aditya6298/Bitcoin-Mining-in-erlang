-module(server).
-compile(export_all).


for_initiate(0,_,_)->
    io:fwrite("All the remote workers are done with their work and spawned properly ~n");

for_initiate(Worker,K,Workload) when Worker>0 ->
    WorkLoad_Dist=Workload/2,
    Pid_Remote=spawn('node2@192.168.0.42',client,initiate,[]),
    Pid_Remote ! {self(),{WorkLoad_Dist,K,generated_bitcoin}},
    for_initiate(Worker-1,K,Workload).

main()->
    {ok,K}=io:read("what input you want to give: "),
    for_initiate(8, K, 10000).   
