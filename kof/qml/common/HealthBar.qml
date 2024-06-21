import QtQuick
import Felgo

Rectangle{
    property int hp: 100
//    width: parent.width/3
    height: 30
    color: "white"
    border.width: 2
    border.color: "white"
    Rectangle{
        x:2
        y:2
        color:"orange"
        width: hp * (parent.width - 4) / 100
        height: 26
        Behavior on width {
            NumberAnimation { duration: 500 }
        }
    }
}


