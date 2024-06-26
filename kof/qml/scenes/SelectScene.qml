import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../common"

Rectangle {

    signal startBattle
    width: parent.width
    height: parent.height
    color: "#000000" // 拳皇97风格的背景色

    property int countdown: 600 // 倒计时的初始值
    property var characterNames: ["Andy", "Chizuru", "Goro", "Joe", "Kula", "Kyo", "Iori", "Ryuji", "Mai"]  //角色名称数组
    property int currentPlayer: 1
    property int currentSelection: -1 // 当前选择的角色 (0-8 对应九宫格的索引)
    property int player1Selection: -1 // Player1 选择的角色 (-1 表示未选择)
    property int player2Selection: -1 // Player2 选择的角色 (-1 表示未选择)
    property string player1SelectionName: "Kyo.qml" // 初始化为 Kyo.qml
    property string player2SelectionName: "Kyo.qml" // 初始化为 Kyo.qml

    onVisibleChanged: {
        if (visible) {
            countdownTimer.start()
        } else {
            countdownTimer.stop()
        }
    }
    function a(){

        console.log(player1SelectionName)

    }
    Timer {
        id: countdownTimer
        interval: 1000 // 每秒触发一次
        repeat: true
        running: false
        onTriggered: {
            countdown--
            if (countdown <= 0) {
                countdownTimer.stop()
                startBattle()
            }
        }
    }
    // 中央布局
    Column {
        anchors.centerIn: parent
        spacing: 10
        width:parent.width*0.3
        height:parent.height*0.8

        // "TIME" 文本
        Text {
            text: "TIME"
            color: "#ffffff"
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // 倒计时显示
        Text {
            text: countdown + "s"
            color: "#ff0000" // 倒计时的文字颜色
            font.pixelSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        RowLayout {
             anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width+200
            height: parent.height - 120  // 剩余的高度用于 GridView
            Rectangle {

                       width: 100
                       height: 100
                       color: "lightgrey"
                       visible: gridView.currentIndex >= 0  // 只有在有选中项时显示
                       Image {
                           id:play1
                           anchors.fill: parent
                           source: ""
                           fillMode: Image.PreserveAspectFit
                       }
                   }
        GridView {
           // anchors.horizontalCenter: parent.horizontalCenter

            id: gridView
            width: parent.width-100
            height: parent.height - 120  // 剩余的高度用于 GridView
            //anchors.fill: parent

            model: 9 // 九宫格总数


            delegate: Rectangle {
                width: gridView.cellWidth - 10
                height: gridView.cellHeight - 10
                color: "lightblue"
                border.color: "blue"
                border.width: 2
                radius: 10


                property int index: index
                property string imageName: {
                    var imagePath = "../../assets/img/selection/" + (model.index + 1) + ".jpg";
                    console.log("Index:", model.index, "ImagePath:", imagePath);
                    return imagePath;
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Single click: ", imageName)
                        gridView.previewImage(imageName)
                    }
                    onDoubleClicked: {
                        console.log("Double click: ", imageName)
                        player1SelectionName=characterNames[model.index]
                        console.log("aaaadadawdaw        "+player1SelectionName)
                        gridView.selectImage(imageName)
                    }
                }

                Image {
                    anchors.centerIn: parent
                    source: imageName
                    width: parent.width * 0.8
                    height: parent.height * 0.8
                    fillMode: Image.PreserveAspectFit
                }
            }

            function previewImage(imageName) {
                play1.source=imageName
                opacityAnimation.running = false
                // 处理预览图片逻辑，例如放大显示或者其他操作
                console.log("Preview image: ", imageName)
            }

            function selectImage(imageName) {
                play1.source=imageName
                opacityAnimation.running =true

                // 处理选择图片逻辑，例如确定选择并获取名称
                console.log("Selected image name: ", imageName)
                // 在这里你可以进行其他操作，例如保存选择的图片等
            }
        }
        PropertyAnimation {
                   id: opacityAnimation
                   target:play1
                   property: "opacity"
                   to: 0.5  // 动画目标透明度
                   duration: 800  // 动画持续时间，单位毫秒（0.3 秒）
                   loops: Animation.Infinite  // 无限循环动画
                   running: false  // 开始动画

               }
        // 右侧放大版图片
              Rectangle {
                  width: 100
                  height: 100
                  color: "lightgrey"
                  visible: gridView.currentIndex >= 0  // 只有在有选中项时显示
                  Image {
                      anchors.fill: parent
                      source: gridView.currentIndex >= 0 ? "../../assets/img/selection/" + (gridView.currentIndex + 1) + ".jpg" : ""
                      fillMode: Image.PreserveAspectFit
                  }
              }

        }
        // 角色选择控件 - 九宫格布局
        /*GridLayout {
            id: grid
            columns: 3
            rowSpacing: 10
            columnSpacing: 10
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            // 每个角色按钮，带有头像和名称
            Repeater {
                model: characterNames
                delegate: Button {
                    width: parent.width / 3 // 动态调整大小
                    height: parent.width / 3 * 1.3 // 图片高度 + 按钮高度比例
                    Layout.alignment: Qt.AlignCenter

                    contentItem: ColumnLayout {
                        Image {
                            source: "../../assets/img/selection/" + (index + 1) + ".jpg"
                            width: parent.width / 4.5
                            height: parent.width / 4.5
                            fillMode: Image.PreserveAspectFit
                        }
                        Text {
                            text:modelData
                            font.bold: true
                            width: parent.width / 4.5
                            height: parent.height
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    background: Rectangle {
                        color: "#fff"
                        border.color: index === currentSelection ? (currentPlayer === 1 ? "#ff0000" : "#0000ff") : "#ffffff" // 选中时红色或蓝色边框
                        border.width: index === currentSelection ? 4: 0
                    }
                    onClicked: {
                        console.log("Button clicked for index:", index)
                        if (currentPlayer === 1) {
                            player1SelectionName = modelData
                        } else {
                            player2SelectionName = modelData
                        }

                    }
                }

            }*/



            // 开始游戏按钮
            Button {
                text: "开始游戏"
                width: parent.width / 3
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {

                    countdownTimer.stop() // 停止计时器

                    startBattle()
                }
            }

        }


    // 左上角 "MEMBER SELECT"
    Text {
        text: "MEMBER SELECT"
        color: "#ffffff"
        font.pixelSize: 24
        font.bold: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
    }

    // 左右两边的 "PLAYER1, PLAYER2"

    Column {
        anchors.verticalCenter: grid.verticalCenter // 与九宫格垂直对齐
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: parent.height / 3

        Text {
            text: "PLAYER1"
            color: "#ffffff"
            font.pixelSize: 24
            font.bold: true
        }

        Text {
            text: player1Selection >= 0 ? "选择: 角色" + (player1Selection + 1) : "未选择"
            color: "#ffffff"
            font.pixelSize: 20
            font.bold: true
        }
        }




    Column {
        anchors.verticalCenter: grid.verticalCenter // 与九宫格垂直对齐
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: parent.height / 3

        Text {
            text: "PLAYER2"
            color: "#ffffff"
            font.pixelSize: 24
            font.bold: true

        }

        Text {
            text: player2Selection >= 0 ? "选择: 角色" + (player2Selection + 1) : "未选择"
            color: "#ffffff"
            font.pixelSize: 20
            font.bold: true
        }
        }



}
