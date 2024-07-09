import QtQuick
import Felgo

Text{
    property int time: 60
    property bool isRunning: false
    Timer{
        interval: 1000
        running: isRunning
        repeat: true
        onTriggered: {
            if(time > 0)
                time-=1
        }
    }
    color:"orange"
    text:time
    font.pixelSize: 50
}
