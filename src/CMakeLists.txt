set(APP_BUNDLE ${PROJECT_NAME}_lib)

file(GLOB SOURCE *.cpp)
add_library(${APP_BUNDLE} SHARED ${SOURCE})

#set_target_properties(${APP_BUNDLE} PROPERTIES
#        "OUTPUT_NAME" "${PROJECT_NAME}"
#        )

# ???
install(TARGETS ${APP_BUNDLE} EXPORT ${PROJECT_NAME} DESTINATION ${CMAKE_SOURCE_DIR}/lib)
export(TARGETS ${APP_BUNDLE} FILE ${CMAKE_BINARY_DIR}-config.cmake)