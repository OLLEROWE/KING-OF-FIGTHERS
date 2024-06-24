import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../common"

Rectangle {
    signal startBattle
    width: parent.width
    height: parent.height
    color: "#000000" // 拳皇97风格的背景色

    property int countdown: 60 // 倒计时的初始值

    Timer {
        id: countdownTimer
        interval: 1000 // 每秒触发一次
        repeat: true
        running: true
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
        width:parent.width*0.6
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

        // 角色选择控件 - 九宫格布局
        GridLayout {
            id: grid
            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            anchors.horizontalCenter: parent.horizontalCenter

            // 每个角色按钮，带有头像和名称
            Repeater {
                model: 9 // 假设有9个角色
                delegate: Button {
                    width: parent.width / 4.5 // 动态调整大小
                    height: parent.width / 4.5 * 1.3 // 图片高度 + 按钮高度比例
                    Layout.alignment: Qt.AlignCenter

                    contentItem: ColumnLayout {
                        Image {
                            source: "../../assets/img/selection/" + (index + 1) + ".jpg"
                            width: parent.width / 4.5
                            height: parent.width / 4.5
                            fillMode: Image.PreserveAspectFit
                        }
                        Text {
                            text: "角色" + (index + 1)
                            width: parent.width / 4.5
                            height: parent.helght
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    background: Rectangle {
                        color: "#fff"
                        border.color: control.checked ? "#ff0000" : "#ffffff" // 选中时红色边框
                        border.width: 4
                    }

                    onClicked: {
                        // Add selection logic here
                    }
                }
            }
        }

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
    Text {
        text: "PLAYER1"
        color: "#ffffff"
        font.pixelSize: 24
        font.bold: true
        anchors.verticalCenter: grid.verticalCenter // 与九宫格垂直对齐
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Text {
        text: "PLAYER2"
        color: "#ffffff"
        font.pixelSize: 24
        font.bold: true
        anchors.verticalCenter: grid.verticalCenter // 与九宫格垂直对齐
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}
