### Overview
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
        ┌─────────┴────────┐                         ┌─────────┴────────┐       
        │                  │                         │                  │       
┌──────────────┐   ┌──────────────┐           ┌─────────────┐    ┌─────────────┐
│              │   │              │           │             │    │             │
│  GoogleMock  │   │  GoogleTest  │           │  file1.cpp  │    │  fileN.cpp  │
│              │   │              │           │             │    │             │
└──────────────┘   └──────────────┘           └─────────────┘    └─────────────┘
```

### Understanding CMakeLists.txt directives

##### enable_testing()
Sets the flag CMAKE_TESTING_ENABLED, which activates additional processing required to register unit tests with ctest, for this and all subdirectories.

You can then add tests by calling add_test() in the CMakeLists.txt file in this or any subdir.

##### add_subdirectory()
Adds a subdirectory to the build. On encountering this command, CMake halts and evaluates the CMakeLists.txt file in that subdirectory before continuing.

add_executable(<name> source1 source2 ...)
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