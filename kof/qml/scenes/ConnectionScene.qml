import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import "../entities"
import "../common"
Scene {
    anchors.fill: parent
    signal connect()
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
                connect()
                conn.setTargetIpAndPort(targetIp.text,6666)
            }
        }

    }

}
