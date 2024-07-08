//Main.qml
import Felgo
import QtQuick
import QtQuick.Controls
import "scenes"
import "common"
GameWindow {
    id: gameWindow
    property alias selectscene: selectScene
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


    state: "menu"
       StartScene {
           id: startScene
           visible: true // 初始状态为 "menu" 时可见
           onStartGame: gameWindow.state = "connection"
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
           onStartBattle:gameWindow.state="game"

       }
       BattleScene {
           id:battleScene;
           visible: false
       }

       SettingsScene{
           id:settingsScene;
           visible: false
           onGoStartScene:gameWindow.state = "menu"
       }
       states: [
           State {
               name: "menu"
               PropertyChanges { target: startScene; visible: true }
               PropertyChanges { target: connectionScene; visible: false }
               PropertyChanges { target: selectScene; visible: false }
               PropertyChanges { target: battleScene; visible: false }
               PropertyChanges { target: settingsScene; visible: false }
           },
           State {
               name: "connection"
               PropertyChanges { target: startScene; visible: false }
               PropertyChanges { target: connectionScene; visible: true }
               PropertyChanges { target: selectScene; visible: false }
               PropertyChanges { target: battleScene; visible: false }
               PropertyChanges { target: settingsScene; visible: false }
           },
           State {
               name: "selection"
               PropertyChanges { target: startScene; visible: false }
               PropertyChanges { target: connectionScene; visible: false }
               PropertyChanges { target: selectScene; visible: true }
               PropertyChanges { target: battleScene; visible: false }
               PropertyChanges { target: settingsScene; visible: false }
           },
           State {
               name: "game"
               PropertyChanges { target: startScene; visible: false }
               PropertyChanges { target: connectionScene; visible: false }
               PropertyChanges { target: selectScene; visible: false }
               PropertyChanges { target: battleScene; visible: true;focus:true }
               PropertyChanges { target: settingsScene; visible: false }
           },
           State {
               name: "setting"
               PropertyChanges { target: startScene; visible: false }
               PropertyChanges { target: connectionScene; visible: false }
               PropertyChanges { target: selectScene; visible: false }
               PropertyChanges { target: battleScene; visible: false }
               PropertyChanges { target: settingsScene; visible: true }
           }
       ]

//    Loader{
//        id:mainLoader
//        source: "MainItem.qml"
//    }
//    Keys.forwardTo: [gamescene.scene]
}
