import QtQuick
import QtQuick.Controls
import Felgo
import "../entities"
import "../common"
import "../entities/controller.js" as Controller
Scene {
    property alias scene: scene
    //property alias mplayer1: player1
    //property alias mplayer2: player2
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
    }/*
    BackgroundMusic {
        id: backgroundMusic
        source: Qt.resolvedUrl("../../assets/vedio/bgc.mp3")
    }*/
    PhysicsWorld {
        id: world
        // physics is disabled initially, and enabled after the splash is finished
        running: true
        gravity.y: 9.81 * 3
        z: 10 // draw the debugDraw on top of the entities

//         these are performance settings to avoid boxes colliding too far together
//         set them as low as possible so it still looks good
        updatesPerSecondForPhysics: 60
        velocityIterations: 5
        positionIterations: 5
//         set this to true to see the debug draw of the physics system
//         this displays all bodies, joints and forces which is great for debugging
        debugDrawVisible: false
    }
    GameMap{

    }

    Land{
        id:land
        anchors.bottom: parent.bottom
    }
    Rectangle{
        width: 100
        height: 100
        Button{
            anchors.fill: parent
           onClicked: {
               selectscene.a()
           }
        }
    }

    //Component.onCompleted:createCharacters(scene)


    function createCharacters(parentItem) {
        // 创建角色1


        var componenta = Qt.createComponent("../entities/" +"Joe" +".qml");
               if (componenta.status === Component.Ready) {

                   var secondaryModule = componenta.createObject(parentItem);

                    //console.log("Trying to load QML file:", "../entities/" + str + ".qml")
                   if (secondaryModule === null) {
                       console.error("Error creating secondary module");
                   }
               } else {
                   console.error("Error loading component:", componenta.errorString());
               }
    }
    function createCharacter(characterName, xPosition, isPlayer1) {
        var component = Qt.createComponent(characterName)
        if (component.status === Component.Ready) {
            var character = component.createObject(scene, {
                                                       id: isPlayer1 ? "player1" : "player2",
                                                       x: xPosition,
                                                       anchors:{bottom: land.top
                                                       }
                                                       // 其他属性设置
                                                   })
            return character
        } else {
            console.error("Failed to create", characterName, ":", component.errorString())
            return null
        }

    }


    /*Player{
        id:player1
        x:scene.width/4
        anchors.bottom: land.top
        // whenever the thumb position changes, update the twoAxisController
        twoAxisController.xAxis: joystickController.controllerXPosition
        twoAxisController.yAxis: joystickController.controllerYPosition

    }

  /*  Kyo{
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
        anchors.bottom: land.top
        isLeftPlayer: false
//        direction:-1
    }
    Rectangle{
        id:idelAttcakForFist
        x:player1.x + player1.width - width -10
        y:player1.y + 24
        color:"red"
        width: 20
        height: 20
    }
    Rectangle{
        id:idelAttcakForHLeg
        x:player1.x + player1.width - width - 10
        y:idelAttcakForFist.y + 20
        color:"yellow"
        width: 20
        height: 40
    }
    Rectangle{
        id:idelAttcakForLLeg
        x:player1.x + player1.width - width
        y:player1.y + 3* player1.height/4
        color:"blue"
        width: 20
        height: 20
    }

*/
    function b(){
        console.log("my ")
    }


    Component.onDestruction:Controller.players.length = 0

    property var keys: new Set
    property string sent_keys: ""
    Keys.forwardTo:[player1]
    Connections{
        target: player1
        function onKeysChanged(){
            sent_keys = ""
            player1.pressed_keys.forEach(function(key) {
                sent_keys += key + "|"
            });
            conn.sendMessage(sent_keys)
        }
        function onPositionChanged(){
            sent_keys = ""
            if(player1.twoAxisController.xAxis > 0.6)
                sent_keys += 68 + "|"
            else if(player1.twoAxisController.xAxis < -0.6)
                sent_keys += 65 + "|"
            else if(player1.twoAxisController.yAxis > 0.6)
                sent_keys += 87 + "|"
            else if(player1.twoAxisController.yAxis < -0.6)
                sent_keys += 83 + "|"

            conn.sendMessage(sent_keys)
        }
    }


    Connections{
        target:conn
        function onTargetMessageChanged(){
            keys.clear()
            let msg = conn.targetMessage
            let parts = msg.split("|")
            for(let i = 0;i<parts.length;i++)
                addKey(parts[i])
//            console.log("k*rt00000000000000000000000fi-ueys.size:",keys.size)

            player2.pressed_keys = keys
//            if(player2.pressed_keys.size === 0)
//                console.log("player2.pressed_keys.size === 0")
//            player2.pressed_keys.forEach(function(key) {
//                console.log("keys---" + key)
//            });
        }
    }
    function addKey(part){
        if(part === 68)
            keys.add(Qt.Key_A)
        else if(part === 87)
            keys.add(Qt.Key_W)
        else if(part === 65)
            keys.add(Qt.Key_D)
        else if(part === 83)
            keys.add(Qt.Key_S)
        else if(part === 85)
            keys.add(Qt.Key_U)
        else if(part === 73)
            keys.add(Qt.Key_I)
        else if(part === 74)
            keys.add(Qt.Key_J)
        else if(part ===75)
            keys.add(Qt.Key_K)

    }

}
