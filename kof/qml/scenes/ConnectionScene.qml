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
        spacing: 10
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
            id:port
            text:"6666"
            enabled: false
        }
        TextField{
            id:targetIp
            text:conn.getIp()
        }
        TextField{
            id:targetPort
            text:"6666"
            enabled: false
        }
        Button{
            text:"确定"
            onClicked:{
                selection()//触发信号
                conn.setPort(port.text)
                conn.setTargetIpAndPort(targetIp.text,targetPort.text)
            }
            Keys.onReturnPressed: {
                selection()//触发信号
                conn.setPort(port.text)
                conn.setTargetIpAndPort(targetIp.text,targetPort.text)
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
