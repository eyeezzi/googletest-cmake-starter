```
   _____               __    __          __    _______  ___     __       
  / ___/__  ___  ___ _/ /__ / /____ ___ / /_  / ___/  |/  /__ _/ /_____  
 / (_ / _ \/ _ \/ _ `/ / -_) __/ -_|_-</ __/ / /__/ /|_/ / _ `/  '_/ -_) 
 \___/\___/\___/\_, /_/\__/\__/\__/___/\__/  \___/_/  /_/\_,_/_/\_\\__/  
               /___/                                                     
                        ______           __                              
                       / __/ /____ _____/ /____ ____                     
                      _\ \/ __/ _ `/ __/ __/ -_) __/                     
                     /___/\__/\_,_/_/  \__/\__/_/                        
                                                                         
```
## Requirements

- Clang >= 3.3 or GCC >= 4.8.1
- CMake >= 3.13

> - Linux users should already have these tools. 
> - MacOS users with _Xcode Developer Tools_ should already have these.
> - Windows users may need to setup _Cygwin_ to install these tools.

## Usage

Clone/download the repo, then open `CMakeLists.txt` in an IDE that supports CMake projects like [CLion](https://www.jetbrains.com/clion/specials/clion/clion.html)

## Overview
```
                         ┌─────────────┐   ┌─────────────┐
                         │             │   │             │
                         │  test1.cpp  │   │  testN.cpp  │
                         │             │   │             │
                         └─────────────┘   └─────────────┘
                                │                 │
                                └───────┬─────────┘
                                        ▼
           ┌────────────┐        ┌─────────────┐       ┌──────────────┐
           │            │        │             │       │              │
           │  Test Lib  │──∞────▶│ Test Bundle │◀──∞───│  App Bundle  │
           │            │        │             │       │              │
           └────────────┘        └─────────────┘       └──────────────┘
                  ▲                                            ▲
        ┌─∞───────┴────∞───┐                         ┌─────────┴────────┐
        │                  │                         │                  │
┌──────────────┐   ┌──────────────┐           ┌─────────────┐    ┌─────────────┐
│              │   │              │           │             │    │             │
│  GoogleMock  │   │  GoogleTest  │           │  file1.cpp  │    │  fileN.cpp  │
│              │   │              │           │             │    │             │
└──────────────┘   └──────────────┘           └─────────────┘    └─────────────┘
```

1. GoogleTest and GoogleMock are distributed as static libraries.
2. We create a container static library (Test Lib) that statically links GoogleTest and GoogleMock
3. All application sources get compiled into an **App Bundle** static library.
4. All test sources get complied into a **Test Bundle** executable.
5. We statically link Test Lib to Test Bundle because the latter depends on the gtest and gmock functionalities in the former.
6. We also statically link App Bundle to Test Bundle, because the former is the payload under test.
7. Finally, building the Test Bundle will build its dependencies (TestLib and App Bundle). Then you simply run the resulting executable.

## Understanding CMakeLists.txt directives

##### enable_testing()
Sets the flag CMAKE_TESTING_ENABLED, which activates additional processing required to register unit tests with ctest, for this and all subdirectories.

You can then add tests by calling add_test() in the CMakeLists.txt file in this or any subdir.

##### add_subdirectory()
Adds a subdirectory to the build. On encountering this command, CMake halts and evaluates the CMakeLists.txt file in that subdirectory before continuing.

##### add_executable(<name> source1 source2 ...)
Adds an executable target called <name> to be build from the listed source files.

##### file(GLOB variable expr)
Stores the list of all the files matching the expr in the variable.

##### add_test(NAME <name> COMMAND <command>)
Add a test to the project to be run by ctest.

You can specify the executable bundling all the tests as the test name.

##### target_link_libraries(<target> lib1 lib2 ...)
Link a target to the listed libraries. The <target> must have been created in the current directory using either add_executable() or add_library()

##### target_include_directories(<target> dir1 dir2 ...)
Specify include directories to use when compiling a given target. The named <target> must have been created by a command such as add_executable() or add_library()

##### add_dependencies(<target> dep1 dep2 ...)
Make <target> depend on all the targets listed as dependencies. The deps will be built before <target>.

##### IMPORTED library target

* An IMPORTED library target references a library file located outside the project. No rules are generated to build it.

The target name has scope in the directory in which it is created and below, but the GLOBAL option extends visibility. It may be referenced like any target built within the project.

## Acknowledgements

This project was inspired by 

- [cookiecutter-cpp](https://github.com/hbristow/cookiecutter-cpp)
- [gtest-cmake-example](https://github.com/kaizouman/gtest-cmake-example)