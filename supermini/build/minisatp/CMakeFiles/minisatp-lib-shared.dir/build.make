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
CMAKE_SOURCE_DIR = /home/pi/Documents/supermini

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/Documents/supermini/build

# Include any dependencies generated for this target.
include minisatp/CMakeFiles/minisatp-lib-shared.dir/depend.make

# Include the progress variables for this target.
include minisatp/CMakeFiles/minisatp-lib-shared.dir/progress.make

# Include the compile flags for this target's objects.
include minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o: ../minisatp/ADTs/FEnv.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o -c /home/pi/Documents/supermini/minisatp/ADTs/FEnv.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/ADTs/FEnv.cc > CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/ADTs/FEnv.cc -o CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o: ../minisatp/ADTs/File.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o -c /home/pi/Documents/supermini/minisatp/ADTs/File.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/ADTs/File.cc > CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/ADTs/File.cc -o CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o: ../minisatp/ADTs/Global.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o -c /home/pi/Documents/supermini/minisatp/ADTs/Global.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/ADTs/Global.cc > CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/ADTs/Global.cc -o CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o: ../minisatp/Debug.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o -c /home/pi/Documents/supermini/minisatp/Debug.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/Debug.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/Debug.cc > CMakeFiles/minisatp-lib-shared.dir/Debug.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/Debug.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/Debug.cc -o CMakeFiles/minisatp-lib-shared.dir/Debug.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o: ../minisatp/Hardware_adders.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o -c /home/pi/Documents/supermini/minisatp/Hardware_adders.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/Hardware_adders.cc > CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/Hardware_adders.cc -o CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o: ../minisatp/Hardware_clausify.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o -c /home/pi/Documents/supermini/minisatp/Hardware_clausify.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/Hardware_clausify.cc > CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/Hardware_clausify.cc -o CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o: ../minisatp/Hardware_sorters.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o -c /home/pi/Documents/supermini/minisatp/Hardware_sorters.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/Hardware_sorters.cc > CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/Hardware_sorters.cc -o CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o: ../minisatp/Main.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/Main.cc.o -c /home/pi/Documents/supermini/minisatp/Main.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/Main.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/Main.cc > CMakeFiles/minisatp-lib-shared.dir/Main.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/Main.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/Main.cc -o CMakeFiles/minisatp-lib-shared.dir/Main.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o: ../minisatp/PbParser.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o -c /home/pi/Documents/supermini/minisatp/PbParser.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbParser.cc > CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbParser.cc -o CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o: ../minisatp/PbSolver.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o -c /home/pi/Documents/supermini/minisatp/PbSolver.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbSolver.cc > CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbSolver.cc -o CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o: ../minisatp/PbSolver_convert.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o -c /home/pi/Documents/supermini/minisatp/PbSolver_convert.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbSolver_convert.cc > CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbSolver_convert.cc -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o: ../minisatp/PbSolver_convertAdd.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o -c /home/pi/Documents/supermini/minisatp/PbSolver_convertAdd.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbSolver_convertAdd.cc > CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbSolver_convertAdd.cc -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o: ../minisatp/PbSolver_convertBdd.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o -c /home/pi/Documents/supermini/minisatp/PbSolver_convertBdd.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbSolver_convertBdd.cc > CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbSolver_convertBdd.cc -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o


minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o: minisatp/CMakeFiles/minisatp-lib-shared.dir/flags.make
minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o: ../minisatp/PbSolver_convertSort.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Building CXX object minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o -c /home/pi/Documents/supermini/minisatp/PbSolver_convertSort.cc

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.i"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/Documents/supermini/minisatp/PbSolver_convertSort.cc > CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.i

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.s"
	cd /home/pi/Documents/supermini/build/minisatp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/Documents/supermini/minisatp/PbSolver_convertSort.cc -o CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.s

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.requires:

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.provides: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.requires
	$(MAKE) -f minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.provides.build
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.provides

minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.provides.build: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o


# Object files for target minisatp-lib-shared
minisatp__lib__shared_OBJECTS = \
"CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/Main.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o" \
"CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o"

# External object files for target minisatp-lib-shared
minisatp__lib__shared_EXTERNAL_OBJECTS =

minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/build.make
minisatp/libminisatp.so.1.1.0: minisat/libminisat.so.2.1.0
minisatp/libminisatp.so.1.1.0: /usr/lib/arm-linux-gnueabihf/libgmp.so
minisatp/libminisatp.so.1.1.0: /usr/lib/arm-linux-gnueabihf/libz.so
minisatp/libminisatp.so.1.1.0: minisatp/CMakeFiles/minisatp-lib-shared.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/Documents/supermini/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_15) "Linking CXX shared library libminisatp.so"
	cd /home/pi/Documents/supermini/build/minisatp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/minisatp-lib-shared.dir/link.txt --verbose=$(VERBOSE)
	cd /home/pi/Documents/supermini/build/minisatp && $(CMAKE_COMMAND) -E cmake_symlink_library libminisatp.so.1.1.0 libminisatp.so.1 libminisatp.so

minisatp/libminisatp.so.1: minisatp/libminisatp.so.1.1.0
	@$(CMAKE_COMMAND) -E touch_nocreate minisatp/libminisatp.so.1

minisatp/libminisatp.so: minisatp/libminisatp.so.1.1.0
	@$(CMAKE_COMMAND) -E touch_nocreate minisatp/libminisatp.so

# Rule to build all files generated by this target.
minisatp/CMakeFiles/minisatp-lib-shared.dir/build: minisatp/libminisatp.so

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/build

minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/FEnv.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/File.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/ADTs/Global.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/Debug.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_adders.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_clausify.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/Hardware_sorters.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/Main.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbParser.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convert.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertAdd.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertBdd.cc.o.requires
minisatp/CMakeFiles/minisatp-lib-shared.dir/requires: minisatp/CMakeFiles/minisatp-lib-shared.dir/PbSolver_convertSort.cc.o.requires

.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/requires

minisatp/CMakeFiles/minisatp-lib-shared.dir/clean:
	cd /home/pi/Documents/supermini/build/minisatp && $(CMAKE_COMMAND) -P CMakeFiles/minisatp-lib-shared.dir/cmake_clean.cmake
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/clean

minisatp/CMakeFiles/minisatp-lib-shared.dir/depend:
	cd /home/pi/Documents/supermini/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/Documents/supermini /home/pi/Documents/supermini/minisatp /home/pi/Documents/supermini/build /home/pi/Documents/supermini/build/minisatp /home/pi/Documents/supermini/build/minisatp/CMakeFiles/minisatp-lib-shared.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : minisatp/CMakeFiles/minisatp-lib-shared.dir/depend

