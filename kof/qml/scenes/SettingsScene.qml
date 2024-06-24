import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    width: parent.width
    height: parent.height
    signal goStartScene

    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
    // 加载背景图片
    Image {
        id: backgroundImage
        source: "../../assets/img/bgc/" + getRandomInt(1, 23) + ".gif"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    // 加载自定义字体
    FontLoader {
        id: kofFont
        source: "../../assets/fonts/ARCADECLASSIC.TTF"
    }

    Column {
        width: parent.width * 0.6
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "游戏设置"
            font.family: "ARCADECLASSIC" // 使用自定义字体
            font.pixelSize: 40
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // 各种设置控件
        ColumnLayout {
            spacing: 10
            width: parent.width

            RowLayout {
                          spacing: 10
                          Text {
                              text: "音量"

                              font.family: kofFont.name
                              font.pixelSize: 20
                              color: "white"
                              Layout.alignment: Qt.AlignLeft

                          }
                          Slider {
                              id: volumeSlider
                              Layout.fillWidth: true
                              from: 0
                              to: 100
                              value: 50
                              background: Rectangle {
                                  implicitWidth: volumeSlider.width
                                  implicitHeight: volumeSlider.height

                                  // 轨道样式
                                  Rectangle {
                                      width: parent.width
                                      height: 4
                                      radius: 2
                                      color: "#7F7F7F" // 轨道颜色
                                  }

                                  // 滑块样式
                                  Rectangle {
                                      width: 20
                                      height: 20
                                      radius: 10
                                      color: "#E61919" // 滑块颜色
                                      border.color: "white"
                                      x: volumeSlider.visualPosition - width / 2
                                      y: (volumeSlider.height - height) / 2

                                      MouseArea {
                                          anchors.fill: parent
                                          drag.target: parent
                                      }
                                  }
                              }
                          }
                      }
        }

        // 返回按钮
        Button {
            text: "返回"
            font.family: kofFont.name
            font.pixelSize: 20
            width: parent.width * 0.3
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#333333"
                radius: 5
                border.color: "white"
                border.width: 2
            }
            onClicked: goStartScene()
        }
    }


}

