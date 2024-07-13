import QtQuick
import Felgo

Text{
    property int time: 60
    property bool isRunning: false
    signal timeover
    Timer{
        interval: 1000
        running: isRunning
        repeat: true
        onTriggered: {
            if(time > 0)
                time-=1
            if(time==0){
                timeover()
            }
        }
    }
    color:"orange"
    text:time
    font.pixelSize: 50
    function newclock(){
        time=60
        isRunning = false
    }
}
