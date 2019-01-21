find_package(Threads REQUIRED)
include(ExternalProject)

# Fetch GoogleTest remotely and create a target called gtest
ExternalProject_Add(
        gtest
        URL https://github.com/google/googletest/archive/release-1.8.1.zip
        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/gtest
        # Disable INSTALL
        INSTALL_COMMAND ""
)

# Create a proxy library that uses this gtest target
add_library(libgtest IMPORTED STATIC GLOBAL)
add_dependencies(libgtest gtest)

ExternalProject_Get_Property(gtest SOURCE_DIR BINARY_DIR)

# Prevents complaint about non-existent path
file(MAKE_DIRECTORY ${SOURCE_DIR}/googletest/include)

set_target_properties(libgtest PROPERTIES
        # statically link the googletest static library to our proxy library
        "IMPORTED_LOCATION" "${BINARY_DIR}/googlemock/gtest/libgtest.a"
        # when this target is linked to say the test bundle, also include the threading libs it uses.
        "INTERFACE_LINK_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
        # Expose the googletest headers globally so they're available in our tests
        "INTERFACE_INCLUDE_DIRECTORIES" "${SOURCE_DIR}/googletest/include")