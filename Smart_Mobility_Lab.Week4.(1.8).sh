#Using rqt_console to view logs
#1 Setup
#we start rqt_console in a new terminal with the following command:
ros2 run rqt_console rqt_console
#In a new terminal we start turtlesim with the following command:
ros2 run turtlesim turtlesim_node

#2 Messages on rqt_console
#To produce log messages for rqt_console to display, let’s have the turtle run into the wall. In a new terminal, we will enter the ros2 topic pub command below:
ros2 topic pub -r 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0,y: 0.0,z: 0.0}}"
#Since the above command is publishing the topic at a steady rate, the turtle is continuously running into the wall. 
#In rqt_console we will see the same message with the Warn severity level displayed over and over

#3 Logger levels
#ROS 2’s logger levels are ordered by severity:
Fatal
Error
Warn
Info
Debug

#3.1 Set the default logger level
#We can set the default logger level when we first run the /turtlesim node using remapping:
ros2 run turtlesim turtlesim_node --ros-args --log-level WARN
#Now there is no initial Info level messages that came up in the console last time we started turtlesim. That’s because Info messages are lower priority than the new default severity, Warn.
