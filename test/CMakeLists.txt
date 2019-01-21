set(TEST_BUNDLE ${PROJECT_NAME}_test)

file(GLOB SOURCES *.cpp)

# Compile all source files in this folder into one target--test bundle
add_executable(${TEST_BUNDLE} ${SOURCES})

# Specify which targets the test bundle depends on
target_link_libraries(${TEST_BUNDLE} ${APP_BUNDLE} libgtest)

# Register tests
add_test(NAME ${TEST_BUNDLE}
        COMMAND ${TEST_BUNDLE})