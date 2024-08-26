

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
import WriteFileObject
import ReadFileObject
import GraphModel
import PersonNode
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
    Keys.forwardTo: [menu,importPage,exportPage,heapShower,controlPanel,returnButton,heapTable,graphView,quitBotton]
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
                ScrollBar.horizontal: ScrollBar {
                    id: heapScrollBar
                    visible: false
                }
            }
    }
    Pane {
        id: controlPanel
        z: 3
        y: 903
        height: 100
        visible:  mainWindow.state === "home" ? false : true
        Material.background: Material.color(Material.BlueGrey,Material.Shade300)
        Material.roundedScale: Material.NotRounded
        Material.elevation:10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        Keys.forwardTo: [returnButton]
        property bool importOpen: false
        property bool exportOpen: false
        property bool addOpen: false
        property bool infoOpen: false
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
            visible: mainWindow.state === 'algo'
            content: ""
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
            Image {
                source: "images/import.svg"
                anchors.fill: parent
            }
        }

        MyButton {
            id: exportButton
            width: exportButton.height
            visible: mainWindow.state === 'algo'
            content: ""
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
                outputBox.text=WriteFileObject.result()
            }
            Image {
                source: "images/export.svg"
                anchors.fill: parent
            }
        }
        MyButton {
            id: addButton
            width: addButton.height
            visible: mainWindow.state === 'app'
            content: "+"
            fontsize:60
            color:Material.Blue
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            onClicked: {
                controlPanel.addOpen=true
               // console.log(graphView.width,graphView.height,mainWindow.width,mainWindow.height)
            }
        }
        MyButton {
            function startBottonText(){
                if(HeapModel.finished){
                    return 'COMPLETE!';
                }else if(HeapModel.pause){
                    return '▶';
                }else{
                    return "";
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
            Image{
                source: 'images/stop.svg'
                anchors.centerIn: parent
                visible: !(HeapModel.finished||HeapModel.pause)
                scale: 0.30
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
        TextField {
            id: searchBar
            width: 240
            visible:mainWindow.state==="app"
            Material.accent: Material.Pink
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            placeholderText: "人员编号或姓名"
            placeholderTextColor: '#000000'
            font.pixelSize: 20
            font.styleName: "Bold"
            font.family: "Microsoft YaHei"
            maximumLength: 17
            font.bold: true
        }
        // function loadInfo(node){
        //     idfield.text='#'+node.label
        //     nameField.text=node.name
        //     ageField.text = node.age
        //     if(node.gender===PersonNode.Male){
        //         genderField.currentIndex= 0
        //     }else if(node.gender===PersonNode.Female){
        //         genderField.currentIndex=1
        //     }else{
        //         genderField.currentIndex=2
        //     }
        //     schoolField.text = node.school
        //     companyField.text = node.company
        //     mottoField.text =node.motto
        // }
        MyButton {
            id: infoButton
            width: height
            content: ""
            property var node:undefined
            visible:mainWindow.state==="app"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            fontsize: 60
            color:Material.Pink
            anchors.right:searchBar.left
            Image {
                source: "images/info.svg"
                anchors.centerIn: parent
                scale:0.3
            }
            onClicked: {
                if(parseInt(searchBar.text)>=0&&graph.isValid(parseInt(searchBar.text))){
                    console.log('find node')
                    node=graph.getNode(parseInt(searchBar.text))

                    graph.initFriendTable(Number(node.label))
                    listModel1 = graph.getFriendListModel()
                    listModel2 = graph.getStrangerListModel()

                    graph.clearSelection()
                    graph.setNodeSelected(node,true)
                    graph.setConnectorSource(node)
                    graphView.centerOn(node.item)


                    idfield.text='#'+node.label+'\n'+node.name
                    ageField.text = node.age===-1?'':node.age
                    if(node.gender===PersonNode.Male){
                        genderField.currentIndex= 0
                    }else if(node.gender===PersonNode.Female){
                        genderField.currentIndex=1
                    }else{
                        genderField.currentIndex=2
                    }
                    schoolField.text = node.school
                    companyField.text = node.company
                    mottoField.text =node.motto


                    controlPanel.infoOpen = true
                }else{
                    var result=graph.findNode(searchBar.text)
                    if(result!==-1){

                        node = graph.getNode(result)

                        graph.initFriendTable(Number(node.label))
                        listModel1 = graph.getFriendListModel()
                        listModel2 = graph.getStrangerListModel()

                        graph.clearSelection()
                        graph.setNodeSelected(node,true)
                        graph.setConnectorSource(node)
                        graphView.centerOn(node.item)



                        idfield.text='#'+node.label+'\n'+node.name
                        ageField.text = node.age===-1?'':node.age
                        if(node.gender===PersonNode.Male){
                            genderField.currentIndex= 0
                        }else if(node.gender===PersonNode.Female){
                            genderField.currentIndex=1
                        }else{
                            genderField.currentIndex=2
                        }
                        schoolField.text = node.school
                        companyField.text = node.company
                        mottoField.text =node.motto




                        controlPanel.infoOpen = true
                        console.log('find node')
                    }else if(graph.hasSelection()){

                        node = graph.getSelectedNode()

                        graph.initFriendTable(Number(node.label))
                        listView1.model = graph.getFriendListModel()
                        listView2.model = graph.getStrangerListModel()

                        graph.setConnectorSource(node)
                        graphView.centerOn(node.item)




                        idfield.text='#'+node.label+'\n'+node.name
                        ageField.text = node.age===-1?'':node.age
                        if(node.gender===PersonNode.Male){
                            genderField.currentIndex= 0
                        }else if(node.gender===PersonNode.Female){
                            genderField.currentIndex=1
                        }else{
                            genderField.currentIndex=2
                        }
                        schoolField.text = node.school
                        companyField.text = node.company
                        mottoField.text =node.motto




                        controlPanel.infoOpen = true
                    }
                    else{
                        console.log('locate failed')
                        graph.notifyUser('您搜索的用户不存在！')
                        graphView.centerOnPosition(Qt.point(0,0))
                    }
                }
                searchBar.text = ''
            }
        }
        DelayButton {
            id: deletetButton
            width: height
            text:""
            visible:mainWindow.state==="app"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.right:addButton.left
            font.family: "Microsoft YaHei"
            font.pixelSize: 50
            font.bold: true
            font.weight: Font.Black
            display: AbstractButton.TextOnly
            Material.background: Material.Red
            Material.roundedScale: Material.SmallScale
            Material.elevation: 10
            delay:1000
            Image {
                source: "images/delete.svg"
                anchors.fill: parent
                scale: 0.6
            }
            onActivated: {
                progress = 0
                if(graph.hasSelection()){
                    var node=graph.getSelectedNode()
                    graph.notifyUser('已删除用户#'+node.label+':'+node.name+'！')
                    graph.removeSelection()
                }else{
                    graph.notifyUser('您尚未选中任何用户！')
                }
            }
        }
        MyButton {
            id: loacteButton
            width: height
            content: ""
            visible:mainWindow.state==="app"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            fontsize: 60
            color:Material.Pink
            anchors.left:startButton.right
            Image {
                source: "images/locate.svg"
                anchors.centerIn: parent
                scale: 0.25
            }
            onClicked: {
                if(parseInt(searchBar.text)>=0&&graph.isValid(parseInt(searchBar.text))){
                    console.log('find node')
                    var node=graph.getNode(parseInt(searchBar.text))
                    graph.clearSelection()
                    graph.setNodeSelected(node,true)
                    graph.setConnectorSource(node)
                    graphView.centerOn(node.item)
                    graph.notifyUser('选中用户#'+node.label+':'+node.name)
                }else{
                    var result=graph.findNode(searchBar.text)
                    if(result!==-1){
                        var node1 = graph.getNode(result)
                        graph.clearSelection()
                        graph.setNodeSelected(node1,true)
                        graph.setConnectorSource(node1)
                        graphView.centerOn(node1.item)
                        graph.notifyUser('选中用户#'+node1.label+':'+node1.name)
                        console.log('find node')
                    }else{
                        console.log('locate failed')
                        graph.notifyUser('您搜索的用户不存在！')
                        graphView.centerOnPosition(Qt.point(0,0))
                    }
                }
                searchBar.text = ''
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
    Qan.GraphView {
      id: graphView
      property int centerX:mainWindow.width/2
      property int centerY:mainWindow.height/2
      property int length:300
      property real lastX:0
      property real lastY:0
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
          property int number:0//当前有的结点数
          property int level :0//当前有的层数
          //selectionPolicy: Qan.Graph.SelectOnClick //选择，可以用于选择详细说明的用户
          //connectorEnabled: true //允许通过拖拽生成新边
          function addTestNode(name){
              var node = graph.insertCustomNode()
              node.label = graph.number
             // console.log(graph.number,graph.level)

              if(graph.number===0){
            //      console.log('case 1')
                  node.item.x = 0
                  node.item.y = 0
                  graphView.centerOnPosition(Qt.point(0,0))
              }else if(graph.number === 3*(graph.level-1)*(graph.level)+1){//该层的第一个
              //    console.log('case 2')
                  node.item.x = graphView.length*graph.level
                  node.item.y = 0
              }else{
                  var i = Math.floor((graph.number - (3*(graph.level-1)*(graph.level)+1)-1)/graph.level)
            //      console.log('case 3',i,(120+60*i)*Math.PI/360)
                  node.item.x = graphView.lastX+graphView.length*Math.cos((120+60*i)*Math.PI/180)
                  node.item.y = graphView.lastY-graphView.length*Math.sin((120+60*i)*Math.PI/180)

              }

              if(graph.number === 3*graph.level*(graph.level+1)){//该层的最后一个
           //       console.log('last')
                  graph.level += 1
              }
              graphView.lastX = node.item.x
              graphView.lastY = node.item.y
              graph.number += 1

              node.name = name
          }
          Component.onCompleted: {    // Qan.Graph.Component.onCompleted()
                 //defaultEdgeStyle.lineType = Qan.EdgeStyle.Curved
              defaultEdgeStyle.srcShape = Qan.EdgeStyle.None
              defaultEdgeStyle.dstShape = Qan.EdgeStyle.None
             defaultEdgeStyle.lineType=Qan.EdgeStyle.Curved
              //defaultEdgeStyle.lineColor = Qt.rgba(1,0,0,1)
             selectionPolicy: Qan.Graph.SelectOnClick

              addTestNode("一")
              addTestNode("二")
              addTestNode("三")
              addTestNode("四")
              // addTestNode("五")
              // addTestNode("六")
              // addTestNode("七")
              // addTestNode("八")
              // addTestNode("九")
              // addTestNode("十")
              // addTestNode("十一")
              // addTestNode("十二")
              // addTestNode("十三")
              // addTestNode("十四")
              // addTestNode("十五")


          }

         connectorEnabled: true
         connectorItem : Control {
             id:connectorControl
             anchors.fill: parent
             hoverEnabled: true
             visible: false              // SAMPLE: Do not forget to hide the custom connector item by default, visual connector will set visible to true on demand
             onStateChanged: {
                 connectorToolTip.text = ( state === "HILIGHT" ?  "松开以建立关系" :"拖拽至目标用户" )
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
                 ToolTip{
                     id:connectorToolTip
                     Material.background: Material.Pink
                     font.pixelSize: 20
                     font.family: "Microsoft YaHei"
                     font.styleName: "Bold"
                     font.weight: Font.Black
                     font.bold: true
                     visible: connectorControl.hovered&&( !graph.connectorDragged || state === "HILIGHT" )
                 }
             }
         }
          function notifyUser(message) {
              toolTip.text=message;
              toolTip.open()
          }
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
          }
          onNodeRightClicked: (node) => { notifyUser( "Node <b>" + node.label + "</b> right clicked" ) }
          onNodeDoubleClicked: (node) => { notifyUser( "Node <b>" + node.label + "</b> double clicked" ) }
          onNodeMoved: (node) => { notifyUser("Node <b>" + node.label + "</b> moved") }
          onConnectorEdgeInserted: (edge) => {
                                       notifyUser("Edge inserted: " + getEdgeDescription(edge))

                                   }
          onConnectorRequestEdgeCreation: (src, dst) => { notifyUser("Requesting Edge creation from " + src.label + " to " + ( dst ? dst.label : "UNDEFINED" ) ) }
         // onEdgeClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " clicked") }
         // onEdgeDoubleClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " double clicked") }
         // onEdgeRightClicked: (edge) => { notifyUser("Edge " + edge.label + " " + getEdgeDescription(edge) + " right clicked") }
        } // Qan.Graph: topology
      ToolTip {
          id: toolTip
          timeout: 2500
          x:mainWindow.width/2-width/2
          y:mainWindow.height/5-height/2
          Material.background: Material.Pink
          font.pixelSize: 20
          font.family: "Microsoft YaHei"
          font.styleName: "Bold"
          font.weight: Font.Black
          font.bold: true
      }
 // Frame: nodesListView
      //onRightClicked: function(pos) {
        //  contextMenu.open()
      //}
    } // Qan.GraphView    Qan.Graph {
    Pane {
        id:graphNodeListView
        width:250
        visible: parent.state==='app'
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom:controlPanel.top
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin:0
        leftPadding: 0; rightPadding: 0
        topPadding: 0;  bottomPadding: 0
        padding: 0
        Material.roundedScale: Material.NotRounded
        Material.elevation: 10
        Material.background:'#b0bec5'
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            Label {
                Layout.margins: 3
                text: "人员名单:"
                font.bold: true
                font.pixelSize: 30
                font.family: "Microsoft YaHei"
                font.styleName: "Bold"
                font.weight: Font.Black
            }
            NodesListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: graph.nodes
                graphView: graphView
                graph:graph
            }
        }
    }
    Rectangle {
        id: bluredBackground
        z:5
        visible: controlPanel.questionOpen || controlPanel.importOpen || controlPanel.exportOpen || controlPanel.addOpen || controlPanel.infoOpen
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
        FileDialog {
            id: readFileDialog
            folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
            onAccepted: {
                ReadFileObject.source = readFileDialog.file
                inputBox.text = ReadFileObject.read()
            }
            nameFilters: ["Text files (*.txt)"]
        }
        FileDialog {
            id: writeFileDialog
            folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
            onAccepted: {
                WriteFileObject.source = writeFileDialog.file
                WriteFileObject.write(outputBox.text)
            }
            nameFilters: ["Text files (*.txt)"]
        }
        Pane {
            id: importPage
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
                    spacing:10
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
                            if(parseInt(inputBox.text)<=0 ||parseInt(inputBox.text)>=0){
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
                            }else{
                                inputBox.text = ''
                                graph.notifyUser('输入的数组不能为空！')
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
                    spacing:10
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
        Pane {
            id: addPage
            function clearInfo(){
                nameTextField.text = ''
                ageTextField.text = ''
                genderComboBox.currentIndex = 0
                schoolTextField.text = ''
                companyTextField.text = ''
                mottoTextField.text = ''
            }
            function addNewNode(){
                var node = graph.insertCustomNode()
                node.label = graph.number
               // console.log(graph.number,graph.level)

                if(graph.number===0){
              //      console.log('case 1')
                    node.item.x = 0
                    node.item.y = 0
                    graphView.centerOnPosition(Qt.point(0,0))
                }else if(graph.number === 3*(graph.level-1)*(graph.level)+1){//该层的第一个
                //    console.log('case 2')
                    node.item.x = graphView.length*graph.level
                    node.item.y = 0
                }else{
                    var i = Math.floor((graph.number - (3*(graph.level-1)*(graph.level)+1)-1)/graph.level)
              //      console.log('case 3',i,(120+60*i)*Math.PI/360)
                    node.item.x = graphView.lastX+graphView.length*Math.cos((120+60*i)*Math.PI/180)
                    node.item.y = graphView.lastY-graphView.length*Math.sin((120+60*i)*Math.PI/180)

                }

                if(graph.number === 3*graph.level*(graph.level+1)){//该层的最后一个
             //       console.log('last')
                    graph.level += 1
                }
                graphView.lastX = node.item.x
                graphView.lastY = node.item.y
                graph.number += 1

                node.name = nameTextField.text
                if(ageTextField.text==''){
                    node.age = -1
                }else{
                    node.age = parseInt(ageTextField.text)
                }
                if(genderComboBox.currentIndex==0){
                    node.gender = PersonNode.Male
                }else if(genderComboBox.currentIndex == 1){
                    node.gender = PersonNode.Female
                }else{
                    node.gender = PersonNode.Other
                }
                node.school = schoolTextField.text
                node.company = companyTextField.text
                node.motto = mottoTextField.text
            }
            width: 400
            height: 700
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Material.background: Material.color(Material.Teal,Material.Shade100)
            Material.elevation: 10
            visible: controlPanel.addOpen
            focus: controlPanel.addOpen
            ColumnLayout{
                Material.accent: Material.Teal
                anchors.fill: parent
                spacing:10
                Label{
                    text: '#'+graph.number
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: 40
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.NoWrap
                    font.family: "Microsoft YaHei"
                    font.styleName: "Bold"
                    font.weight: Font.Black
                    font.bold: true
                }
                MyTextField{
                    id:nameTextField
                    prompt: '姓名'
                    validator: RegularExpressionValidator{regularExpression:/^[^\d]*$/}
                    maximumLength: 17
                }
                MyTextField{
                    id:ageTextField
                    prompt: '年龄'
                    validator:IntValidator{bottom:0;top:120;}
                }
                ComboBox{
                    id:genderComboBox
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    model:['男','女','其他']
                    font.pixelSize: 20
                    font.family: "Microsoft YaHei"
                    font.styleName: "Bold"
                    font.weight: Font.Black
                    font.bold: true
                }
                MyTextField{
                    id:schoolTextField
                    prompt: '就读学校'
                    maximumLength: 17
                }
                MyTextField{
                    id:companyTextField
                    prompt: '工作单位'
                    maximumLength: 17
                }
                MyTextField{
                    id:mottoTextField
                    prompt: '个性签名(17字以内)'
                    maximumLength: 17
                }

                MyButton{
                    id:addNextPersonButton
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    content:"确认并添加下一位"
                    Material.background: Material.Amber
                    fontsize: 30
                    onClicked: {
                        if(nameTextField.text==''){
                            graph.notifyUser("姓名不能为空！")
                        }else{
                            addPage.addNewNode()
                            addPage.clearInfo()
                        }
                    }
                }

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing:10
                    MyButton{
                        id:addCancelButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"取消"
                        fontsize: 30
                        Material.background: Material.Red
                        onClicked: {
                            controlPanel.addOpen = false
                            addPage.clearInfo()
                        }
                    }
                    MyButton{
                        id:addCheckButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"确认"
                        Material.background: Material.Green
                        fontsize: 30
                        onClicked: {
                            if(nameTextField.text==''){
                                graph.notifyUser("姓名不能为空！")
                            }else{
                                controlPanel.addOpen = false
                                addPage.addNewNode()
                                addPage.clearInfo()
                            }
                        }
                    }
                }
            }
        }
        Pane {
            id: infoPage
            width: 850
            height: 600
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Material.background: Material.color(Material.Teal,Material.Shade100)
            Material.elevation: 10
            visible: controlPanel.infoOpen
            focus: controlPanel.infoOpen
            RowLayout{
                anchors.fill: parent
                spacing: 0
                ColumnLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.accent: Material.Teal
                    Layout.preferredWidth: 400
                    spacing:10
                    Label{
                        id:idfield
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.pixelSize: 40
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                        font.family: "Microsoft YaHei"
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        font.bold: true
                    }
                    MyTextField{
                        id:ageField
                        readOnly: true
                        prompt: '年龄'
                        validator:IntValidator{bottom:0;top:120;}
                    }
                    ComboBox{
                        id:genderField
                        enabled: false
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        model:['男','女','其他']
                        font.pixelSize: 20
                        font.family: "Microsoft YaHei"
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        font.bold: true
                    }
                    MyTextField{
                        id:schoolField
                        readOnly: true
                        prompt: '就读学校'
                        maximumLength: 17
                    }
                    MyTextField{
                        id:companyField
                        readOnly: true
                        prompt: '工作单位'
                        maximumLength: 17
                    }
                    MyTextField{
                        id:mottoField
                        readOnly: true
                        prompt: '个性签名'
                        maximumLength: 17
                    }
                    MyButton{
                        id:editButton
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        content:"编辑个人信息"
                        Material.background: Material.Green
                        fontsize: 30
                        onClicked: {
                            ageField.readOnly=false
                            genderField.enabled=true
                            schoolField.readOnly=false
                            companyField.readOnly=false
                            mottoField.readOnly=false
                        }
                    }
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing :10
                        MyButton{
                            id:infoReturnButton
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            content:"返回"
                            fontsize: 30
                            Material.background: Material.Red
                            onClicked: {
                                controlPanel.infoOpen = false
                                ageField.readOnly=true
                                genderField.enabled=false
                                schoolField.readOnly=true
                                companyField.readOnly=true
                                mottoField.readOnly=true
                                infoButton.node.age = parseInt(ageField.text)
                                if(genderField.currentIndex==0){
                                    infoButton.node.gender = PersonNode.Male
                                }else if(genderComboBox.currentIndex == 1){
                                    infoButton.node.gender = PersonNode.Female
                                }else{
                                    infoButton.node.gender = PersonNode.Other
                                }
                                infoButton.node.school = schoolField.text
                                infoButton.node.company = companyField.text
                                infoButton.node.motto = mottoField.text
                                infoButton.node = undefined
                            }
                        }
                        DelayButton {
                            id: deletetInfoButton
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text:"    "
                            Material.foreground: Material.Amber
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 50
                            font.bold: true
                            font.weight: Font.Black
                            display: AbstractButton.TextOnly
                            Material.background: Material.Amber
                            Material.roundedScale: Material.SmallScale
                            Material.elevation: 10
                            delay:1000
                            Image{
                                anchors.centerIn: parent
                                source: 'images/delete.svg'
                                fillMode: Image.Pad
                                scale:0.2
                            }
                            onActivated: {
                                progress = 0
                                graph.notifyUser('已删除用户#'+infoButton.node.label+':'+infoButton.node.name+'！')
                                graph.removeNode(infoButton.node,true)
                                ageField.readOnly=true
                                genderField.enabled=false
                                schoolField.readOnly=true
                                companyField.readOnly=true
                                mottoField.readOnly=true
                                infoButton.node = undefined
                                controlPanel.infoOpen = false
                            }
                        }
                    }
                }
                ToolSeparator{
                    Layout.fillHeight: true
                }
                ListView {
                    Layout.preferredWidth:200
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip:true
                    id: listView1
                    header:Label{
                        text: '好友列表'
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                        font.family: "Microsoft YaHei"
                        Layout.fillWidth: true
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        Layout.fillHeight: true
                        font.bold: true
                        visible: listView1.count!=0
                    }

                    delegate: SwipeDelegate {
                        id: delegate1
                        width:listView1.width
                        text: model.name

                        swipe.left: Rectangle {
                            width: parent.width
                            height: parent.height
                            clip: true
                            color: SwipeDelegate.pressed ? Material.color(Material.BlueGrey,Material.Shade300):Material.color(Material.BlueGrey,Material.Shade200)
                            Label {
                                text: delegate1.swipe.complete ? '' // icon-cw-circled
                                                              : "右滑以删除好友" // icon-cancel-circled-1

                                color: "black"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 15
                                padding: 20
                                anchors.fill: parent
                                horizontalAlignment: Qt.AlignLeft
                                verticalAlignment: Qt.AlignVCenter
                                opacity: delegate1.swipe.complete ? 0 : 1
                                Behavior on opacity { NumberAnimation { } }
                            }
                            Label {
                                text: "已删除"
                                color: "black"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 15
                                padding: 20
                                anchors.fill: parent
                                horizontalAlignment: Qt.AlignRight
                                verticalAlignment: Qt.AlignVCenter

                                opacity: delegate1.swipe.complete ? 1 : 0
                                Behavior on opacity { NumberAnimation { } }
                            }
                        }

                        Timer {
                            id: undoTimer1
                            interval: 1000
                            onTriggered: listModel1.remove(index)
                        }

                        swipe.onCompleted: undoTimer1.start()
                    }



                    remove: Transition {
                        SequentialAnimation {
                            PauseAnimation { duration: 125 }
                            NumberAnimation { property: "height"; to: 0; easing.type: Easing.InOutQuad }
                        }
                    }

                    displaced: Transition {
                        SequentialAnimation {
                            PauseAnimation { duration: 125 }
                            NumberAnimation { property: "y"; easing.type: Easing.InOutQuad }
                        }
                    }

                    ScrollIndicator.vertical: ScrollIndicator {visible:false}
                    Label {
                        id: placeholder1
                        text: '好友列表为空！'

                        font.pixelSize: 20
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        wrapMode: Label.NoWrap
                        font.family: "Microsoft YaHei"
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        font.bold: true

                        anchors.margins: 60
                        anchors.fill: parent

                        opacity: 0.5
                        visible: listView1.count === 0

                    }
                }
                ToolSeparator{
                    Layout.fillHeight: true
                }
                ListView {
                    id: listView2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip:true
                    Layout.preferredWidth: 200
                    header:Label{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: '待添加好友'
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                        font.family: "Microsoft YaHei"
                        Layout.fillWidth: true
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        Layout.fillHeight: true
                        font.bold: true
                        visible:listView2.count!==0
                    }
                    delegate: SwipeDelegate {
                        id: delegate2

                        text: model.name
                        width:listView2.width
                        swipe.right: Rectangle {
                            width: parent.width
                            height: parent.height
                            clip: true
                            color: SwipeDelegate.pressed ? Material.color(Material.BlueGrey,Material.Shade300):Material.color(Material.BlueGrey,Material.Shade200)

                            Label {
                                text: delegate2.swipe.complete ? '' // icon-cw-circled
                                                              : "左滑以添加好友" // icon-cancel-circled-1

                                color: "black"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 15
                                padding: 20
                                anchors.fill: parent
                                horizontalAlignment: Qt.AlignRight
                                verticalAlignment: Qt.AlignVCenter
                                opacity: delegate2.swipe.complete ? 0 : 1
                                Behavior on opacity { NumberAnimation { } }
                            }

                            Label {
                                text: "已添加"
                                color: "black"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 15
                                padding: 20
                                anchors.fill: parent
                                horizontalAlignment: Qt.AlignLeft
                                verticalAlignment: Qt.AlignVCenter

                                opacity: delegate2.swipe.complete ? 1 : 0
                                Behavior on opacity { NumberAnimation { } }
                            }
                        }

                        Timer {
                            id: undoTimer2
                            interval: 1000
                            onTriggered: listModel2.remove(index)
                        }

                        swipe.onCompleted: undoTimer2.start()
                    }


                    remove: Transition {
                        SequentialAnimation {
                            PauseAnimation { duration: 125 }
                            NumberAnimation { property: "height"; to: 0; easing.type: Easing.InOutQuad }
                        }
                    }

                    displaced: Transition {
                        SequentialAnimation {
                            PauseAnimation { duration: 125 }
                            NumberAnimation { property: "y"; easing.type: Easing.InOutQuad }
                        }
                    }

                    ScrollIndicator.vertical: ScrollIndicator { }
                    Label {
                        id: placeholder2
                        text: '所有用户\n都已是您的好友！'

                        font.pixelSize: 20
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        wrapMode: Label.NoWrap
                        font.family: "Microsoft YaHei"
                        font.styleName: "Bold"
                        font.weight: Font.Black
                        font.bold: true

                        anchors.margins: 60
                        anchors.fill: parent

                        opacity: 0.5
                        visible: listView2.count === 0
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

