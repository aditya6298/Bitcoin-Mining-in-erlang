# Bitcoin-Mining-in-erlang
implemented sha-256 algorithm using Erlang, That follows client server architecture and actor model in erlang.


Steps to run the program-:
1.	Download the project1.zip file
2.	Extract the contents.
3.	There are two types of files one is to run the program on a local server(dosp1.erl) and the other is to establish a client-server connection to run the workers on different nodes.
4.	Let’s start with how to run the program on the local server.
1.	Navigate to cmd and then go to the directory where the file(dosp1) is,
2.	Type erl,
3.	It will start the erlang shell
4.	Type – c(dosp1). (to compile the file)
5.	Type- ‘dosp1:run(Input).’ (to start the code)  ** here input is the number of zeroes u want to test it on so write it like ‘dosp1:run(4).’ If u want to test it to four 0’s.
6.	** At most u can mine for 5 zeroes after that the process will take a long time.
7.	It will look like this-:
8.	Use ctrl+c to stop the program execution because it will run for an infinite time until the machine resources exhaust completely.
 
![image](https://user-images.githubusercontent.com/38376053/196007863-7f101d1b-cd24-493c-9195-c6b23a3262e2.png)


5.	Now let’s run the code for client-server functionality
1.	Navigate to cmd and then go to the directory where the file (client.erl and server.erl) is,
2.	Type erl,
3.	It will start erlang shell,
4.	Compile the file,s for that first type- ‘c(client).’ and then type ‘c(server).’
5.	After compilation is done copy the client file and paste it into another node or machine
6.	Do the same for the node to compile the client code,
7.	In the server file on line 10 replace 192.168.0.42 with the IP address of the client and compile it.
8.	Now let’s establish the connection
                                                        On the server side, in the directory type-
1.	(erl -name node1@’IP_address_of_server_node’ -setcookie ‘name_of_cookie’.)

On the client side. In the directory type ()
2.	(erl -name node2@’IP_address_of_client_node’ -setcookie ‘cookie_name_same_as_server’.)
3.	Now to establish the connection, on server type- (net_adm:ping(node2@’IP_address_of_client_node’).)
    If pong comes as output then the connection is established and now the node will work as a worker and will help in coin hashing.   

Refer to the images
At the client-
 
![image](https://user-images.githubusercontent.com/38376053/196007885-d9133052-c271-4900-aa9d-0537fc91bbc5.png)






At the server side- 
After the connection is done
  1.c(server).
 2.server:main().  – this will run the main function in the client and will generate workers that will participate in hashing.
As the process is asynchronous,  the output will not be in sync as every string take a different amount of time to be mined. 
![image](https://user-images.githubusercontent.com/38376053/196007898-c6e028b0-4a13-4a18-a589-7e1bc65afc03.png)

 



•	Question 1- The size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
As we can see in the image, the workload here is 10000 which was divided by every worker and 10 is the number of instances generated, So basically 10000 processes will run on every instance generated.
This was for the best performance we can change the number but it may impact performance, and totally vary from machine to machine. 
  
![image](https://user-images.githubusercontent.com/38376053/196007900-02559fa4-6648-45ce-8ed0-502b9c91f893.png)















•	Question 2- The result of running your program for input 4.
Solution-  Here is the result of running with input 4. 
![image](https://user-images.githubusercontent.com/38376053/196007905-227245d8-282a-4a62-a7dd-bea2949684aa.png)




•	Question 3-The running time for the above is reported by time for the above and report the time.  The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation.  If you are close to 1 you have almost no parallelism (points will be subtracted).
Solution- As we can see in the image above the CPU time to real-time is varying between (2-5).






•	Question 4- The coin with the most 0s you managed to find.
Solution- 5 is the most 0’s we managed to find.
 
 ![image](https://user-images.githubusercontent.com/38376053/196007913-abf8d501-5271-41e8-9e73-725300a886de.png)

•	Question 5- The largest number of working machines you were able to run your code with.
Solution- We were able to run our code on 11 machines one was server and other was client.

  

