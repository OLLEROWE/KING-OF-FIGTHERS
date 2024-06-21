import QtQuick
import Felgo

Text{
    property int time: 60
    property bool isRunning: false
    Timer{
        interval: 1000
        running: isRunning
        repeat: true
        onTriggered: time-=1
    }
    color:"orange"
    text:time
    font.pixelSize: 50
}
