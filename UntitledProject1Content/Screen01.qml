

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
import GraphModel
import QtQuick.Controls.Material
import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan
Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height
    visible: true
    color: "#cfd8dc"
    state: "home"
    Keys.forwardTo: [menu,importPage,exportPage,heapShower,controlPanel,returnButton,heapTable,quitBotton]
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
    Pane {
        id: menu
        width: 740
        height: 580
        visible: mainWindow.state === "home"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        focus: mainWindow.state === 'home'
        opacity: 0.8
        Material.background: Material.color(Material.BlueGrey,Material.Shade200)
        Material.roundedScale: Material.SmallScale
        Material.elevation: 10
        property bool appScene: false
        property bool algoScene: false
        Keys.onPressed: (event) => {if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
                                Qt.quit();
                                event.accepted = true;
                            }
                            else event.accepted = false;
                        }
        ColumnLayout {
            id: menuLayout
            anchors.fill: parent
            visible: mainWindow.state === "home" ? true : false
            spacing: 5
            ColumnLayout {
                id: infoLayout
                width: 100
                height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 0
                MyText{
                    id:headerline
                    content:"《数据结构与算法设计》"
                    fontsize: 70
                }
                MyText {
                    id: subtitle
                    content: "课程设计"
                    fontsize: 50
                }

                MyText {
                    id: authorName
                    content: "范潇"
                    fontsize: 40
                }

                MyText {
                    id: studentNumber
                    content: "2254298"
                    fontsize: 40
                }
            }

            ColumnLayout {
                id: menuBottonLayout
                Layout.rightMargin: 20
                Layout.leftMargin: 20
                Layout.bottomMargin: 20
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 10
                palette.button: '#cdcdcd'

                MyButton{
                    id: algoScreenButton
                    content:"算法实现：堆的建立和筛选"
                    onClicked:{
                        menu.algoScene = true
                        heapTable.positionViewAtColumn((heapTable.columns-1)/2,TableView.AlignHCenter)
                        heapTable.positionViewAtRow(0,TableView.AlignTop)
                        if(HeapModel.firstClicked){
                            HeapModel.firstClicked = false
                            HeapModel.pause = true
                            HeapModel.pauseWhenSwapping = false
                            HeapModel.wait()
                            HeapModel.start()
                        }
                    }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }


                MyButton {
                    id: appScreenButton
                    content: "综合应用：社会关系网络"
                    onClicked: {
                        menu.appScene = true
                    }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                MyButton {
                    id: quitBotton
                    content: "退出"
                    onClicked: Qt.quit()
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }

    }
    Pane {
        id:heapShower
        height: 100
        Material.background: Material.color(Material.BlueGrey,Material.Shade200)
        Material.elevation: 10
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
                anchors.margins: 0
                spacing: 4
                clip: true
                orientation: ListView.Horizontal
                model:HeapListModel
                delegate: Rectangle {
                    border.width: 5
                    border.color: 'black'
                    height:75
                    width: height
                    color:{
                        if(model.state===Element.Active){return '#4db6ac'}
                        if(model.state===Element.Inactive){return '#bcaaa4'}
                        if(model.state===Element.Invalid){return 'black'}
                        if(model.state===Element.Changing){return'#FFC107'}
                    }
                    visible: model.state===Element.Invalid?false:true
                    Text{
                        property int number:model.value
                        anchors.centerIn: parent
                        text:(number).toString()
                        font.pixelSize: 20
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
    Pane {
        id: controlPanel
        y: 903
        height: 100
        visible:  mainWindow.state === "home" ? false : true
        Material.background: Material.color(Material.BlueGrey,Material.Shade300)
        Material.elevation:10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        Keys.forwardTo: [returnButton]
        property bool questionOpen: false
        property bool importOpen: false
        property bool exportOpen: false
        MyButton {
            id: returnButton
            width: returnButton.height
            color:Material.Red
            content: "↩"
            fontsize: 80
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
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

        // MyButton {
        //     id: questionButton
        //     width: questionButton.height
        //     content: "?"
        //     fontsize: 55
        //     color:Material.Green
        //     anchors.left: returnButton.right
        //     anchors.top: parent.top
        //     anchors.bottom: parent.bottom
        //     anchors.leftMargin: 10
        //     anchors.topMargin: 0
        //     anchors.bottomMargin: 0
        //     onClicked: {
        //         if(timer.running){
        //             HeapModel.pause = true
        //             HeapModel.pauseWhenSwapping = true
        //             timer.stop()
        //         }
        //         else{
        //             HeapModel.pause = true
        //             HeapModel.pauseWhenSwapping = false
        //         }
        //         controlPanel.questionOpen = true
        //     }
        //     Keys.onPressed: (event) =>{
        //                         if(event.key===Qt.Key_Question){
        //                             controlPanel.questionOpen = true
        //                             event.accepted = true
        //                         }else event.accepted = false
        //                     }
        //     focus: mainWindow.state === "home" || bluredBackground.visible? false : true
        // }

        MyButton {
            id: importButton
            width: importButton.height
            content: "↯"
            fontsize:60
            color:Material.Blue
            anchors.right: exportButton.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
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

        MyButton {
            id: exportButton
            width: exportButton.height
            content: "⇫"
            fontsize:60
            color:Material.Blue
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
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

        MyButton {
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
                    return 30;
                }else if(HeapModel.pause){
                    return 90;
                }else{
                    return 50;
                }
            }
            function startBottonColor(){
                if(HeapModel.finished){
                    return Material.color(Material.Brown,Material.Shade200);
                }else if(HeapModel.pause){
                    return Material.color(Material.Teal,Material.Shade200);
                }else{
                    return Material.Amber;
                }
            }
            id: startButton
            width: 240
            content:startBottonText()
            visible:mainWindow.state==="algo"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            fontsize: startBottonTextFontsize()
            color: startBottonColor()
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
        }

        MyButton {
            id: restartButton
            width: height
            content: "↻"
            visible:mainWindow.state==="algo"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            fontsize: 60
            color:Material.Pink
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
        Material.background: Material.color(Material.BlueGrey,Material.Shade100)
        rowHeightProvider: (row)=>{return height/HeapTableModel.rowNumber<100?100:height/HeapTableModel.rowNumber}
        columnWidthProvider: (column)=>{return width/HeapTableModel.colNumber<100?100:width/HeapTableModel.colNumber}
        Connections{
            target: HeapTableModel
            onFocusOnItem:function(r,c){
                heapTable.positionViewAtColumn(c,TableView.AlignHCenter)
                heapTable.positionViewAtRow(r,TableView.AlignVCenter)
            }
        }
        model:HeapTableModel
        delegate: Rectangle {
            id:heapTableBackground
            color:"#cfd8dc"
            Rectangle{
                border.width: 5
                border.color: 'black'
                visible: model.state===Element.Invalid?false:true
                width: parent.width>parent.height?parent.height:parent.width
                height:width
                radius:width/2
                color:{
                    if(model.state===Element.Active){return '#4db6ac'}
                    if(model.state===Element.Inactive){return '#bcaaa4'}
                    if(model.state===Element.Invalid){return 'black'}
                    if(model.state===Element.Changing){return'#FFC107'}
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    property int number:model.value
                    anchors.centerIn: parent
                    text:(number).toString()
                    anchors.fill: parent
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: 20
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
      grid:null
      graph: GraphModel {
          id: graph
          property var personNode:Qt.createComponent('PersonNode.qml')
          //selectionPolicy: Qan.Graph.SelectOnClick //选择，可以用于选择详细说明的用户
          //connectorEnabled: true //允许通过拖拽生成新边
          Component.onCompleted: {    // Qan.Graph.Component.onCompleted()
              var n1 = graph.insertCustomNode()
                 n1.label = 1; n1.item.x=50; n1.item.y= 50
                n1.age = 24;n1.name='田所';n1.school='市西';n1.company='无'
                 var n2 = graph.insertCustomNode()
                 n2.label = 2; n2.item.x=200; n2.item.y= 125
              var n3 = graph.insertCustomNode()
                 n3.label = 3; n1.item.x=150; n1.item.y= 150
                 //defaultEdgeStyle.lineType = Qan.EdgeStyle.Curved
              defaultEdgeStyle.srcShape = Qan.EdgeStyle.None
              defaultEdgeStyle.dstShape = Qan.EdgeStyle.None
             defaultEdgeStyle.lineType=Qan.EdgeStyle.Curved
              //defaultEdgeStyle.lineColor = Qt.rgba(1,0,0,1)
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

        // Pane {
        //     id: questionPage
        //     focus: controlPanel.questionOpen
        //     visible: controlPanel.questionOpen
        //     Keys.onPressed: (event) =>{
        //                         if(event.key===Qt.Key_Q||event.key===Qt.Key_Escape){
        //                             controlPanel.questionOpen = false
        //                             event.accepted = true
        //                         }
        //                         else event.accepted = false
        //                     }
        //     Keys.onLeftPressed:(event) =>{
        //                            if(view.currentIndex > 0){
        //                                event.accepted = true
        //                                view.currentIndex -=1 ;
        //                            }else event.accepted = false
        //                        }
        //     Keys.onRightPressed:(event) =>{
        //                             if(view.currentIndex<view.count-1){
        //                                 event.accepted = true
        //                                 view.currentIndex +=1 ;
        //                             }else event.accepted = false
        //                         }
        //     width: 400
        //     height: 400
        //     anchors.verticalCenter: parent.verticalCenter
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     Material.background: Material.color(Material.Teal,Material.Shade100)
        //     Material.elevation: 10
        //     ColumnLayout{
        //         anchors.fill: parent
        //         SwipeView {
        //             id: view
        //             currentIndex: 1
        //             clip: true
        //             Layout.fillHeight: true
        //             Layout.fillWidth: true
        //             Page {
        //                 Text{
        //                     id: text3
        //                     text:"test"
        //                     anchors.fill: parent
        //                     horizontalAlignment: Text.AlignHCenter
        //                     verticalAlignment: Text.AlignTop
        //                 }
        //             }
        //             Page {
        //                 Text{
        //                     id: text1
        //                     text:"test1"
        //                     anchors.fill: parent
        //                     horizontalAlignment: Text.AlignHCenter
        //                     verticalAlignment: Text.AlignVCenter
        //                 }
        //             }
        //             Page {
        //                 Text{
        //                     id: text2
        //                     text:"test2"
        //                     anchors.fill: parent
        //                     horizontalAlignment: Text.AlignHCenter
        //                     verticalAlignment: Text.AlignVCenter
        //                 }
        //             }
        //         }
        //     }
        //     PageIndicator {
        //         id: indicator
        //         anchors.horizontalCenter: parent.horizontalCenter
        //         anchors.bottom: parent.bottom
        //         count: view.count
        //         currentIndex: view.currentIndex
        //     }
        // }

        Pane {
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
            Material.background: Material.color(Material.Teal,Material.Shade100)
            Material.elevation: 10
            visible: controlPanel.importOpen
            focus: controlPanel.importOpen
            ColumnLayout{
                anchors.fill: parent
                Item{
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
                            Material.accent: Material.Teal
                        }
                    }
                }
                MyButton{
                    id:textImportButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    content:"从文件中导入"
                    Material.background: Material.Amber
                    fontsize: 30
                    onClicked: {
                        readFileDialog.open()
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    MyButton{
                        id:importCancelButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"取消"
                        fontsize: 30
                        Material.background: Material.Red
                        onClicked: {
                            controlPanel.importOpen=false
                            inputBox.text = ''
                        }
                    }
                    MyButton{
                        id:importCheckButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"确认"
                        Material.background: Material.Green
                        fontsize: 30
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
        Connections {
              target: HeapModel
              onGetInputText: {
                  console.log('reload')
                  HeapModel.reload(inputBox.text)
              }
          }
        Pane {
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
            visible: controlPanel.exportOpen
            focus: controlPanel.exportOpen
            Material.background: Material.color(Material.Teal,Material.Shade100)
            Material.elevation: 10
            ColumnLayout{
                anchors.fill: parent
                Item{
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
                    MyButton{
                        id:textExportButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"保存至文件"
                        fontsize: 30
                        onClicked: {
                            writeFileDialog.open()
                        }
                        Material.background: Material.Amber
                    }
                    MyButton{
                        id:copyButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"复制"
                        fontsize: 30
                        Material.background: Material.Green
                        onClicked: {
                            outputBox.selectAll()
                            outputBox.copy()
                            outputBox.deselect()
                        }

                    }
                }
                MyButton{
                    id:textExportQuitButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    content:"返回"
                    fontsize: 30
                    Material.background:Material.Red
                    onClicked: {
                        controlPanel.exportOpen=false
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

