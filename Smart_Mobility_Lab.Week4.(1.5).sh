#Understanding Services
#Start up the two turtlesim nodes, /turtlesim and /teleop_turtle.
ros2 run turtlesim turtlesim_node
ros2 run turtlesim turtle_teleop_key
#Service types are defined similarly to topic types, except service types have two parts: one message for the request and another for the response.
#To find out the type of a service, we use this command:
ros2 service type <service_name>
#Now we will use clear function
ros2 service type /clear
std_srvs/srv/Empty
#Oops it resulted as empty
#The Empty type means the service call sends no data when making a request and receives no data when receiving a response.

#o see the types of all the active services at the same time, we can append the --show-types option, abbreviated as -t, to the list command:
ros2 service list -t
#Which will return:
/clear [std_srvs/srv/Empty]
/kill [turtlesim/srv/Kill]
/reset [std_srvs/srv/Empty]
/spawn [turtlesim/srv/Spawn]
...
/turtle1/set_pen [turtlesim/srv/SetPen]
/turtle1/teleport_absolute [turtlesim/srv/TeleportAbsolute]
/turtle1/teleport_relative [turtlesim/srv/TeleportRelative]

#If we need to find all the services of a specific type, you can use the command:
ros2 service find <type_name>
#If we need specifically one service such as Empty then:
ros2 service find std_srvs/srv/Empty
#And it returns:
/clear
/reset

#ros2 interface show
#we can call services from the command line, but first we need to know the structure of the input arguments.
ros2 interface show <type_name>
#To see the request and response arguments of the /spawn service, run the command:
ros2 interface show turtlesim/srv/Spawn
#Which will return:
float32 x
float32 y
float32 theta
string name # Optional.  A unique name will be created and returned if this is empty
---
string name

#ros2 service call
Now that we know what a service type is, how to find a service’s type, and how to find the structure of that type’s arguments, we can call a service using:
ros2 service call <service_name> <service_type> <arguments>
#The <arguments> part is optional. For example, you know that Empty typed services don’t have any arguments:
ros2 service call /clear std_srvs/srv/Empty
#This command will clear the turtlesim window of any lines our turtle has drawn
ros2 service call /spawn turtlesim/srv/Spawn "{x: 2, y: 2, theta: 0.2, name: ''}"
#Abovementioned code will give us method-style view of what’s happening, and then the service response:
requester: making request: turtlesim.srv.Spawn_Request(x=2.0, y=2.0, theta=0.2, name='')

response:
turtlesim.srv.Spawn_Response(name='turtle2')
# our turtlesim window will update with the newly spawned turtle right away:

