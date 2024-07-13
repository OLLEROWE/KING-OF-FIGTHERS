import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Felgo
import "../entities"
import "../common"
import "../scenes"
import "../entities/controller.js" as Controller
import "globals.js" as Globals
Scene {
    id: scene
    property var player1
    property var conn
    property bool isNetGame: false
    property alias clock: clock
    property var playerrole1
    property var playerrole2
    property var player2Keys: new Set
    anchors.fill: parent

    signal goSelect
    signal goStart
    signal changed

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

    function newbattle(){
        message.visible = false

        Globals.player1=null
        Globals.player2=null
        console.log("----------------" + Globals.player1.width)

    }

    //    BackgroundMusic {
    //        id: backgroundMusic
    //        source: Qt.resolvedUrl("../../assets/vedio/bgc.mp3")
    //    }
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
    Timer{
        id:_timer
        running: true
        repeat: true
        interval: 100
        onTriggered: {
            if(scene.visible){
                Globals.player2.pressed_keys = player2Keys
                console.log(Globals.player2.pressed_keys.size)
                for(let i of Globals.player2.pressed_keys)
                    console.log("Globals.player2.pressed_keys--",i)
            }
            hp1 = gethp1()
            hp2 = gethp2()
            if(hp1 ===0){
                message.visible = true
                text.text = "you lose"
            }
            if(hp2 === 0){
                message.visible = true
                text.text = "you win"
            }

        }
    }
    property int hp1: gethp1()
    property int hp2: gethp2()
    Column {
        id:message
        width: parent.width/4
        height: parent.height/6
        anchors.centerIn: parent
        spacing: 10
        visible: false

        Rectangle {
            width: parent.width
            height: parent.height
            color: "White"
            opacity: 0.3

            Text {
                id:_text
                text: "chose game again or not!"
                anchors.centerIn: parent
                color: "white"
                font.pointSize: 20

            }
        }

    }
    RowLayout{
        y:30
        width: parent.width
        spacing: 20
        HealthBar{
            id:player1HpBar
            hp:hp1
            Layout.fillWidth: true
            onLose: {
                message.visible= true
                _text.text="you lose"
            }
            name:conn.targetName
        }
        Clock{
            id:clock
            onTimeover: {
                message.visible=true
                Globals.player1.gameSprite.running = false
                Globals.player2.gameSprite.running = false
            }
        }
        HealthBar{
            id:player2HpBar
            hp:hp2
            Layout.fillWidth: true
            onLose: {
                message.visible= true
                _text.text="you win"

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
            Globals.player1.pressed_keys.add(Qt.Key_D)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Globals.player1.pressed_keys.delete(Qt.Key_D)
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
            Globals.player1.pressed_keys.add(Qt.Key_F)
            Globals.player1.keysChanged()
        }
        onCancel: {
            Globals.player1.pressed_keys.delete(Qt.Key_F)
            Globals.player1.keysChanged()
        }
    }



    function gethp1(){
        if(Controller.players.length === 2)
            return Controller.players[0].hp
        return 100
    }
    function gethp2(){
        if(Controller.players.length === 2)
            return Controller.players[1].hp
        return 100
    }
    function create1Character() {
        var component = Qt.createComponent("../entities/" + selectscene.player1SelectionName + ".qml");
        console.log(selectscene.player1SelectionName + "=========selectscene.player1SelectionName")
        if (component.status === Component.Ready) {

            var playerObject = component.createObject(scene, {x: scene.width /4});
            if(playerObject){
                var twoAxisController = playerObject.getComponent("TwoAxisController");
                if (twoAxisController) {
                    joystickController.playerTwoxisController = twoAxisController;
                }
            }
            playerObject.anchors.bottom = land.top
            playerrole1 = playerObject
            Globals.player1 = playerObject; // 存储全局引用
            //initializeController(playerObject)
            Globals.player1.isNetGame = isNetGame
            Controller.players.push(playerObject)
            console.log(Controller.players.length + "1--------------")
            return playerObject; // 返回创建的玩家对象


        } else {
            console.error("Failed to create player character:", component.errorString());
            return null;
        }
    }
    function create2Character() {
        var create2 = Qt.createComponent( "../entities/"+ selectscene.player2SelectionName+".qml" )
        console.log(selectscene.player2SelectionName + "=========selectscene.player2SelectionName")

        conn = create2
        clock.isRunning = true
        if (create2.status === Component.Ready) {
            var playerObject =create2.createObject(scene, {x:scene.width*3/4});
            playerObject.anchors.bottom = land.top
            Globals.player2 = playerObject; // 存储全局引用
            Globals.player2.direction = -1
            Globals.player2.isLeftPlayer = false
            Globals.player2.isNetGame = isNetGame
            playerrole2 = playerObject
            Controller.players.push(playerObject)
            console.log(Controller.players.length + "2--------------")
        } else {
            console.error("Failed to create"+":", create2.errorString())
            return null
        }

    }





    Keys.onPressed:
        (e)=>{
            if(isNetGame){
                Globals.player1.pressed_keys.add(e.key);changed();
            }else{
                Globals.player1.pressed_keys.add(e.key);
                Globals.player2.pressed_keys.add(e.key);
            }
        }
    Keys.onReleased:
        (e)=>{
            if(isNetGame){
                Globals.player1.pressed_keys.delete(e.key);
                changed();
                console.log("scene   onKeysChanged")

            }else{
                Globals.player1.pressed_keys.delete(e.key);
                Globals.player2.pressed_keys.delete(e.key);
            }
        }


    Component.onDestruction:Controller.players.length = 0


    GameSoundEffect{
        id:_round
        source: Qt.resolvedUrl("../../assets/vedio/round1.mp3")
    }
}
