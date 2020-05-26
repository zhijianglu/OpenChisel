cmake_minimum_required(VERSION 2.8.3)

find_package(catkin REQUIRED COMPONENTS roscpp std_msgs sensor_msgs nav_msgs geometry_msgs tf open_chisel pcl_ros chisel_msgs)

find_package(cmake_modules REQUIRED)
find_package(Eigen REQUIRED)
find_package(PCL 1.8 REQUIRED)
include_directories(${Eigen_INCLUDE_DIRS})

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++11 -DEIGEN_DONT_PARALLELIZE")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -g")

#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++11 -O3")


generate_messages(DEPENDENCIES std_msgs sensor_msgs geometry_msgs)

catkin_package(CATKIN_DEPENDS roscpp tf std_msgs sensor_msgs nav_msgs open_chisel pcl_ros chisel_msgs
	 	INCLUDE_DIRS include
               	LIBRARIES ${PROJECT_NAME})


include_directories(include ${catkin_INCLUDE_DIRS})

add_library(${PROJECT_NAME} src/ChiselServer.cpp)
target_link_libraries(${PROJECT_NAME} -lbfd ${catkin_LIBRARIES})
add_executable(ChiselNode src/ChiselNode.cpp)
target_link_libraries(ChiselNode -lbfd ${PROJECT_NAME} ${catkin_LIBRARIES})

install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  PATTERN ".git" EXCLUDE
)
