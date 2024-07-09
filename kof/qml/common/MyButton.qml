import QtQuick
import Felgo

GameButton {
    //  text: "Toggle Physics"
    id: button
    width: 50;height: 50
    signal click
    signal cancel
    Timer{
        id:timer
        repeat: true
        interval: 50
        triggeredOnStart: false
        onTriggered: {
            stop()
            cancel()
        }
    }
    onClicked: {
        timer.start()
        click()
    }
}

