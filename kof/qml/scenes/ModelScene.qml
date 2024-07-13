import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import "../common"

// EMPTY SCENE

Scene {

    property bool isNetGame: false
    signal toNet
    signal toBattle
    GameMap{

    }
    anchors.fill: parent

    ColumnLayout{
        anchors.centerIn: parent
        Button {
            id: btn1
            text: "双人对战"
            onClicked: {
                toBattle();
                isNetGame = false}
        }

        Button {
            id: btn2
            text: "联机模式"
            onClicked: {
                toNet();
                isNetGame = true
                console.log(isNetGame)
            }
        }
    }


}
