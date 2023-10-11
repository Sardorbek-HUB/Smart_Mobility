#Understanding actions
#1 Setup
#We Start running the two turtlesim nodes, /turtlesim and /teleop_turtle in different terminals.
ros2 run turtlesim turtlesim_node
ros2 run turtlesim turtle_teleop_key

#2 Use actions
#When we launch the /teleop_turtle node, we can see the following message in our terminal:
Use arrow keys to move the turtle.
Use G|B|V|C|D|E|R|T keys to rotate to absolute orientations. 'F' to cancel a rotation.
#If we pay attention we notice that the letter keys G|B|V|C|D|E|R|T form a “box” around the F key on a US QWERTY keyboard. Each key’s position around F corresponds to that orientation in turtlesim. For example, the E will rotate the turtle’s orientation to the upper left corner.
#The F key will cancel a goal mid-execution.
#If we press the C key, and then pressing the F key before the turtle can complete its rotation. In the terminal where the /turtlesim node is running, we will see the message:
[INFO] [turtlesim]: Rotation goal canceled
#Not only can the client-side stop a goal, but the server-side can as well. When the server-side chooses to stop processing a goal, it is said to “abort” the goal.
#If we try hitting the D key, then the G key before the first rotation can complete. In the terminal where the /turtlesim node is running, we will see the message:
[WARN] [turtlesim]: Rotation goal received before a previous goal finished. Aborting previous goal

#3 ros2 node info
#To see the list of actions a node provides, /turtlesim in this case, we should open a new terminal and run the command:
ros2 node info /turtlesim
Which will return a list of /turtlesim’s subscribers, publishers, services, action servers and action clients:
/turtlesim
  Subscribers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
    /turtle1/cmd_vel: geometry_msgs/msg/Twist
  Publishers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
    /rosout: rcl_interfaces/msg/Log
    /turtle1/color_sensor: turtlesim/msg/Color
    /turtle1/pose: turtlesim/msg/Pose
  Service Servers:
    /clear: std_srvs/srv/Empty
    /kill: turtlesim/srv/Kill
    /reset: std_srvs/srv/Empty
    /spawn: turtlesim/srv/Spawn
    /turtle1/set_pen: turtlesim/srv/SetPen
    /turtle1/teleport_absolute: turtlesim/srv/TeleportAbsolute
    /turtle1/teleport_relative: turtlesim/srv/TeleportRelative
    /turtlesim/describe_parameters: rcl_interfaces/srv/DescribeParameters
    /turtlesim/get_parameter_types: rcl_interfaces/srv/GetParameterTypes
    /turtlesim/get_parameters: rcl_interfaces/srv/GetParameters
    /turtlesim/list_parameters: rcl_interfaces/srv/ListParameters
    /turtlesim/set_parameters: rcl_interfaces/srv/SetParameters
    /turtlesim/set_parameters_atomically: rcl_interfaces/srv/SetParametersAtomically
  Service Clients:

  Action Servers:
    /turtle1/rotate_absolute: turtlesim/action/RotateAbsolute
  Action Clients:
#If we pay attention we will notice that the /turtle1/rotate_absolute action for /turtlesim is under Action Servers. This means /turtlesim responds to and provides feedback for the /turtle1/rotate_absolute action.
#The /teleop_turtle node has the name /turtle1/rotate_absolute under Action Clients meaning that it sends goals for that action name. To see that, we should run:
ros2 node info /teleop_turtle
#Which will return:
/teleop_turtle
  Subscribers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
  Publishers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
    /rosout: rcl_interfaces/msg/Log
    /turtle1/cmd_vel: geometry_msgs/msg/Twist
  Service Servers:
    /teleop_turtle/describe_parameters: rcl_interfaces/srv/DescribeParameters
    /teleop_turtle/get_parameter_types: rcl_interfaces/srv/GetParameterTypes
    /teleop_turtle/get_parameters: rcl_interfaces/srv/GetParameters
    /teleop_turtle/list_parameters: rcl_interfaces/srv/ListParameters
    /teleop_turtle/set_parameters: rcl_interfaces/srv/SetParameters
    /teleop_turtle/set_parameters_atomically: rcl_interfaces/srv/SetParametersAtomically
  Service Clients:

  Action Servers:

  Action Clients:
    /turtle1/rotate_absolute: turtlesim/action/RotateAbsolute
#4 ros2 action list
#To identify all the actions in the ROS graph, we should run the command:
ros2 action list
#Which will return:
/turtle1/rotate_absolute

#4.1 ros2 action list -t
#Actions have types, similar to topics and services. To find /turtle1/rotate_absolute’s type, run the command:
ros2 action list -t
#Which will return:
/turtle1/rotate_absolute [turtlesim/action/RotateAbsolute]

#5 ros2 action info
#We can further introspect the /turtle1/rotate_absolute action with the command:
ros2 action info /turtle1/rotate_absolute
#Which will return
Action: /turtle1/rotate_absolute
Action clients: 1
    /teleop_turtle
Action servers: 1
    /turtlesim

#6 ros2 interface show
#Now we will examine the absolute number of rotated turtle
ros2 interface show turtlesim/action/RotateAbsolute
# The desired heading in radians
float32 theta
---
# The angular displacement in radians to the starting position
float32 delta
---
# The remaining rotation in radians
float32 remaining
#The first is the structure (data type and name) of the goal request
#The next section is the structure of the result. 
#The last section is the structure of the feedback.

#7 ros2 action send_goal
#Now let’s send an action goal from the command line with the following syntax:
ros2 action send_goal <action_name> <action_type> <values>
#We should pay attention on the turtlesim window, and enter the following command into our terminal:
ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: 1.57}"
#There Should be the turtle rotating, as well as the following message in the terminal:
Waiting for an action server to become available...
Sending goal:
   theta: 1.57

Goal accepted with ID: f8db8f44410849eaa93d3feb747dd444

Result:
  delta: -1.568000316619873

Goal finished with status: SUCCEEDED
#To see the feedback of this goal, we need to add --feedback to the ros2 action send_goal command:
ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: -1.57}" --feedback
#our terminal will return the message:
Sending goal:
   theta: -1.57

Goal accepted with ID: e6092c831f994afda92f0086f220da27

Feedback:
  remaining: -3.1268222332000732

Feedback:
  remaining: -3.1108222007751465

…

Result:
  delta: 3.1200008392333984

Goal finished with status: SUCCEEDED
# We will continue to receive feedback, the remaining radians, until the goal is complete.
