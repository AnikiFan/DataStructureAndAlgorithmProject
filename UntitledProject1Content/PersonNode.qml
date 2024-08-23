import QtQuick 6.7
import QuickQanava 2.0 as Qan
import QtQuick.Effects
import QtQuick.Controls.Material
Qan.NodeItem {
    id: customNode
    width: 100; height: 100
    x: 15;      y: 15
    resizable: false
    draggable: false
    Item {
        anchors.fill: parent
        Rectangle {
            id: background
            anchors.fill: parent
            radius: parent.width/2
            color: Number(node.label)===1?Material.color(Material.Red):Material.color(Material.Blue)
            Component.onCompleted: {console.log(node.label)}
            border.color: "violet"; border.width: 5
            Text{
                anchors.centerIn: parent
                text:node.label
            }
        }
    }
}
