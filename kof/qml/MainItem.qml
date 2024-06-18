import QtQuick
import Felgo

import "scenes"
Rectangle{
    anchors.fill: parent
    Loader{
        id:loader
        anchors.fill: parent
        source: "scenes/StartScene.qml"
        focus:true
    }
    Connections{
        target: loader.item
        function onStartGame(){
            loader.source = "scenes/ConnectionScene.qml"
        }
    }
}
