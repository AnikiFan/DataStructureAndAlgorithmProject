

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.7
import QtQuick.Controls 6.7
import UntitledProject1
import QtQuick.Studio.DesignEffects
import QtQuick.Layouts
import QtQuick.Studio.Components
import QtQuick.Dialogs
import Qt.labs.platform
import HeapListModel
import HeapTableModel
import HeapModel
import Element
import FileObject
//import QtQuick.Controls.Material
import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan
Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height
    visible: true
    color: "#e6e6e6"
    state: "home"
    Keys.forwardTo: [menu,questionPage,importPage,exportPage,heapShower,controlPanel,returnButton,questionButton,heapTable,quitBotton]
    // Keys.forwardTo:{
    //     if(mainWindow.state==='home')return[menu]
    //     else if(controlPanel.questionOpen)return[questionPage]
    //     else return[controlPanel,heap]
    // }
    function pause(){
                        if(HeapModel.pause&&!HeapModel.pauseWhenSwapping){
                            HeapModel.stop()
                            HeapModel.pause = false
                            HeapModel.pauseWhenSwapping = false
                        }
                        else if(HeapModel.pause&&HeapModel.pauseWhenSwapping){
                            timer.start()
                            HeapModel.pause = false
                            HeapModel.pauseWhenSwapping = false
                        }
                        else{
                            if(timer.running){
                                HeapModel.pause = true
                                HeapModel.pauseWhenSwapping = true
                                timer.stop()
                            }
                            else{
                                HeapModel.pause = true
                                HeapModel.pauseWhenSwapping = false
                            }
                        }
    }
    Image {
        id: backgroundImage
        visible: mainWindow.state === "home"
        anchors.fill: parent
        source: "qrc:/qtquickplugin/images/template_image.png"
        fillMode: Image.Stretch
    }
    Rectangle {
        id: menu
        x: 745
        y: 198
        width: 740
        height: 580
        visible: mainWindow.state === "home"
        color: "#e6e6e6"
        radius: 20
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        clip: true
        focus: mainWindow.state === 'home'
        opacity: 0.6
        property bool appScene: false
        property bool algoScene: false
        anchors.horizontalCenter: parent.horizontalCenter
        Keys.onPressed: (event) => {if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                Qt.quit();
                                event.accepted = true;
                            }
                            else event.accepted = false;
                        }
        DesignEffect {
            id: menuDesignEffect
            layerBlurRadius: 3
            // backgroundBlurRadius: 100
            // backgroundLayer: backgroundImage
            effects: [
                DesignDropShadow {
                    offsetY: 0.025 * menu.height
                    offsetX: 0.025 * menu.width
                }
            ]
            layerBlurVisible: true
        }
    }

    ColumnLayout {
        id: menuLayout
        width: menu.width
        height: menu.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: mainWindow.state === "home" ? true : false
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 20
        spacing: 5
        ColumnLayout {
            id: infoLayout
            width: 100
            height: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            Text {
                id: headerline
                text: qsTr("《数据结构与算法设计》")
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: subtitle
                text: qsTr("课程设计")
                font.pixelSize: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: authorName
                text: qsTr("范潇")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }

            Text {
                id: studentNumber
                text: qsTr("2254298")
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                font.family: "Microsoft YaHei"
                Layout.fillWidth: true
                font.styleName: "Bold"
                font.weight: Font.Black
                Layout.fillHeight: true
                font.bold: true
            }
        }

        ColumnLayout {
            id: menuBottonLayout
            Layout.rightMargin: 20
            Layout.leftMargin: 20
            Layout.bottomMargin: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20

            palette.button: '#cdcdcd'

            RoundButton {
                id: algoScreenButton
                radius: 20
                text: qsTr("算法实现：堆的建立和筛选")
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                Layout.fillWidth: true
                Layout.fillHeight: true
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }
                onClicked:{
                    menu.algoScene = true
                    heapTable.positionViewAtColumn((heapTable.columns-1)/2,TableView.AlignHCenter)
                    heapTable.positionViewAtRow(0,TableView.AlignTop)
                    if(HeapModel.firstClicked){
                        controlPanel.questionOpen = true
                        console.log(controlPanel.questionOpen)
                        HeapModel.firstClicked = false
                        HeapModel.pause = true
                        HeapModel.pauseWhenSwapping = false
                        HeapModel.wait()
                        HeapModel.start()
                    }
                }
            }

            RoundButton {
                id: appScreenButton
                radius: 20
                text: "综合应用：社会关系网络"
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }

                Connections {
                    target: appScreenButton
                    onClicked: menu.appScene = true
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            RoundButton {
                id: quitBotton
                radius: 20
                text: "退出"
                font.family: "Microsoft YaHei"
                font.pixelSize: 55
                font.bold: true
                font.weight: Font.Black
                display: AbstractButton.TextOnly
                DesignEffect {
                    effects: [
                        DesignDropShadow {
                            offsetY: 6
                            offsetX: 10
                        }
                    ]
                }
                onClicked: Qt.quit()
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }


    Rectangle {
        id: controlPanel
        y: 903
        height: 100
        visible:  mainWindow.state === "home" ? false : true
        color: "#cdcdcd"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        Keys.forwardTo: [returnButton,questionButton]
        property bool questionOpen: false
        property bool importOpen: false
        property bool exportOpen: false
        RoundButton {
            id: returnButton
            width: returnButton.height
            radius: 10
            palette.button: '#e54a4a'
            text: "↩"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.family: "Microsoft YaHei"
            activeFocusOnTab: false
            font.pixelSize: 100
            font.bold: true
            font.weight: Font.Black
            onClicked: {
                if(menu.algoScene){
                    if(timer.running){
                        HeapModel.pause = true
                        HeapModel.pauseWhenSwapping = true
                        timer.stop()
                    }
                    else{
                        HeapModel.pause = true
                        HeapModel.pauseWhenSwapping = false
                    }
                }
                menu.algoScene = false
                menu.appScene = false
            }
            focus: mainWindow.state === "home" || bluredBackground.visible? false : true
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    menu.algoScene = false
                                    menu.appScene = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
        }

        RoundButton {
            id: questionButton
            width: questionButton.height
            radius: 10
            text: "?"
            anchors.left: returnButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.family: "Microsoft YaHei"
            font.italic: false
            palette.button: "#348562"
            font.pixelSize: 70
            font.bold: true
            font.weight: Font.Black
            onClicked: {
                if(timer.running){
                    HeapModel.pause = true
                    HeapModel.pauseWhenSwapping = true
                    timer.stop()
                }
                else{
                    HeapModel.pause = true
                    HeapModel.pauseWhenSwapping = false
                }
                controlPanel.questionOpen = true
            }
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Question){
                                    controlPanel.questionOpen = true
                                    event.accepted = true
                                }else event.accepted = false
                            }
            focus: mainWindow.state === "home" || bluredBackground.visible? false : true
            activeFocusOnTab: false
        }

        RoundButton {
            id: importButton
            width: importButton.height
            radius: 10
            text: "导入"
            anchors.right: exportButton.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 30
            palette.button: "#68abd0"
            font.weight: Font.Black
            font.family: "Microsoft YaHei"
            font.bold: true
            Connections {
                target: importButton
                onClicked: {
                    if(timer.running){
                        HeapModel.pause = true
                        HeapModel.pauseWhenSwapping = true
                        timer.stop()
                    }
                    else{
                        HeapModel.pause = true
                        HeapModel.pauseWhenSwapping = false
                    }
                    controlPanel.importOpen=true
                }
            }
        }

        RoundButton {
            id: exportButton
            width: exportButton.height
            radius: 10
            text: "导出"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            palette.button: "#68abd0"
            font.pixelSize: 30
            font.weight: Font.Black
            font.family: "Microsoft YaHei"
            font.bold: true
            onClicked: {
                if(timer.running){
                    HeapModel.pause = true
                    HeapModel.pauseWhenSwapping = true
                    timer.stop()
                }
                else{
                    HeapModel.pause = true
                    HeapModel.pauseWhenSwapping = false
                }
                controlPanel.exportOpen=true
                outputBox.text=FileObject.result()
            }
        }

        RoundButton {
            function startBottonText(){
                if(HeapModel.finished){
                    return 'COMPLETE!';
                }else if(HeapModel.pause){
                    return '▶';
                }else{
                    return "STOP";
                }
            }
            function startBottonTextFontsize(){
                if(HeapModel.finished){
                    return 35;
                }else if(HeapModel.pause){
                    return 125;
                }else{
                    return 70;
                }
            }
            function startBottonColor(){
                if(HeapModel.finished){
                    return "#d69545";
                }else if(HeapModel.pause){
                    return "#d69545";
                }else{
                    return "#e54a4a";
                }
            }
            id: startButton
            width: 240
            radius: 10
            text:startBottonText()
            visible:mainWindow.state==="algo"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: startBottonTextFontsize()
            palette.button: startBottonColor()
            font.weight: Font.Black
            font.italic: false
            font.family: "Microsoft YaHei"
            font.bold: true
            onClicked: {
                if(HeapModel.finished){}
                else{mainWindow.pause()}
            }
        }

        Slider {
            id: speedSlider
            width: 120
            visible:mainWindow.state==="algo"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: startButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            from: 1   // 最小速率倍率
            to: 5     // 最大速率倍率
            value: 1.0  // 默认值，1.0表示正常速率
            stepSize: 0.1
           // onValueChanged:{console.log(value)}
            background: Rectangle {
                    x: speedSlider.leftPadding
                    y: speedSlider.topPadding + speedSlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    width: speedSlider.availableWidth
                    height: implicitHeight
                    radius: 2
                    color: "#e6e6e6"

                    Rectangle {
                        width: speedSlider.visualPosition * parent.width
                        height: parent.height
                        color: "#5f694e"
                        radius: 2
                    }
                }
        }

        RoundButton {
            id: restartButton
            width: 120
            radius: 10
            text: "↻"
            visible:mainWindow.state==="algo"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            font.pixelSize: 100
            palette.button: "#bdcf9a"
            font.weight: Font.Black
            font.italic: false
            font.family: "Microsoft YaHei"
            font.bold: true
            anchors.right:startButton.left
            onClicked: {
                if(HeapModel.finished){
                    HeapModel.restart()
                }
                else{
                    HeapModel.quit = true
                    if(HeapModel.pause&&!HeapModel.pauseWhenSwapping){
                        console.log('case1')
                        HeapModel.stop()
                        HeapModel.pause = false
                        HeapModel.pauseWhenSwapping = false
                    }
                    else if(HeapModel.pause&&HeapModel.pauseWhenSwapping){
                        console.log('case2')
                        timer.start()
                        HeapModel.pause = false
                        HeapModel.pauseWhenSwapping = false
                    }
                    else{console.log('case 3')}
                    HeapModel.stop()
                    timer.stop()
                }
            }
        }
    }

    Connections{
        target:HeapModel
        onSwapping:{
            //console.log('start')
            timer.restart()
        }
    }

    Timer {
            id: timer
            interval: 3000/speedSlider.value**2  // 将计时器的间隔时间绑定到可调节的属性
            repeat: false  // 使计时器重复触发
            running: false  // 启动计时器
            onTriggered: {
                HeapModel.stop()
               // console.log('finish')
            }
        }
    Item {
        id:heapShower
        height: 100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: controlPanel.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        visible: parent.state === 'algo'
        focus:parent.state === 'algo'&&!bluredBackground.visible?true:false
        Keys.onPressed: (event) =>{
                            if(event.key===Qt.Key_Plus||event.key===Qt.Key_Equal){
                                heapScrollBar.increase()
                                event.accepted = true
                            }
                            else if(event.key===Qt.Key_Minus||event.key===Qt.Key_Underscore){
                                heapScrollBar.decrease()
                                event.accepted = true
                            }
                            else event.accepted = false
                        }
            ListView {
                id:heapListView
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4
                clip: true
                orientation: ListView.Horizontal
                model:HeapListModel
                delegate: Rectangle {
                    border.width: 5
                    border.color: 'black'
                    width: 80
                    height: 80
                    color:{
                        if(model.state===Element.Active){return '#8ab8b6'}
                        if(model.state===Element.Inactive){return '#d5b29c'}
                        if(model.state===Element.Invalid){return 'black'}
                        if(model.state===Element.Changing){return'#f9ba1c'}
                    }
                    visible: model.state===Element.Invalid?false:true
                    Text{
                        property int number:model.value
                        anchors.centerIn: parent
                        text:(number).toString()
                        anchors.fill: parent
                        wrapMode: Text.WrapAnywhere
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.margins: parent.border.width
                    }
                }
                ScrollBar.horizontal: ScrollBar { id: heapScrollBar }
            }
    }
    TableView {
        id:heapTable
        visible:parent.state==="algo"
        anchors.left: parent.left
        anchors.bottom: heapShower.top
        anchors.top: parent.top
        anchors.right:parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        columnSpacing: 0
        rowSpacing: 0
        clip: true
        rowHeightProvider: (row)=>{return height/HeapTableModel.rowNumber<100?100:height/HeapTableModel.rowNumber}
        columnWidthProvider: (column)=>{return width/HeapTableModel.colNumber<100?100:width/HeapTableModel.colNumber}
        Connections{
            target: HeapTableModel
            onFocusOnItem:function(r,c){
                heapTable.positionViewAtColumn(c,TableView.AlignHCenter)
                heapTable.positionViewAtRow(r,TableView.AlignVCenter)
               // heapTable.positionViewAtCell(Qt.point(r, c), TableView.Center)
            }
        }

        model:HeapTableModel
        delegate: Rectangle {
            id:heapTableBackground
            color:"white"
            Rectangle{
                border.width: 5
                border.color: 'black'
                visible: model.state===Element.Invalid?false:true
                width: parent.width>parent.height?parent.height:parent.width
                height:width
                radius:width/2
                color:{
                    if(model.state===Element.Active){return '#8ab8b6'}
                    if(model.state===Element.Inactive){return '#d5b29c'}
                    if(model.state===Element.Invalid){return 'black'}
                    if(model.state===Element.Changing){return'#f9ba1c'}
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    property int number:model.value
                    anchors.centerIn: parent
                    text:(number).toString()
                    anchors.fill: parent
                    wrapMode: Text.WrapAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.margins: parent.border.width
                }

            }
        }
        ScrollBar.vertical: ScrollBar {
            id:vbar
            visible:false
        }
        ScrollBar.horizontal: ScrollBar {
            id:hbar
            visible:false
        }
        focus:parent.state==='algo'&&!bluredBackground.visible
        Keys.onLeftPressed: hbar.decrease()
        Keys.onRightPressed: hbar.increase()
        Keys.onUpPressed: vbar.decrease()
        Keys.onDownPressed: vbar.increase()
    }
    Component {
        id: customSelectionComponent
        SelectionDelegate { }
    }
    Qan.GraphView {
      id: graphView
      visible:parent.state === 'app'
      anchors.left:parent.left
      anchors.right:parent.right
      anchors.top:parent.top
      anchors.bottom:controlPanel.top
      navigable   : true
      graph: Qan.Graph {
          id: graph
          property var personNode:Qt.createComponent('PersonNode.qml')
          //selectionPolicy: Qan.Graph.SelectOnClick //选择，可以用于选择详细说明的用户
          //connectorEnabled: true //允许通过拖拽生成新边
          Component.onCompleted: {    // Qan.Graph.Component.onCompleted()
              var n1 = graph.insertNode(personNode)
                 n1.label = "Hello World"; n1.item.x=50; n1.item.y= 50
                 var n2 = graph.insertNode(personNode)
                 n2.label = "Node 2"; n2.item.x=200; n2.item.y= 125
              var n3 = graph.insertNode(personNode)
                 n3.label = "test"; n1.item.x=150; n1.item.y= 150
                 //defaultEdgeStyle.lineType = Qan.EdgeStyle.Curved
              defaultEdgeStyle.srcShape = Qan.EdgeStyle.None
              defaultEdgeStyle.dstShape = Qan.EdgeStyle.None
             defaultEdgeStyle.lineType=Qan.EdgeStyle.Curved
             selectionPolicy: Qan.Graph.SelectOnClick
              selectionDelegate = customSelectionComponent
          }
         connectorEnabled: true
         connectorItem : Control {
             anchors.fill: parent
             hoverEnabled: true
             visible: false              // SAMPLE: Do not forget to hide the custom connector item by default, visual connector will set visible to true on demand
             ToolTip.visible: hovered &&
                              ( !parent.connectorDragged || state === "HILIGHT" )
             onStateChanged: {
                 ToolTip.text = ( state === "HILIGHT" ? "Drop to connect" : "Drag on a target node" )
             }
             states: [
                 State { name: "NORMAL"; PropertyChanges { target: flag; scale: 1.0 } },
                 State { name: "HILIGHT"; PropertyChanges { target: flag; scale: 1.7 } }
             ]
             transitions: [
                 Transition { from: "NORMAL"; to: "HILIGHT"; PropertyAnimation { target: flag; properties: "borderWidth, scale"; duration: 100 } },
                 Transition { from: "HILIGHT"; to: "NORMAL"; PropertyAnimation { target: flag; properties: "borderWidth, scale"; duration: 150 } }
             ]
             Image {
                 anchors.centerIn : parent
                 width:50
                 height: 50
                 id: flag
                 source: "images/hand.svg"
                 state: "NORMAL"; smooth: true;   antialiasing: true
             }
         }

          function notifyUser(message) { toolTip.text=message; toolTip.open() }
          function getEdgeDescription(edge) {
              var edgeSrcDst = "unknown"
              if ( edge && edge.item ) {
                  var edgeItem = edge.item
                  if ( edgeItem.sourceItem &&
                       edgeItem.sourceItem.node )
                      edgeSrcDst = edgeItem.sourceItem.node.label
                  edgeSrcDst += " -> "
                  if ( edgeItem.destinationItem &&
                       edgeItem.destinationItem.node )
                      edgeSrcDst += edgeItem.destinationItem.node.label
              }
              return edgeSrcDst
          }
          onNodeClicked: (node) => {
              notifyUser( "Node <b>" + node.label + "</b> clicked" )
              nodeEditor.node = node
          }
          onNodeRightClicked: (node) => { notifyUser( "Node <b>" + node.label + "</b> right clicked" ) }
          onNodeDoubleClicked: (node) => { notifyUser( "Node <b>" + node.label + "</b> double clicked" ) }
          onNodeMoved: (node) => { notifyUser("Node <b>" + node.label + "</b> moved") }
          onConnectorEdgeInserted: (edge) => {
                                       notifyUser("Edge inserted: " + getEdgeDescription(edge))

                                   }
          onConnectorRequestEdgeCreation: (src, dst) => { notifyUser("Requesting Edge creation from " + src.label + " to " + ( dst ? dst.label : "UNDEFINED" ) ) }
          onEdgeClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " clicked") }
          onEdgeDoubleClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " double clicked") }
          onEdgeRightClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " right clicked") }
        } // Qan.Graph: topology
      ToolTip {
          id: toolTip
          timeout: 2500
      }

      Pane {
          id: nodeEditor
          property var node: undefined
          onNodeChanged: nodeItem = node ? node.item : undefined
          property var nodeItem: undefined
          anchors.bottom: parent.bottom; anchors.bottomMargin: 15
          anchors.right: parent.right; anchors.rightMargin: 15
          padding: 0
          Frame {
              ColumnLayout {
                  Label {
                      text: nodeEditor.node ? "Editing node <b>" + nodeEditor.node.label + "</b>": "Select a node..."
                  }
                  CheckBox {
                      text: "Draggable"
                      enabled: nodeEditor.nodeItem !== undefined
                      checked: nodeEditor.nodeItem ? nodeEditor.nodeItem.draggable : false
                      onClicked: nodeEditor.nodeItem.draggable = checked
                  }
                  CheckBox {
                      text: "Resizable"
                      enabled: nodeEditor.nodeItem !== undefined
                      checked: nodeEditor.nodeItem ? nodeEditor.nodeItem.resizable : false
                      onClicked: nodeEditor.nodeItem.resizable = checked
                  }
                  CheckBox {
                      text: "Selected (read-only)"
                      enabled: false
                      checked: nodeEditor.nodeItem ? nodeEditor.nodeItem.selected : false
                  }
                  CheckBox {
                      text: "Selectable"
                      enabled: nodeEditor.nodeItem != null
                      checked: nodeEditor.nodeItem ? nodeEditor.nodeItem.selectable : false
                      onClicked: nodeEditor.nodeItem.selectable = checked
                  }
                  Label { text: "style.backRadius" }
                  Slider {
                      from: 0.; to: 15.0;
                      value: defaultNodeStyle.backRadius
                      stepSize: 1.0
                      onMoved: defaultNodeStyle.backRadius = value
                  }
              }
          }
      }
      //onRightClicked: function(pos) {
        //  contextMenu.open()
      //}
    } // Qan.GraphView    Qan.Graph {
    Rectangle {
        id: bluredBackground
        visible: controlPanel.questionOpen || controlPanel.importOpen || controlPanel.exportOpen
        color: "#ffffff"
        border.width: 0
        anchors.fill: parent
        opacity: 0.9

        Page {
            id: questionPage
            focus: controlPanel.questionOpen
            visible: controlPanel.questionOpen
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.questionOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            Keys.onLeftPressed:(event) =>{
                                   if(view.currentIndex > 0){
                                       event.accepted = true
                                       view.currentIndex -=1 ;
                                   }else event.accepted = false
                               }
            Keys.onRightPressed:(event) =>{
                                    if(view.currentIndex<view.count-1){
                                        event.accepted = true
                                        view.currentIndex +=1 ;
                                    }else event.accepted = false
                                }
            width: 400
            height: 400
            palette.window: "#cdcdcd"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            header: Label {
                text: view.currentItem.title
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
                font.bold: true
                anchors.right: parent.right
                anchors.left: parent.left
            }
            Rectangle{
                anchors.fill: parent
                color:'white'
                SwipeView {
                    id: view
                    currentIndex: 1
                    anchors.fill: parent
                    clip: true
                    palette.window: '#dfdfdf'
                    Page {
                        title: qsTr("Home")

                        Text{
                            id: text3
                            text:"test"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop
                        }
                    }
                    Page {
                        title: qsTr("Discover")
                        Text{
                            id: text1
                            text:"test1"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Page {
                        title: qsTr("Activity")
                        Text{
                            id: text2
                            text:"test2"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
            PageIndicator {
                id: indicator
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                count: view.count
                currentIndex: view.currentIndex
            }
        }

        Rectangle {
            id: importPage
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.importOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            FileDialog {
                id: readFileDialog
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: {
                    FileObject.source = readFileDialog.file
                    FileObject.read()
                }
                nameFilters: ["Text files (*.txt)"]
            }
            FileDialog {
                id: writeFileDialog
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: {
                    FileObject.source = writeFileDialog.file
                    FileObject.write(outputBox.text)
                }
                nameFilters: ["Text files (*.txt)"]
            }
            width: 400
            height: 650
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#dfdfdf"
            visible: controlPanel.importOpen
            focus: controlPanel.importOpen
            ColumnLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                Rectangle{
                    id:inputBoxBackground
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height:500
                    ScrollView {
                        id: inputBoxView
                        anchors.fill: parent
                        TextArea {
                            id:inputBox
                            wrapMode: Text.Wrap
                            anchors.fill:inputBoxView
                            placeholderText: "请输入整数，用空格或回车分隔"
                            font.pixelSize: 20
                            font.weight: Font.Black
                            font.family: "Microsoft YaHei"
                            font.bold: true
                        }
                    }
                }
                RoundButton{
                    id:textImportButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    palette.button: '#cdcdcd'
                    text:"从文件中导入"
                    font.pixelSize: 30
                    font.weight: Font.Black
                    font.family: "Microsoft YaHei"
                    font.bold: true
                    Connections {
                        target: textImportButton
                        onClicked: {
                            readFileDialog.open()
                        }
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RoundButton{
                        id:importCancelButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: '#e54a4a'
                        text:"取消"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: importCancelButton
                            onClicked: {
                                controlPanel.importOpen=false
                                inputBox.text = ''
                            }
                        }
                    }
                    RoundButton{
                        id:importCheckButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: "#348562"
                        text:"确认"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: importCheckButton
                            onClicked: {
                                controlPanel.importOpen=false
                                if(HeapModel.finished){
                                    HeapModel.reload(inputBox.text)
                                }
                                else{
                                    HeapModel.reloading = true
                                    HeapModel.quit = true
                                    if(HeapModel.pause&&!HeapModel.pauseWhenSwapping){
                                        console.log('case1')
                                        HeapModel.stop()
                                        HeapModel.pause = false
                                        HeapModel.pauseWhenSwapping = false
                                    }
                                    else if(HeapModel.pause&&HeapModel.pauseWhenSwapping){
                                        console.log('case2')
                                        timer.start()
                                        HeapModel.pause = false
                                        HeapModel.pauseWhenSwapping = false
                                    }
                                    else{console.log('case 3')}
                                    HeapModel.stop()
                                    timer.stop()
                                }
                            }
                        }
                    }
                }
            }
        }
        Connections {
              target: HeapModel
              onGetInputText: {
                  console.log('reload')
                  HeapModel.reload(inputBox.text)
              }
          }
        Rectangle {
            id: exportPage
            Keys.onPressed: (event) =>{
                                if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                    controlPanel.exportOpen = false
                                    event.accepted = true
                                }
                                else event.accepted = false
                            }
            width: 400
            height: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#dfdfdf"
            visible: controlPanel.exportOpen
            focus: controlPanel.exportOpen
            ColumnLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                Rectangle{
                    id:outputBoxBackground
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height:500
                    ScrollView {
                        id: outputBoxView
                        anchors.fill: parent
                        TextArea {
                            id:outputBox
                            wrapMode: TextInput.WrapAtWordBoundaryOrAnywhere
                            anchors.fill: outputBoxBackground
                            readOnly: true
                            font.pixelSize: 20
                            font.weight: Font.Black
                            font.family: "Microsoft YaHei"
                            font.bold: true
                        }
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    RoundButton{
                        id:textExportButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: '#e54a4a'
                        text:"保存至文件"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: textExportButton
                            onClicked: {
                                writeFileDialog.open()
                            }
                        }
                    }
                    RoundButton{
                        id:copyButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        palette.button: "#348562"
                        text:"复制"
                        font.pixelSize: 30
                        font.weight: Font.Black
                        font.family: "Microsoft YaHei"
                        font.bold: true
                        Connections {
                            target: copyButton
                            onClicked: {
                                outputBox.selectAll()
                                outputBox.copy()
                                outputBox.deselect()
                            }
                        }
                    }
                }
                RoundButton{
                    id:textExportQuitButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    palette.button: '#cdcdcd'
                    text:"返回"
                    font.pixelSize: 30
                    font.weight: Font.Black
                    font.family: "Microsoft YaHei"
                    font.bold: true
                    Connections {
                        target: textExportQuitButton
                        onClicked: {
                            controlPanel.exportOpen=false
                        }
                    }
                }
            }
        }
    }
    states: [
        State {
            name: "home"
            when: !menu.algoScene && !menu.appScene
            PropertyChanges {
                target: backgroundImage
                source: "images/background.png"
            }
        },
        State {
            name: "algo"
            when: menu.algoScene && !menu.appScene
        },
        State {
            name: "app"
            when: !menu.algoScene && menu.appScene
        }
    ]

}

/*##^##
Designer {
    D{i:0}D{i:52;invisible:true}
}
##^##*/

