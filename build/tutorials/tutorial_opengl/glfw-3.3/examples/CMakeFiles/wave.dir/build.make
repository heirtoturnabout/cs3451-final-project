# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.28.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.28.1/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/nickunger/Documents/cs3451-final-project

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/nickunger/Documents/cs3451-final-project/build

# Include any dependencies generated for this target.
include tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/compiler_depend.make

# Include the progress variables for this target.
include tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/progress.make

# Include the compile flags for this target's objects.
include tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/flags.make

tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/Resources/glfw.icns: /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/glfw.icns
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Copying OS X content tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/Resources/glfw.icns"
	$(CMAKE_COMMAND) -E copy /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/glfw.icns tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/Resources/glfw.icns

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/flags.make
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o: /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/wave.c
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nickunger/Documents/cs3451-final-project/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o -MF CMakeFiles/wave.dir/wave.c.o.d -o CMakeFiles/wave.dir/wave.c.o -c /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/wave.c

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/wave.dir/wave.c.i"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/wave.c > CMakeFiles/wave.dir/wave.c.i

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/wave.dir/wave.c.s"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples/wave.c -o CMakeFiles/wave.dir/wave.c.s

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/flags.make
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o: /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/deps/glad_gl.c
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nickunger/Documents/cs3451-final-project/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o -MF CMakeFiles/wave.dir/__/deps/glad_gl.c.o.d -o CMakeFiles/wave.dir/__/deps/glad_gl.c.o -c /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/deps/glad_gl.c

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/wave.dir/__/deps/glad_gl.c.i"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/deps/glad_gl.c > CMakeFiles/wave.dir/__/deps/glad_gl.c.i

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/wave.dir/__/deps/glad_gl.c.s"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/deps/glad_gl.c -o CMakeFiles/wave.dir/__/deps/glad_gl.c.s

# Object files for target wave
wave_OBJECTS = \
"CMakeFiles/wave.dir/wave.c.o" \
"CMakeFiles/wave.dir/__/deps/glad_gl.c.o"

# External object files for target wave
wave_EXTERNAL_OBJECTS =

tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/wave.c.o
tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/__/deps/glad_gl.c.o
tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/build.make
tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave: tutorials/tutorial_opengl/glfw-3.3/src/libglfw3.a
tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave: tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/nickunger/Documents/cs3451-final-project/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable wave.app/Contents/MacOS/wave"
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/wave.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/build: tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/MacOS/wave
tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/build: tutorials/tutorial_opengl/glfw-3.3/examples/wave.app/Contents/Resources/glfw.icns
.PHONY : tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/build

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/clean:
	cd /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples && $(CMAKE_COMMAND) -P CMakeFiles/wave.dir/cmake_clean.cmake
.PHONY : tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/clean

tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/depend:
	cd /Users/nickunger/Documents/cs3451-final-project/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/nickunger/Documents/cs3451-final-project /Users/nickunger/Documents/cs3451-final-project/tutorials/tutorial_opengl/glfw-3.3/examples /Users/nickunger/Documents/cs3451-final-project/build /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples /Users/nickunger/Documents/cs3451-final-project/build/tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tutorials/tutorial_opengl/glfw-3.3/examples/CMakeFiles/wave.dir/depend
