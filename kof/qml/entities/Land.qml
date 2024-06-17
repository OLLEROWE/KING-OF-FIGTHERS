import QtQuick
import Felgo

EntityBase {
    id: ground
    entityType: "land"
    width: parent.width
    height: parent.height/10
    opacity : 0
    BoxCollider {
      anchors.fill: parent
      bodyType: Body.Static
    }
}
