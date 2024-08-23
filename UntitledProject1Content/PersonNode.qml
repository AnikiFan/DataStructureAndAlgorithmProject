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
            color: {
                var colorList = [
                        "#F44336",
                        "#E91E63",
                        "#9C27B0",
                        "#673AB7",
                        "#3F51B5",
                        "#2196F3",
                        "#03A9F4",
                        "#00BCD4",
                            "#009688",
                            "#4CAF50",
                            "#8BC34A",
                            "#CDDC39",
                            "#FFEB3B",
                            "#FFC107",
                            "#FF9800",
                            "#FF5722",
                            "#795548",
                            "#9E9E9E",
                            "#607D8B",
                        ]
                return colorList[Number(node.label)%19]
            }
            Component.onCompleted: {console.log(node.label)}
            border.color: "black"; border.width: 5
            Text{
                anchors.centerIn: parent
                text:node.label
            }
        }
    }
}
