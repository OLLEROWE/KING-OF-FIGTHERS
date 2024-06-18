import QtQuick
import Felgo

import "scenes"
Rectangle{
    anchors.fill: parent
    Loader{
        id:loader
        anchors.fill: parent
        source: "scenes/ConnectionScene.qml"
        focus:true
    }
    Connections{
        target: loader.item
        function onConnect(){
            loader.source = "scenes/BattleScene.qml"
        }
    }
}
