import QtQuick
import QtQuick.Controls
Rectangle {
        width: parent.width
        height: parent.height
        signal selectCharacter
        GameMap{
            id:startmap
        }
    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "选择角色"
            font.pixelSize: 30
        }


        // 角色选择下拉框
        ComboBox {
            id: characterComboBox
            editable: false
            currentIndex: 0
            model: ["角色1", "角色2", "角色3"]

            onCurrentTextChanged: {
                console.log("选择了角色:", currentText)
            }
        }

        Button {
            text: "确认"
            onClicked: {
                selectCharacter()
                console.log("确认选择的角色:", characterComboBox.currentText)
            }
        }
    }
     signal startBattle
    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "选择地图"
            font.pixelSize: 30
        }

        // 地图选择控件
        Button {
            text: "开始战斗"
            onClicked: startBattle()
        }
    }
 }
