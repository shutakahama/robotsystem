//ROSからOpencv操作　Cannyフィルタ
#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/features2d/features2d.hpp"

class MyCvPkg
{
  image_transport::Subscriber img_sub_;
  image_transport::ImageTransport it_;

  void imageCallback(const sensor_msgs::ImageConstPtr &msg) {
    ROS_INFO("Received image");
    cv::Mat in_img = cv_bridge::toCvCopy(msg, msg->encoding)->image;

    cv::Mat s_img = in_img.clone();
    //Sobel filter
    /*
    cv::Mat tmp_img;
    cv::Mat sobel_img;
    cv::Sobel(s_img, tmp_img, CV_32F, 1, 1);
    convertScaleAbs(tmp_img, sobel_img, 1, 0);
    cv::imshow("Sobel", sobel_img);
    */

    //Canny filter
    cv::Mat canny_img;
    cv::Canny(s_img, canny_img, 50, 200);
    cv::imshow("Canny", canny_img);
    cv::waitKey(1);

  }

public:
  MyCvPkg(ros::NodeHandle nh = ros::NodeHandle()) : it_(nh)
  {
    img_sub_ = it_.subscribe("image", 3, &MyCvPkg::imageCallback, this);
    cv::namedWindow("Fast", 1);
  }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "my_cv_pkg_node");
  MyCvPkg mcp;
  ros::spin();
}

