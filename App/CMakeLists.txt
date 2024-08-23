
target_sources(${CMAKE_PROJECT_NAME} PUBLIC
	"main.cpp"
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    QuickQanava
    Qt${QT_VERSION_MAJOR}::QuickControls2
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml)
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC QuickQanava Qt${QT_VERSION_MAJOR}::QuickControls2)
