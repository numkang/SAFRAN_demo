# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pi/Documents/REDEFINE_project/cpp_code

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/Documents/REDEFINE_project/cpp_code/cmake

# Include any dependencies generated for this target.
include utils/CMakeFiles/utils.dir/depend.make

# Include the progress variables for this target.
include utils/CMakeFiles/utils.dir/progress.make

# Include the compile flags for this target's objects.
include utils/CMakeFiles/utils.dir/flags.make

utils/CMakeFiles/utils.dir/create_func.cpp.o: utils/CMakeFiles/utils.dir/flags.make
utils/CMakeFiles/utils.dir/create_func.cpp.o: ../utils/create_func.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/REDEFINE_project/cpp_code/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object utils/CMakeFiles/utils.dir/create_func.cpp.o"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/utils.dir/create_func.cpp.o -c /home/pi/Documents/REDEFINE_project/cpp_code/utils/create_func.cpp

utils/CMakeFiles/utils.dir/create_func.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/utils.dir/create_func.cpp.i"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/REDEFINE_project/cpp_code/utils/create_func.cpp > CMakeFiles/utils.dir/create_func.cpp.i

utils/CMakeFiles/utils.dir/create_func.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/utils.dir/create_func.cpp.s"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/REDEFINE_project/cpp_code/utils/create_func.cpp -o CMakeFiles/utils.dir/create_func.cpp.s

utils/CMakeFiles/utils.dir/create_func.cpp.o.requires:

.PHONY : utils/CMakeFiles/utils.dir/create_func.cpp.o.requires

utils/CMakeFiles/utils.dir/create_func.cpp.o.provides: utils/CMakeFiles/utils.dir/create_func.cpp.o.requires
	$(MAKE) -f utils/CMakeFiles/utils.dir/build.make utils/CMakeFiles/utils.dir/create_func.cpp.o.provides.build
.PHONY : utils/CMakeFiles/utils.dir/create_func.cpp.o.provides

utils/CMakeFiles/utils.dir/create_func.cpp.o.provides.build: utils/CMakeFiles/utils.dir/create_func.cpp.o


utils/CMakeFiles/utils.dir/get_func.cpp.o: utils/CMakeFiles/utils.dir/flags.make
utils/CMakeFiles/utils.dir/get_func.cpp.o: ../utils/get_func.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/REDEFINE_project/cpp_code/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object utils/CMakeFiles/utils.dir/get_func.cpp.o"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/utils.dir/get_func.cpp.o -c /home/pi/Documents/REDEFINE_project/cpp_code/utils/get_func.cpp

utils/CMakeFiles/utils.dir/get_func.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/utils.dir/get_func.cpp.i"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/REDEFINE_project/cpp_code/utils/get_func.cpp > CMakeFiles/utils.dir/get_func.cpp.i

utils/CMakeFiles/utils.dir/get_func.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/utils.dir/get_func.cpp.s"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/REDEFINE_project/cpp_code/utils/get_func.cpp -o CMakeFiles/utils.dir/get_func.cpp.s

utils/CMakeFiles/utils.dir/get_func.cpp.o.requires:

.PHONY : utils/CMakeFiles/utils.dir/get_func.cpp.o.requires

utils/CMakeFiles/utils.dir/get_func.cpp.o.provides: utils/CMakeFiles/utils.dir/get_func.cpp.o.requires
	$(MAKE) -f utils/CMakeFiles/utils.dir/build.make utils/CMakeFiles/utils.dir/get_func.cpp.o.provides.build
.PHONY : utils/CMakeFiles/utils.dir/get_func.cpp.o.provides

utils/CMakeFiles/utils.dir/get_func.cpp.o.provides.build: utils/CMakeFiles/utils.dir/get_func.cpp.o


utils/CMakeFiles/utils.dir/Matrix.cpp.o: utils/CMakeFiles/utils.dir/flags.make
utils/CMakeFiles/utils.dir/Matrix.cpp.o: ../utils/Matrix.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/REDEFINE_project/cpp_code/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object utils/CMakeFiles/utils.dir/Matrix.cpp.o"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/utils.dir/Matrix.cpp.o -c /home/pi/Documents/REDEFINE_project/cpp_code/utils/Matrix.cpp

utils/CMakeFiles/utils.dir/Matrix.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/utils.dir/Matrix.cpp.i"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/REDEFINE_project/cpp_code/utils/Matrix.cpp > CMakeFiles/utils.dir/Matrix.cpp.i

utils/CMakeFiles/utils.dir/Matrix.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/utils.dir/Matrix.cpp.s"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/REDEFINE_project/cpp_code/utils/Matrix.cpp -o CMakeFiles/utils.dir/Matrix.cpp.s

utils/CMakeFiles/utils.dir/Matrix.cpp.o.requires:

.PHONY : utils/CMakeFiles/utils.dir/Matrix.cpp.o.requires

utils/CMakeFiles/utils.dir/Matrix.cpp.o.provides: utils/CMakeFiles/utils.dir/Matrix.cpp.o.requires
	$(MAKE) -f utils/CMakeFiles/utils.dir/build.make utils/CMakeFiles/utils.dir/Matrix.cpp.o.provides.build
.PHONY : utils/CMakeFiles/utils.dir/Matrix.cpp.o.provides

utils/CMakeFiles/utils.dir/Matrix.cpp.o.provides.build: utils/CMakeFiles/utils.dir/Matrix.cpp.o


# Object files for target utils
utils_OBJECTS = \
"CMakeFiles/utils.dir/create_func.cpp.o" \
"CMakeFiles/utils.dir/get_func.cpp.o" \
"CMakeFiles/utils.dir/Matrix.cpp.o"

# External object files for target utils
utils_EXTERNAL_OBJECTS =

utils/libutils.a: utils/CMakeFiles/utils.dir/create_func.cpp.o
utils/libutils.a: utils/CMakeFiles/utils.dir/get_func.cpp.o
utils/libutils.a: utils/CMakeFiles/utils.dir/Matrix.cpp.o
utils/libutils.a: utils/CMakeFiles/utils.dir/build.make
utils/libutils.a: utils/CMakeFiles/utils.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/Documents/REDEFINE_project/cpp_code/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library libutils.a"
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && $(CMAKE_COMMAND) -P CMakeFiles/utils.dir/cmake_clean_target.cmake
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/utils.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
utils/CMakeFiles/utils.dir/build: utils/libutils.a

.PHONY : utils/CMakeFiles/utils.dir/build

utils/CMakeFiles/utils.dir/requires: utils/CMakeFiles/utils.dir/create_func.cpp.o.requires
utils/CMakeFiles/utils.dir/requires: utils/CMakeFiles/utils.dir/get_func.cpp.o.requires
utils/CMakeFiles/utils.dir/requires: utils/CMakeFiles/utils.dir/Matrix.cpp.o.requires

.PHONY : utils/CMakeFiles/utils.dir/requires

utils/CMakeFiles/utils.dir/clean:
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils && $(CMAKE_COMMAND) -P CMakeFiles/utils.dir/cmake_clean.cmake
.PHONY : utils/CMakeFiles/utils.dir/clean

utils/CMakeFiles/utils.dir/depend:
	cd /home/pi/Documents/REDEFINE_project/cpp_code/cmake && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/Documents/REDEFINE_project/cpp_code /home/pi/Documents/REDEFINE_project/cpp_code/utils /home/pi/Documents/REDEFINE_project/cpp_code/cmake /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils /home/pi/Documents/REDEFINE_project/cpp_code/cmake/utils/CMakeFiles/utils.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : utils/CMakeFiles/utils.dir/depend

