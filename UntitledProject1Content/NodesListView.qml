import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import QuickQanava      2.0 as Qan
import "qrc:/QuickQanava" as Qan

ListView {
    id: nodesListView
    model: undefined
    property var graphView: undefined
    property var graph: undefined
    clip: true
    spacing: 4
    delegate: Item {
        id: nodeDelegate
        width: ListView.view.width
        height: 30
        Label {
            id: nodeLabel
            text: "Label: " + itemData.label
        }
        MouseArea {
            anchors.fill: nodeDelegate
            acceptedButtons: Qt.AllButtons
            onClicked: {
                graph.clearSelection()
                graph.setNodeSelected(itemData,true)
                graph.setConnectorSource(itemData)
                graphView.centerOn(itemData.item)
            }
        }
    } // Item: nodeDelegate
} // ListView: nodesListView
