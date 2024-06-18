
import QtQuick
import QtQuick.Controls
import Felgo
import "../entities"
import "../common"


Scene {

//    property alias player1: player1
    signal startGame
    anchors.fill: parent
    Column {
        spacing: 20
        anchors.centerIn: parent

        Button {
            text: "开始游戏"
            onClicked: startGame()
        }

        Button {
            text: "设置"
            onClicked: openSettings()
        }
        Button {
            text: "退出游戏"
            onClicked: Qt.quit()
        }
    }

}
