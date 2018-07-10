add_library(utils 
	create_func.cpp 
	get_func.cpp 
	Matrix.cpp
	#stream_server.cpp
	#stream_client.cpp
	#broadcast.cpp
	#receive_broadcast.cpp
	)

#target_include_directories(utils PUBLIC
#    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#    $<INSTALL_INTERFACE:include>
#    PRIVATE src)
