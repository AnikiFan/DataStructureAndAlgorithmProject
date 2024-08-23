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
        height: 50
        ColumnLayout{
            anchors.fill: parent
            Label {
                id: nodeLabel
                text: "#" + itemData.label+":"+itemData.name
                font.bold: true
                font.pixelSize: 25
                font.family: "Microsoft YaHei"
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Label {
                id: nodeMotto
                text: itemData.motto
                font.bold: true
                font.pixelSize: 15
                font.family: "Microsoft YaHei"
                font.italic: true
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
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
