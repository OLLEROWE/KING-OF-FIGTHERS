import QtQuick
import QtQuick.Controls

Rectangle {
    width: parent.width
    height: parent.height
    GameMap{
        id:startmap
    }
    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "游戏设置"
            font.pixelSize: 30
        }

        // 添加各种设置控件
        Button {
            text: "返回"
            onClicked: stackView.pop()
        }
    }
}
