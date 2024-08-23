import QtQuick
import QtQuick.Studio.DesignEffects
Rectangle {
    id: selectionItem
    // QuickQanava global selection properties support: see qan::Selectable,
    // qan::Graph::configureSelectionItem() and qan::Graph::createSelectionItem() for documentation
    property real   selectionMargin: 3
    property color  selectionColor: Qt.rgba(0.,0.,1.,1.)
    property real   selectionWeight: 3
    radius: width/2
    states: [
        State {
            name: "UNSELECTED"
            PropertyChanges { target: selectionItem;    opacity : 0.;                   }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: selectionItem;    opacity : 1;   scale : 1.1    }
        }
    ]
    // Use transitions to customize from SELECTED to UNSELECTED

    anchors.margins: selectionMargin
    border {
        width: selectionWeight * 2
        color: "red"
    }
    DesignEffect {
        layerBlurRadius: 20
        effects: [
            DesignDropShadow {
            }
        ]
    }
    color: Qt.rgba(1.,0.,0.,0.)
    clip: true
}
