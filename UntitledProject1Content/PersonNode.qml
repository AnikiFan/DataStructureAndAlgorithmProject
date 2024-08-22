import QtQuick 6.7
import QuickQanava 2.0 as Qan
Qan.NodeItem {
    id: customNode
    width: 100; height: 100
    x: 15;      y: 15
    Item {
        anchors.fill: parent
        Rectangle {
            id: background
            anchors.fill: parent
            radius: parent.width/2; color: light
            border.color: "violet"; border.width: 5
            readonly property color dark: "blue"
            readonly property color light: "lightblue"
            Text{
                anchors.centerIn: parent
                text:"NAME"
            }
        }
    }
}
