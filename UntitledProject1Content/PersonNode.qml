import QtQuick 6.7
import QuickQanava 2.0 as Qan
import QtQuick.Effects
Qan.NodeItem {
    id: customNode
    width: 100; height: 100
    x: 15;      y: 15
    resizable: false

    Item {
        anchors.fill: parent
        Rectangle {
            id: background
            anchors.fill: parent
            radius: parent.width/2
            color: Number(node.label)===1?'red':'blue'
            Component.onCompleted: {console.log(node.label)}
            border.color: "violet"; border.width: 5
            Text{
                anchors.centerIn: parent
                text:"NAME"
            }
        }
    }
}
