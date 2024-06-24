import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import "../entities"
import "../common"

Scene {
    id: connectionScene
    anchors.fill: parent
    property Loader loaderContext  // 接收 Loader 作为上下文
    signal selection()
    RowLayout{
        spacing: 50
        anchors.centerIn: parent
                TextField{
                    text:conn.getUserName()
                    enabled: false
                }
                TextField{
                    text:conn.getIp()
                    enabled: false
                }
                TextField{
                    id:targetIp
                    text:conn.getIp()
                }
        Button{
            text:"确定"
            onClicked:{
                selection()//触发信号
                conn.setTargetIpAndPort(targetIp.text,6666)
            }
            Keys.onReturnPressed: {
                selection()//触发信号
                conn.setTargetIpAndPort(targetIp.text,6666)
            }
        }

    }
    /*
    Connections {
          target: connectionScene  // 监听本地信号
          onFightStart: {
              if (connectionScene.loaderContext) {
              connectionScene.loaderContext.source = "scenes/BattleScene.qml";
              }
          }
      }
      */
}
