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
            text:conn.getIp()
        }
        TextField{
            id:targetIp
            text:conn.getIp()
        }
        TextField{
            id:targetPort
            text:"45454"
        }
        Button{
            text:"确定"
            onClicked:{
                connect()
                conn.setTargetIpAndPort(targetIp.text,targetPort.text)
            }
        }

    }

}
