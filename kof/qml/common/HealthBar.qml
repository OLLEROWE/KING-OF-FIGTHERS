import QtQuick
import Felgo

Rectangle{
    id:rc
    property int hp: 100
    property string name
    height: 30
    color: "white"
    border.width: 2
    border.color: "white"
    signal lose
    signal win
    Rectangle{
        id:re
        x:2
        y:2
        color:"orange"
        width: hp * (parent.width - 4) / 100
        height: 26
        Behavior on width {
            NumberAnimation { duration: 500 }
        }



    }
    Text{
        x:parent.x + parent.width/2
        y:parent.y + parent.height
        color:"yellow"
        font.pointSize: 20
        text:name
    }

}


