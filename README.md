\*\*Group: 2_3_Emergent Web Server_NU-5B51-Collaborative_Jorit-Rishikesh

Quick Start\*\*

On your terminal, build the Image:

$ docker build -t ews-test .

Now run the Image:

$ docker run --name=ews -p 2011-2012:2011-2012 ews-test

To check whether the container is running, use 'container ls':

$ docker container ls

You should now see a list of all executing containers, including EWS. After confirming the container is running, we need to access its terminal to execute EWS. We make available a tool that allows users to interact with EWS using a command prompt.

To get access to the container's terminal:

$ docker exec -it ews bash

After typing this command on your terminal, you should get a terminal inside the container. To execute the tool to interact with EWS, type:

$ cd pal/

It should go inside the emergent_web_server/pal folder. Now type the command below:

$ dana -sp ../repository InteractiveEmergentSys.o

Interactive Emergent System
The interactive tool launches EWS. We ask the user to be patient as this may take a little while to start and configure EWS's 42 unique compositions. Once EWS is executing, you'll get access to a command prompt. To access all available commands to interact with EWS API, type:

sys> help

You'll get a list of all available commands and a brief description of what each of them does and their expected arguments. For instance, you can list all available compositions using 'get all configs':

sys> get_all_configs

The above command will give you a list of 42 compositions. The list contains a set of ID numbers followed by a unique string describing how the web server components are connected to form the available compositions. More information on the architectural description syntax is in the paper. To check the current webserver composition, use 'get config':

sys> get_config

To change from one composition to another, use 'set config':

sys> set_config 3

Be careful with the number passed as an argument. Make sure that this is a valid ID number for a composition. Check the list of available compositions (using get_all_configs command). At this point, you can also interact with the web server by opening a web browser and accessing: http://localhost:2012/. You should get a text index.html page. You can check the folder 'emergent_web_server/repository/htdocs' to see all available resources that can be accessed through the web server. You can also add your own and create different workload patterns by creating HTTP 1.0 client scripts. As examples, we make available two client scripts responsible to generate different workload patterns, you can find them at 'emergent_web_server/ws_clients'.

Perception and Learning
Now everything is ready for our interaction with the Perception and Learning modules. The Perception is responsible to collect performance information from the executing web server. After casting some requests to the server from the client scripts, you can get the perception data by using 'get perception' command:

sys> get_perception

The above command should return the average response time of all received requests handled by the server. Note that every time 'get perception' is used, the returned data is deleted from the system so that if you type 'get perception' twice in a row, the second time results in empty data as a response. That is when you do not have a continuous stream of requests. If you have a client continually requesting data from the server, the server will continue to monitor its response time and return it when it receives a 'get perception' request.

The average response time is the metric we use in our Learning module to decide which composition is the most suitable to handle the workload pattern the server is processing. To execute the Learning module, use the 'learn' command:

sys> learn

The system will require some information before starting learning. The available learning algorithm is a greedy algorithm with a fixed exploration time frame, and it serves as a baseline for comparison with other more advanced learning strategies. The first required information is the size of the observation window in milliseconds. The observation window is the duration of time the learning algorithm takes to observe the executing web server composition before collecting the average response time. The user is free to explore different numbers here, but beware that the bigger the observation window is, the longer the learning process takes, whereas the shorter the observation window is, the higher the probability of the learning algorithm making mistakes. We recommend the number '5000', 5 seconds for the observation window. Second, the learning module asks for an exploration threshold. After the learning algorithm finds the most suitable composition (the exploration phase), it enters the exploitation phase. This phase is maintained until the system gets different perception data, which tells that something has changed in the operating environment. The exploration threshold is the number of times the system detects a difference in the perception data before it triggers the exploration phase again. We recommend the value of 3 for the exploration threshold. Note that the higher this number is, the less sensitive to changes the algorithm becomes, whereas the lower this number is, the more sensitive to changes the algorithm gets (i.e., any disturbance in the collected data can trigger exploration again). Finally, the learning algorithm requires the number of rounds it should execute. Considering the algorithm executes in a command prompt, it is desirable that the learning algorithm finishes execution and the user gets back to the command prompt. Therefore, the round number is the number of iterations in the learning process. We recommend the number 52 for this argument. The learning algorithm takes 42 iterations to explore all possible compositions to determine which one is the most suitable. After that, the algorithm transitions to the exploitation phase. If nothing drastic changes in the operating environment, the algorithm continues to exploit the selected most suitable composition for 10 more rounds before it finishes its execution.

After providinng the learning algorithm with the requested information, the prompt waits until the user presses [ENTER] to start executing the learning algorithm. At this point, we advise the user to start a client script. We recommend the user to start a new terminal and gain access to the docker container using '$ docker exec -it ews bash'. Then the user should go to 'ws_clients' folder:

$ docker exec -it ews bash

Then...

$ cd ws_clients/

Then list, choose and execute the client scripts:

$ ls

For listing the folder's content. There are 3 different clients with different workload. The following command executes one of the client scripts:

$ dana ClientTextPattern.o

Once the client is executing, the user can go back to the UPISAS and run the code where MAPE-K loop is developed. The learning algorithm in UPISAS will prints the composition it is exploring and the average response time of that particular composition during execution. After exploration phase, the algorithm selects the composition that presented the lowest response time.
