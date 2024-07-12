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

    ColumnLayout{
//        anchors.fill: parent
        anchors.centerIn: parent
        Button {
            id: btn1
            text: "asdf"
            onClicked: {
                toBattle();
                isNetGame = false}
        }

        Button {
            id: btn2
            text: "ljdz"
            onClicked: {
                toNet();
                isNetGame = true
                console.log(isNetGame)
            }
        }
    }


}
