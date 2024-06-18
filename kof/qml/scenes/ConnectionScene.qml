import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Felgo
import "../entities"
import "../common"


Scene {
    anchors.fill: parent
    RowLayout{
        spacing: 50
        anchors.centerIn: parent
        TextField{

            text:"-00000"
        }
        TextField{
            text:"-00000"
        }
        TextField{
            text:"-00000"
        }
        Button{
            text:"确定"

        }

    }

}
