
set(qan_source_files
    qanBehaviour.cpp
    qanBottomRightResizer.cpp
    qanRightResizer.cpp
    qanBottomResizer.cpp
    qanConnector.cpp
    qanDraggable.cpp
    qanDraggableCtrl.cpp
    qanEdge.cpp
    qanEdgeItem.cpp
    qanEdgeDraggableCtrl.cpp
    qanGraph.cpp
    qanGraphView.cpp
    qanGrid.cpp
    qanLineGrid.cpp
    qanGroup.cpp
    qanGroupItem.cpp
    qanNavigable.cpp
    qanNavigablePreview.cpp
    qanNode.cpp
    qanNodeItem.cpp
    qanPortItem.cpp
    qanSelectable.cpp
    qanStyle.cpp
    qanStyleManager.cpp
    qanAnalysisTimeHeatMap.cpp
    qanUtils.cpp
    qanTableGroup.cpp
    qanTableCell.cpp
    qanTableBorder.cpp
    qanTableGroupItem.cpp
    qanTreeLayouts.cpp
    )

set (qan_header_files
    qanAbstractDraggableCtrl.h
    qanBehaviour.h
    qanBottomRightResizer.h
    qanRightResizer.h
    qanBottomResizer.h
    qanConnector.h
    qanDraggable.h
    qanDraggableCtrl.h
    qanEdge.h
    qanEdgeDraggableCtrl.h
    qanEdgeItem.h
    qanGraph.h
    qanGraphView.h
    qanGrid.h
    qanGroup.h
    qanGroupItem.h
    qanLineGrid.h
    qanNavigable.h
    qanNavigablePreview.h
    qanNode.h
    qanNodeItem.h
    qanPortItem.h
    qanSelectable.h
    qanStyle.h
    qanStyleManager.h
    qanAnalysisTimeHeatMap.cpp
    qanUtils.h
    qanTableGroup.h
    qanTableCell.h
    qanTableBorder.h
    qanTableGroupItem.h
    qanTreeLayouts.h
    QuickQanava.h
    gtpo/container_adapter.h
    gtpo/edge.h
    gtpo/graph.h
    gtpo/graph.hpp
    gtpo/graph_property.h
    gtpo/node.h
    gtpo/node.hpp
    gtpo/observable.h
    gtpo/observer.h
    )

set(quickcontainers_source_files
    quickcontainers/qcmContainerModel.cpp
    quickcontainers/qcmAbstractContainer.cpp
    )

set (quickcontainers_header_files
    quickcontainers/QuickContainers.h
    quickcontainers/qcmContainerModel.h
    quickcontainers/qcmAbstractContainer.h
    quickcontainers/qcmContainer.h
    quickcontainers/qcmAdapter.h
    )


set (qan_plugin_files
    ${CMAKE_CURRENT_SOURCE_DIR}/qanPlugin.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/qanPlugin.h
)

# Configure Qt
set(CMAKE_AUTOMOC ON)
qt_wrap_cpp(qan_source_files, qan_header_files)   # Creates .moc files from sources
set(CMAKE_AUTORCC ON)
set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS $<$<CONFIG:Debug>:QT_QML_DEBUG>)

# Configure QuickQanava library ###############################################
list(APPEND qan_resources QuickQanava_static.qrc)
add_library(QuickQanava STATIC
    ${qan_source_files}
    ${qan_header_files}
    ${quickcontainers_source_files}
    ${quickcontainers_header_files}
    ${qan_resources}
    )

target_include_directories(QuickQanava
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include>
    )

target_compile_features(QuickQanava
    PUBLIC
        cxx_std_17
    )

install(FILES
    ${qan_header_files}
    DESTINATION include/quickqanava
    )

install(TARGETS QuickQanava
    EXPORT Targets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include/quickqanava
    )

set(CMAKE_INCLUDE_CURRENT_DIR ON)
target_link_libraries(QuickQanava PUBLIC Qt6::Core
                                         Qt6::Gui
                                         Qt6::Qml
                                         Qt6::Quick
                                         Qt6::QuickControls2)


