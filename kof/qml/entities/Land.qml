import QtQuick
import Felgo

EntityBase {
    id: ground
    entityType: "land"
    width: parent.width
    height: parent.height/10
    opacity : 0
    Rectangle{
        anchors.fill: parent
        color:"red"
    }

    BoxCollider {
      anchors.fill: parent
      bodyType: Body.Static
    }
}
