#Using Turtlesim
sudo apt update
sudo apt install ros-humble-turtlesim

ros2 pkg executables turtlesim
#This is the result of above command
turtlesim draw_square
turtlesim mimic
turtlesim turtle_teleop_key
turtlesim turtlesim_node

#After below code a pop-up screen should appear with turtle
ros2 run turtlesim turtlesim_node
#In the terminal you will see 
#[INFO] [turtlesim]: Starting turtlesim with node name /turtlesim
#[INFO] [turtlesim]: Spawning turtle [turtle1] at x=[5.544445], y=[5.544445], theta=[0.000000]

ros2 run turtlesim turtle_teleop_key
#Through above mentioned code you can control the turtle on the screen

#Now you will see the actions for the details of each turtle 
