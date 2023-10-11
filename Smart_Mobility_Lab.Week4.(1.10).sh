#Recording and playing back data
#Setup
#We’ll be recording our keyboard input in the turtlesim system to save and replay later on, so we will begin by starting up the /turtlesim and /teleop_turtle nodes.
#From new terminal:
ros2 run turtlesim turtlesim_node
#In an another terminal:
ros2 run turtlesim turtle_teleop_key
#Let’s also make a new directory to store our saved recordings, just as good practice:
mkdir bag_files
cd bag_files

#2 Choose a topic
#ros2 bag can only record data from published messages in topics. To see the list of our system’s topics, we should open a new terminal and run the command:
ros2 topic list
#Which will return:
/parameter_events
/rosout
/turtle1/cmd_vel
/turtle1/color_sensor
/turtle1/pose
#To see the data that /turtle1/cmd_vel is publishing, run the command:
ros2 topic echo /turtle1/cmd_vel
#Nothing will show up at first because no data is being published by the teleop. we should return to the terminal where we ran the teleop and select it so it’s active. Using the arrow keys we will move the turtle around, and we will see data being published on the terminal running ros2 topic echo:
linear:
  x: 2.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0
  ---
  
#3 ros2 bag record
#To record the data published to a topic we use the command syntax:
ros2 bag record <topic_name>
#Before running this command on our chosen topic, we should open a new terminal and move into the bag_files directory which we created earlier, because the rosbag file will save in the directory where we run it.
ros2 bag record /turtle1/cmd_vel
#there should be the following messages in the terminal (the date and time will be different):
[INFO] [rosbag2_storage]: Opened database 'rosbag2_2019_10_11-05_18_45'.
[INFO] [rosbag2_transport]: Listening for topics...
[INFO] [rosbag2_transport]: Subscribed to topic '/turtle1/cmd_vel'
[INFO] [rosbag2_transport]: All requested topics are subscribed. Stopping discovery...

#3.1 Record multiple topics
ros2 bag record -o subset /turtle1/cmd_vel /turtle1/pose
#The -o option allows us to choose a unique name for our bag file. The following string, in this case subset, is the file name.
#To record more than one topic at a time, we will list each topic separated by a space.
#We will see the following message, confirming that both topics are being recorded.
[INFO] [rosbag2_storage]: Opened database 'subset'.
[INFO] [rosbag2_transport]: Listening for topics...
[INFO] [rosbag2_transport]: Subscribed to topic '/turtle1/cmd_vel'
[INFO] [rosbag2_transport]: Subscribed to topic '/turtle1/pose'
[INFO] [rosbag2_transport]: All requested topics are subscribed. Stopping discovery...

#4 ros2 bag info
#We can see details about our recording by running:
ros2 bag info <bag_file_name>
#Running this command on the subset bag file will return a list of information on the file:
ros2 bag info subset
Files:             subset.db3
Bag size:          228.5 KiB
Storage id:        sqlite3
Duration:          48.47s
Start:             Oct 11 2019 06:09:09.12 (1570799349.12)
End                Oct 11 2019 06:09:57.60 (1570799397.60)
Messages:          3013
Topic information: Topic: /turtle1/cmd_vel | Type: geometry_msgs/msg/Twist | Count: 9 | Serialization Format: cdr
                 Topic: /turtle1/pose | Type: turtlesim/msg/Pose | Count: 3004 | Serialization Format: cdr

#5 ros2 bag play
ros2 bag play subset
#The terminal will return the message:
[INFO] [rosbag2_storage]: Opened database 'subset'.
#our turtle will follow the same path we entered while recording
#To get an idea of how often position data is published, we can run the command:
ros2 topic hz /turtle1/pose
