import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import QtMultimedia
import "../entities"
import "../common"

Scene {
    id: startScene
    property Loader loaderContext

    signal startGame
    signal openSettings
    signal exit
    anchors.fill: parent
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
    FontLoader {
           id: arcadeFont
           source: "../../assets/fonts/Arcade Classic.ttf"
       }
    AnimatedImage{
        anchors.fill: parent
        source: "../../assets/img/bgc/" + getRandomInt(1, 23) + ".gif"
    }
    // LOGO
    Image {
        id: logoImage
        source: "../../assets/img/other/1.png"
        width: parent.width * 0.3
        height: sourceSize.height * (width / sourceSize.width)
        anchors.horizontalCenter: parent.horizontalCenter

        opacity: 0
        z: 0

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation { to: 1; duration: 1500; easing.type: Easing.InOutQuad }
            PropertyAnimation { to: 0.5; duration: 1500; easing.type: Easing.InOutQuad }
        }
    }

    // 菜单选项
    Column {
        id: menuColumn
        spacing: 20
        width: parent.width * 0.3
        anchors.centerIn: parent
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: logoImage.bottom
//        anchors.topMargin: 2

        // "开始游戏"
        Button {
            font.family: arcadeFont.name
            font.pixelSize: 28
            id: startButton
            width: menuColumn.width
            text: "开始游戏"
            onClicked:{
                startGame()

                /*
                            if (startScene.loaderContext) {
                                 startScene.loaderContext.source = "scenes/ConnectionScene.qml";
                                }*/
            }
            focus: true
            Keys.onReturnPressed:{
                if (startScene.loaderContext) {
                    startScene.loaderContext.source = "scenes/ConnectionScene.qml";
                }
            }
        }

        // "设置"
        Button {
            id: settingsButton
            width: menuColumn.width
            text: "设置"
            onClicked:{
                openSettings()
                /*
                                if (startScene.loaderContext) {
                                     startScene.loaderContext.source = "scenes/SettingsScene.qml";
                                     */
            }

            Keys.onReturnPressed: {
                if (startScene.loaderContext) {
                    startScene.loaderContext.source = "scenes/SettingsScene.qml";
                }
            }

            KeyNavigation.down: exitButton
            KeyNavigation.up: startButton
        }

        // "退出游戏"
        Button {
            id: exitButton
            width: menuColumn.width
            text: "退出游戏"
            onClicked: exit()
            Keys.onReturnPressed: Qt.quit()
            KeyNavigation.down: startButton
            KeyNavigation.up: settingsButton
        }
    }

    // 背景的闪烁光效
    Rectangle {
        id: blinkEffect
        color: "black"
        opacity: 0.1
        anchors.fill: parent

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation { to: 0.05; duration: 5000; easing.type: Easing.InOutQuad }

        }
    }
}





