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
    ColumnLayout{
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
        }
        TextField{
            id:targetIp
            text:conn.getIp()
        }
        TextField{
            id:targetPort
            text:"6666"
        }
        Button{
            text:"确定"

            onClicked:{
                conn.port = Number(port.text)
                conn.targetIp = targetIp.text
                conn.targetPort = Number(targetPort.text)
                timer.start()
            }
            Keys.onReturnPressed: {
                conn.port = Number(port.text)
                conn.targetIp = targetIp.text
                conn.targetPort = Number(targetPort.text)
                timer.start()
            }
        }
        Timer{
            id:timer
            interval: 100
            repeat: true
            running: false
            onTriggered: {
                console.log(conn.firstConn)
                if(conn.firstConn){
                    conn.sendMessage(3,true)
                    selection()//触发信号
                    running = false
                }else{
                    conn.sendMessage(3,true)
                    console.log("conn.sendMessage(3,true)")
                }
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
