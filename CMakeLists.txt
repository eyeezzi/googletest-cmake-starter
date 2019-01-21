cmake_minimum_required(VERSION 3.13)
project(myapp)

set(CMAKE_CXX_STANDARD 11)

add_subdirectory(external)
add_subdirectory(src)

enable_testing()
add_subdirectory(test)

