#We will start our project from importing necessary packages.
import rclpy
from rclpy.action import ActionClient

from your_package.action import PickAndPlace

def main():
    rclpy.init()
    node = rclpy.create_node('pick_and_place_client')
    client = ActionClient(node, PickAndPlace, 'pick_and_place')
#Now above code serves as client section for receiving orders
    goal_msg = PickAndPlace.Goal()
    goal_msg.pickup_pose.pose.position.x = 1.0
    goal_msg.pickup_pose.pose.position.y = 2.0
    # Setting other pose parameters...
#We set necessary actions for our robot to execute.
    future = client.send_goal_async(goal_msg)
#With this veriable we can set certain goals to our robot and see the results
    rclpy.spin_until_future_complete(node, future)

    if future.result() is not None:
        result_msg = future.result().result
        if result_msg.success:
            print("Pick and place operation succeeded!")
        else:
            print(f"Pick and place operation failed: {result_msg.message}")
#With these boolean operator we will either witness a good or bad result of the action of our robot
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

