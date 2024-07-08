import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import "../entities"
import "../common"
import "../scenes"
import "../entities/controller.js" as Controller
import "globals.js" as Globals
Scene {
    property alias scene: scene

    property var player1
    property var conn
    id: scene
    anchors.fill: parent


    JoystickControllerHUD {
        id: joystickController
        x: 100
        y: parent.height - height - 50
        width: 150
        height: 150
        visible: !system.desktopPlatform // 根据平台显示或隐藏
        z: scene.z + 1
        opacity: 0.5
        source: "../../assets/img/joystick_background.png"

        property var playerTwoxisController   // 初始化为null，稍后在创建玩家后赋值

        //        thumbSource: "../../assets/img/joystick_thumb.png"

        // 当控制器X位置改变时，更新玩家对象的X轴
        onControllerXPositionChanged: {

            if (playerTwoxisController) {

                playerTwoxisController.xAxis = controllerXPosition;

            }

        }

        onControllerYPositionChanged: {

            if (playerTwoxisController) {

                playerTwoxisController.yAxis = controllerYPosition;

            }

        }

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
    RowLayout{
        y:30
        width: parent.width
        spacing: 20


        HealthBar{
            id:player1HpBar
            hp:player1.hp
            Layout.fillWidth: true
            onLose: {
                gameOverText.text = "You Lose!!!"
                gameOverText.visible = true
                gameOver()
            }
            name:conn.getUserName()
        }
        Clock{
            id:clock
        }
        HealthBar{
            id:player2HpBar
            hp:player2.hp
            Layout.fillWidth: true
            onLose: {
                gameOverText.text = "You Win!!!"
                gameOverText.visible = true
                gameOver()
            }
            name:conn.targetName
        }

    }
    Land{
        id:land
        anchors.bottom: parent.bottom
    }


    MyButton{
        id:button1
        x: button2.x + width
        y:button2.y - height
        text: "A"
        visible: !system.desktopPlatform // 根据平台显示或隐藏

        onClick:{
            Controller.pressed_keys.add(Qt.Key_A)
            console.log(Globals.player1.speedx)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Controller.pressed_keys.delete(Qt.Key_A)
            Globals.player1.keysChanged()
        }
    }
    MyButton{
        id:button2
        x:4 * parent.width / 5
        y:2 * parent.height / 3 - 20
        visible: !system.desktopPlatform // 根据平台显示或隐藏

        text: "B"
        onClick:{
            Controller.pressed_keys.add(Qt.Key_S)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Controller.pressed_keys.delete(Qt.Key_S)
            Globals.player1.keysChanged()
        }
    }
    focus:true

    MyButton{
        id:button3
        x:button2.x - 10
        y:button2.y + height + 10
        text: "C"
        visible: !system.desktopPlatform // 根据平台显示或隐藏

        onClick:{
            Controller.pressed_keys.add(Qt.Key_D)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Controller.pressed_keys.delete(Qt.Key_D)
            Globals.player1.keysChanged()
        }
    }
    MyButton{
        id:button4
        x:button1.x - 10
        y:button1.y + 3 * height + 10
        text: "D"
        visible: !system.desktopPlatform // 根据平台显示或隐藏

        onClick:{
            Controller.pressed_keys.add(Qt.Key_F)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Controller.pressed_keys.delete(Qt.Key_F)
            Globals.player1.keysChanged()
        }
    }




    function create1Character() {
        var component = Qt.createComponent("../entities/" + selectscene.player1SelectionName + ".qml");

        if (component.status === Component.Ready) {

            var playerObject = component.createObject(parent, {x: scene.width /4});
            if(playerObject){
                var twoAxisController = playerObject.getComponent("TwoAxisController");
                if (twoAxisController) {
                    joystickController.playerTwoxisController = twoAxisController;
                }
            }

            Globals.player1 = playerObject; // 存储全局引用
            //initializeController(playerObject)
            return playerObject; // 返回创建的玩家对象

        } else {
            console.error("Failed to create player character:", component.errorString());
            return null;
        }
    }
    function create2Character() {
        var create2 = Qt.createComponent( "../entities/"+ selectscene.player1SelectionName+".qml" )
        conn = create2
        if (create2.status === Component.Ready) {
            create2.createObject(parent, {x:scene.width*3/4,bottom:land.top});

        } else {
            console.error("Failed to create"+":", create2.errorString())
            return null
        }

    }








    Component.onDestruction:Controller.players.length = 0

    property var keys: new Set
    property string sent_keys: ""
    Keys.forwardTo:[Globals.player1]
    Connections{
        target: Globals.player1
        function onKeysChanged(){
            sent_keys = ""
            sent_keys += clock.time + "|"
            player1.pressed_keys.forEach(function(key) {
                sent_keys += key + "|"
            });
            conn.sendMessage(1,sent_keys)
        }
        function onPositionChanged(){
            console.log("onPositionChanged")
            sent_keys = ""
            sent_keys += clock.time + "|"
            if(player1.twoAxisController.xAxis > 0.6)
                sent_keys += Qt.Key_Left + "|"
            else if(player1.twoAxisController.xAxis < -0.6)
                sent_keys += Qt.Key_Right + "|"
            else if(player1.twoAxisController.yAxis > 0.6)
                sent_keys += Qt.Key_Up + "|"
            else if(player1.twoAxisController.yAxis < -0.6)
                sent_keys += Qt.Key_Down + "|"
            conn.sendMessage(1,sent_keys)
        }

    }


    GameSoundEffect{
        id:_round
        source: Qt.resolvedUrl("../../assets/vedio/round1.mp3")
    }

    Connections{
        target:conn
        function onTargetMessageChanged(){
            keys.clear()
            let msg = conn.targetMessage
            let parts = msg.split("|")
            if((clock.time - parts[0] > 1) ||(parts[0] - clock.time > 1))
                clock.time = parts[0]
            for(let i = 1;i<parts.length;i++)
                addKey(parts[i])
            player2.pressed_keys = keys
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
