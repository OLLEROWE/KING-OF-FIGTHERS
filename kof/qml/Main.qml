//Main.qml
import Felgo
import QtQuick
import QtQuick.Controls
import "scenes"
import "common"
import "./scenes/globals.js" as Globals
GameWindow {
    id: gameWindow
    property alias selectscene: selectScene
    property alias battlescene: battleScene
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    //activeScene: gameScene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640


    StartScene {
        id: startScene
        visible: true // 初始状态为 "menu" 时可见
        onStartGame: gameWindow.state = "model"
        onOpenSettings: gameWindow.state = "setting"
        onExit: Qt.quit()
    }
    ConnectionScene{
        id:connectionScene
        visible: false
        onSelection:gameWindow.state="selection"

    }
    SelectScene{
        id:selectScene
        visible: false
        onStartBattle:{
            gameWindow.state="game"
            battleScene.create1Character()
            battleScene.create2Character()
        }

    }
    BattleScene {
        id:battleScene;
        visible: false
        onGoSelect:{
            gameWindow.state="selection"
            selectscene.newselect()
            battlescene.newbattle()
        }
        onGoStart: {
            gameWindow.state="menu"
            selectscene.newselect()
            battlescene.newbattle()
        }
        onChanged:{
            timer2.start()
        }
    }
    Timer{
        id:timer1
        running: battlescene.visible
        repeat: true
        interval: 50
        onTriggered: {
            conn.sendMessage(4,battleScene.hp2)
            battleScene.myHp = conn.targetHp
        }
    }

    Timer{
        id:timer2
        running: false
        repeat: true
        interval: 50
        onTriggered: {
            let s = ""
            for(let key of battleScene.playerrole1.pressed_keys) {
                s += key + "|"
            }
            conn.sentKeys = s
            conn.sendMessage(1,s)
            conn.sentKeys = ""
            timer2.stop()
        }
    }
    property var keys: new Set
    Connections{
        target:conn
        function onTargetMessageChanged(){
            keys.clear()
            console.log("shoudaoxinxile1=====================",conn.targetMessage)
            let msg = conn.targetMessage
            let parts = msg.split("|")

            for(let i of parts){
                console.log(i)
                addKey(keys,i)
            }

            console.log("=====",keys.size)
            battleScene.player2Keys = keys
        }
    }
    function addKey(keys,part){
        if(part == 16777236)
            keys.add(Qt.Key_Left)
        else if(part == 16777234)
            keys.add(Qt.Key_Right)
        else if(part == 16777235)
            keys.add(Qt.Key_Up)
        else if(part == 16777237)
            keys.add(Qt.Key_Down)
        else if(part == 65)
            keys.add(Qt.Key_A)
        else if(part == 83)
            keys.add(Qt.Key_S)
        else if(part == 68)
            keys.add(Qt.Key_D)
        else if(part == 70)
            keys.add(Qt.Key_F)
    }
    SettingsScene{
        id:settingsScene;
        visible: false
        onGoStartScene:gameWindow.state = "menu"
    }
    ModelScene{
        id:modelScene
        visible: false
        onToBattle: {
            selectScene.isNetGame = false
            battleScene.isNetGame = false
            gameWindow.state = "selection"
        }
        onToNet: {
            selectScene.isNetGame = true
            battleScene.isNetGame = true
            gameWindow.state = "connection"
        }

    }
    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges { target: startScene; visible: true }
            PropertyChanges { target: connectionScene; visible: false }
            PropertyChanges { target: selectScene; visible: false }
            PropertyChanges { target: battleScene; visible: false }
            PropertyChanges { target: settingsScene; visible: false }
            PropertyChanges { target: modelScene;visible:false}
        },
        State {
            name: "connection"
            PropertyChanges { target: startScene; visible: false }
            PropertyChanges { target: connectionScene; visible: true }
            PropertyChanges { target: selectScene; visible: false }
            PropertyChanges { target: battleScene; visible: false }
            PropertyChanges { target: settingsScene; visible: false }
            PropertyChanges { target: modelScene;visible:false}
        },
        State {
            name: "selection"
            PropertyChanges { target: startScene; visible: false }
            PropertyChanges { target: connectionScene; visible: false }
            PropertyChanges { target: selectScene; visible: true ;focus:true}
            PropertyChanges { target: battleScene; visible: false }
            PropertyChanges { target: settingsScene; visible: false }
            PropertyChanges { target: modelScene;visible:false}
        },
        State {
            name: "game"
            PropertyChanges { target: startScene; visible: false }
            PropertyChanges { target: connectionScene; visible: false }
            PropertyChanges { target: selectScene; visible: false }
            PropertyChanges { target: battleScene; visible: true;focus:true }
            PropertyChanges { target: settingsScene; visible: false }
            PropertyChanges { target: modelScene;visible:false}
        },
        State {
            name: "setting"
            PropertyChanges { target: startScene; visible: false }
            PropertyChanges { target: connectionScene; visible: false }
            PropertyChanges { target: selectScene; visible: false }
            PropertyChanges { target: battleScene; visible: false }
            PropertyChanges { target: settingsScene; visible: true }
            PropertyChanges { target: modelScene;visible:false}
        },
        State {
            name: "model"
            PropertyChanges { target: startScene; visible: false }
            PropertyChanges { target: connectionScene; visible: false }
            PropertyChanges { target: selectScene; visible: false }
            PropertyChanges { target: battleScene; visible: false }
            PropertyChanges { target: settingsScene; visible: false }
            PropertyChanges { target: modelScene;visible:true}
        }
    ]

    //    Loader{
    //        id:mainLoader
    //        source: "MainItem.qml"
    //    }
    //    Keys.forwardTo: [gamescene.scene]
}
