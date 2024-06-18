import QtQuick
import QtQuick.Controls
import Felgo
import "../entities"
import "../common"


Scene {
    property alias scene: scene
//    property alias player1: player1
    id: scene
    anchors.fill: parent
    JoystickControllerHUD{
        id:joystickController
        x:100
        y: parent.height - height -50
        width: 150
        height: 150
        visible: !system.desktopPlatform
        z:scene.z + 1
        opacity:0.5
        source: "../../assets/img/joystick_background.png"
//        thumbSource: "../../assets/img/joystick_thumb.png"
    }
    BackgroundMusic {
        id: backgroundMusic
        source: Qt.resolvedUrl("../../assets/vedio/bgc.mp3")
    }
    PhysicsWorld {
        id: world
        // physics is disabled initially, and enabled after the splash is finished
        running: true
        gravity.y: 9.81 * 3
        z: 10 // draw the debugDraw on top of the entities

        // these are performance settings to avoid boxes colliding too far together
        // set them as low as possible so it still looks good
        updatesPerSecondForPhysics: 60
        velocityIterations: 5
        positionIterations: 5
        // set this to true to see the debug draw of the physics system
        // this displays all bodies, joints and forces which is great for debugging
        debugDrawVisible: false
    }
    BackGround{

    }

    Land{
        id:land
        anchors.bottom: parent.bottom
    }
    Kyo{
        id:player1
        x:scene.width/4
        anchors.bottom: land.top
        // whenever the thumb position changes, update the twoAxisController
        twoAxisController.xAxis: joystickController.controllerXPosition
        twoAxisController.yAxis: joystickController.controllerYPosition
    }
    Kyo{
        id:player2
        x:3*scene.width/4 - width
        //anchors.bottom: land.top
        isLeftPlayer: false
    }

    Rectangle{
        width: 50
        height: 50
        color:"red"
        radius: 25
        x:scene.width - 200
        y:scene.height - 300
        opacity:0.5
        visible: !system.desktopPlatform
        Text {
            text: qsTr("lp")
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: player1.lp = true
            onReleased: player1.lp = false
        }
    }
    Rectangle{
        width: 50
        height: 50
        color:"red"
        radius: 25
        x:scene.width - 240
        y:scene.height - 250
        opacity:0.5
        visible: !system.desktopPlatform
        Text {
            text: qsTr("hp")
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: player1.hp = true
            onReleased: player1.hp = false
        }
    }
    Rectangle{
        width: 50
        height: 50
        color:"red"
        radius: 25
        x:scene.width - 280
        y:scene.height - 200
        opacity:0.5
        visible: !system.desktopPlatform
        Text {
            text: qsTr("ll")
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: player1.ll = true
            onReleased: player1.ll = false
        }
    }
    Rectangle{
        width: 50
        height: 50
        color:"red"
        radius: 25
        x:scene.width - 320
        y:scene.height - 150
        opacity:0.5
        visible: !system.desktopPlatform
        Text {
            text: qsTr("hl")
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: player1.hl = true
            onReleased: player1.hl = false
        }
    }

    Keys.forwardTo:[player1]
    Connections{
        target:player1
        function onKeysChanged(){
//            conn.sendMessage(player1.pressed_keys)
        console.log(player1.settoString(player1.pressed_keys))
        }
    }

}
