#Understanding parameters
#Start up the two turtlesim nodes, /turtlesim and /teleop_turtle.
ros2 run turtlesim turtlesim_node
#With a new terminal:
ros2 run turtlesim turtle_teleop_key

#2 ros2 param list
#To see the parameters belonging to your nodes, open a new terminal and enter the command:
ros2 param list
#We will see the node namespaces, /teleop_turtle and /turtlesim, followed by each node’s parameters:
/teleop_turtle:
  qos_overrides./parameter_events.publisher.depth
  qos_overrides./parameter_events.publisher.durability
  qos_overrides./parameter_events.publisher.history
  qos_overrides./parameter_events.publisher.reliability
  scale_angular
  scale_linear
  use_sim_time
/turtlesim:
  background_b
  background_g
  background_r
  qos_overrides./parameter_events.publisher.depth
  qos_overrides./parameter_events.publisher.durability
  qos_overrides./parameter_events.publisher.history
  qos_overrides./parameter_events.publisher.reliability
  use_sim_time
  #Every node has the parameter use_sim_time; it’s not unique to turtlesim.
  
  #3 ros2 param get
  #To display the type and current value of a parameter, we use:
  ros2 param get <node_name> <parameter_name>
 #To find out the current value of /turtlesim’s parameter background_g:
 ros2 param get /turtlesim background_g
 #With a return value:
 Integer value is: 86
 
 #4 ros2 param set
 To change a parameter’s value at runtime:
 ros2 param set <node_name> <parameter_name> <value>
 #Let’s change /turtlesim’s background color:
 ros2 param set /turtlesim background_r 150
 #With a return message:
 Set parameter successful
 #And the background of our turtlesim window should change colors:
 
 #5 ros2 param dump
 #We can view all of a node’s current parameter values by using the command:
 ros2 param dump <node_name>
 #To save our current configuration of /turtlesim’s parameters into the file turtlesim.yaml, we should enter the command:
 ros2 param dump /turtlesim > turtlesim.yaml
 #There will be a new file in the current working directory of our shell. If  this file is opened, we’ll see the following content:
/turtlesim:
  ros__parameters:
    background_b: 255
    background_g: 86
    background_r: 150
    qos_overrides:
      /parameter_events:
        publisher:
          depth: 1000
          durability: volatile
          history: keep_last
          reliability: reliable
    use_sim_time: false
 
#6 ros2 param load
#using this command we can load parameters from a file to a currently running node:
ros2 param load <node_name> <parameter_file>
#To load the turtlesim.yaml file generated with ros2 param dump into /turtlesim node’s parameters, we should enter this command:
ros2 param load /turtlesim turtlesim.yaml
#our terminal will return the message:
Set parameter background_b successful
Set parameter background_g successful
Set parameter background_r successful
Set parameter qos_overrides./parameter_events.publisher.depth failed: parameter 'qos_overrides./parameter_events.publisher.depth' cannot be set because it is read-only
Set parameter qos_overrides./parameter_events.publisher.durability failed: parameter 'qos_overrides./parameter_events.publisher.durability' cannot be set because it is read-only
Set parameter qos_overrides./parameter_events.publisher.history failed: parameter 'qos_overrides./parameter_events.publisher.history' cannot be set because it is read-only
Set parameter qos_overrides./parameter_events.publisher.reliability failed: parameter 'qos_overrides./parameter_events.publisher.reliability' cannot be set because it is read-only
Set parameter use_sim_time successful

#7 Load parameter file on node startup
#To start the same node using our saved parameter values, we use:
ros2 run <package_name> <executable_name> --ros-args --params-file <file_name>
#We should Stop our running turtlesim node, and try reloading it with saved parameters, using:
ros2 run turtlesim turtlesim_node --ros-args --params-file turtlesim.yaml

