#Action: PickAndPlace Action
#Interaction Diagram:
#PickAndPlace Action Interaction Diagram:
  +------------------+     +--------------------+
  |   Action Client |     |    Action Server   |
  +------------------+     +--------------------+
         |                         |
         |                         |
         |                         |
         |       Goal (Request)     |
         |  (pickup_pose, placement_pose) |
         |------------------------->|
         |                         |
         |                         |
         |                         |
         |    Feedback (Optional)   |
         |  (current status/progress)|
         |<------------------------|
         |                         |
         |                         |
         |                         |
         |   Result (Response)     |
         | (success, message)       |
         |<------------------------|
         |                         |

#Description of request: 
 #The PickAndPlace action is specifically designed for robot manipulation tasks, where the robot must pick up an object from one location and place it in another location. This action proves to be particularly useful in scenarios such as warehouse automation, where a robot is tasked with picking items from a shelf and placing them into a bin.
#Action Definition (pick_and_place.action):
 # pick_and_place.action
geometry_msgs/PoseStamped pickup_pose
geometry_msgs/PoseStamped placement_pose
---
bool success
string message

#When performing this action, the robot assigns two postures: pickup_pose,  represents the position from which the object will be picked up, and position_pose, indicates the desired position to place the object. Upon completion of the action, the action server provides a response in the form of a boolean value, indicating whether the operation was successful or not, along with a message string that may contain additional information or error messages.

import rclpy
from rclpy.action import ActionClient

from your_package.action import PickAndPlace

def main():
    rclpy.init()
    node = rclpy.create_node('pick_and_place_client')
    client = ActionClient(node, PickAndPlace, 'pick_and_place')

    goal_msg = PickAndPlace.Goal()
    goal_msg.pickup_pose.pose.position.x = 1.0
    goal_msg.pickup_pose.pose.position.y = 2.0
    # Set other pose parameters...

    future = client.send_goal_async(goal_msg)

    rclpy.spin_until_future_complete(node, future)

    if future.result() is not None:
        result_msg = future.result().result
        if result_msg.success:
            print("Pick and place operation succeeded!")
        else:
            print(f"Pick and place operation failed: {result_msg.message}")

    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
#Comments: The PickAndPlace action enables the robot to specify both the pickup and placement poses.
#An Action Client sends a goal to the PickAndPlace action server.
#The action server carries out the pick-and-place operation and responds with either a success or failure.
