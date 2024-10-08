cmake_minimum_required(VERSION 3.16)

project(QuickQanava_sample_navigable VERSION 2.5.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Configure Qt
find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml Quick QuickControls2)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS $<$<CONFIG:Debug>:QT_QML_DEBUG>)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set( source_files
    navigable.cpp
    ../../src/qanNavigable.cpp
    ../../src/qanNavigablePreview.cpp
    ../../src/qanGrid.cpp
    ../../src/qanLineGrid.cpp
)

set (header_files )

if(NOT TARGET QuickQanava)
    add_subdirectory(../../ quickqanava_build)  # Use ../../src as quickqanava_build subdirectory
    # see https://stackoverflow.com/questions/50408169/cmake-error-add-subdirectory-not-given-a-binary-directory/50408555
endif()

add_executable(sample_navigable ${source_files} navigable.qrc)
target_include_directories(sample_navigable PUBLIC Qt${QT_VERSION_MAJOR}::QuickControls2)
target_link_libraries(sample_navigable
    QuickQanava
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::QuickControls2
)
