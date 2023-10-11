#Understanding Topics
ros2 run turtlesim turtlesim_node
ros2 run turtlesim turtle_teleop_key
#We opened our turtle

rqt_graph	
#To see the data being published on a topic, use:
ros2 topic echo <topic_name>
#This will show the movements of the turtle
ros2 topic echo /turtle1/cmd_vel
#These are example movements which results after each move
linear:
  x: 2.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0

#Topics don’t have to only be one-to-one communication; they can be one-to-many, many-to-one, or many-to-many.
ros2 topic info /turtle1/cmd_vel
#Which will give the below result
Type: geometry_msgs/msg/Twist
Publisher count: 1
Subscription count: 2

geometry_msgs/msg/Twist
#This means that in the package geometry_msgs there is a msg called Twist.
#Now we can run ros2 interface show <msg type> on this type to learn its details. Specifically, what structure of data the message expects.
ros2 interface show geometry_msgs/msg/Twist
#This expresses velocity in free space broken into its linear and angular parts.

    Vector3  linear
            float64 x
            float64 y
            float64 z
    Vector3  angular
            float64 x
            float64 y
            float64 z
            
#Now that we have the message structure, we can publish data onto a topic directly from the command line using:
ros2 topic pub <topic_name> <msg_type> '<args>'
#It’s important to note that this argument needs to be input in YAML syntax. Input the full command like so:
ros2 topic pub --once /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}"
#We will have the following output in the terminal:
publisher: beginning loop
publishing #1: geometry_msgs.msg.Twist(linear=geometry_msgs.msg.Vector3(x=2.0, y=0.0, z=0.0), angular=geometry_msgs.msg.Vector3(x=0.0, y=0.0, z=1.8))
#The turtle require a steady stream of commands to operate continuously. So, to get the turtle to keep moving, we should run:
ros2 topic pub --rate 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}"
#We can run echo on the pose topic and recheck rqt_graph:
ros2 topic echo /turtle1/pose

#For one last introspection on this process, we can view the rate of the publishing data:
ros2 topic hz /turtle1/pose
#And it returns:
average rate: 59.354
  min: 0.005s max: 0.027s std dev: 0.00284s window: 58

