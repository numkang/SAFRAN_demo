cmake_minimum_required(VERSION 3.5)
set (CMAKE_CXX_STANDARD 11)
project(REDEFINE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
#from minisat top level
add_definitions(-D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS)
#add_definitions(-Wall -Wno-parentheses)
#add_definitions(-Wall -Werror)
add_definitions(-Wall)
add_definitions(-DMINISAT_CONSTANTS_AS_MACROS)
include_directories(${CMAKE_SOURCE_DIR}/minisat
			${CMAKE_SOURCE_DIR}/minisatp
			${CMAKE_SOURCE_DIR}/minisatp/ADTs
			${CMAKE_SOURCE_DIR}/utils
			${CMAKE_SOURCE_DIR})
add_executable(allocator main.cpp
			 SAT_fc.cpp
			 algos.cpp)
add_subdirectory(utils)
add_subdirectory(minisat)
add_subdirectory(minisatp)
target_link_libraries(allocator 
			utils 
			minisat 
			minisatp 
			-lgmp)
