cmake_minimum_required(VERSION 3.16)
# 工程名
project(qml-sample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON) # Meta-Object Compiler
set(CMAKE_AUTORCC ON) # Resource Compiler
set(CMAKE_AUTOUIC ON) # User Interface Compiler
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Gui Charts WebChannel)

file(GLOB_RECURSE CPP_PATHS  cpp/*.cpp cpp/*.h cpp/*.cc cpp/*.hpp)
foreach(filepath ${CPP_PATHS})
    message("加载cpp文件：" ${filepath})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath}) #.+/(.+)\\\\..*" "\\\\1
    list(APPEND CPP_FILES ${filename})
endforeach(filepath)
list(REMOVE_DUPLICATES CPP_FILES)

file(GLOB_RECURSE QML_PATHS qml/*.qml)
foreach(filepath ${QML_PATHS})
    ## 排除dummydata
    if(filepath MATCHES "(dummydata)+")
        continue()
    endif()
    message("加载qml文件：" ${filepath})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath}) #.+/(.+)\\\\..*" "\\\\1
    list(APPEND QML_FILES ${filename})
endforeach(filepath)
list(REMOVE_DUPLICATES QML_FILES) #表示删除非第一个重名值

file(GLOB_RECURSE ASSETS_PATHS *.png *.jpg *.svg *.ttf *.html *.js *.css)
foreach(filepath ${ASSETS_PATHS})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath}) #.+/(.+)\\\\..*" "\\\\1
    list(APPEND ASSETS_FILES ${filename})
endforeach(filepath)
list(REMOVE_DUPLICATES ASSETS_FILES)

qt_add_executable(app-${CMAKE_PROJECT_NAME}
   	${CPP_FILES}
)

# 这里的uri将会影响qrc路径的前缀
#qt_add_qml_module(app-${CMAKE_PROJECT_NAME}
#    URI main
#    VERSION 1.0
#    QML_FILES ${QML_FILES}
#    RESOURCES ${ASSETS_FILES}
#)

qt6_add_resources(app-${CMAKE_PROJECT_NAME} "qml"
    PREFIX
        "/"
    FILES
        ${QML_FILES}
        ${ASSETS_FILES}
)

target_link_libraries(app-${CMAKE_PROJECT_NAME}
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Charts Qt6::Gui Qt6::WebChannel)

set_target_properties(app-${CMAKE_PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS app-${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

## demo
#if(WIN32)
#	message(STATUS "Now is windows")
#elseif(APPLE)
#	message(STATUS "Now is Apple systens.")
#elseif(UNIX)
#	message(STATUS "Now is UNIX-like OS's.")
#endif()
