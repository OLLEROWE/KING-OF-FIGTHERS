import QtQuick
import Felgo

EntityBase {
    id: kyo
    entityType: "role"
    scale: 2
    width: gameSprite.width * 2
    height: gameSprite.height * 2
    property alias collider: _collider
    property var pressed_keys: new Set
    property int speedx: 400
    property alias twoAxisController : _twoAxisController
    property bool isLeftPlayer: true
    property int status: 1
    GameAnimatedSprite{
        id:gameSprite
    }
    BoxCollider {
        id:_collider
        anchors.fill: role
        bodyType: Body.Dynamic
    }
    TwoAxisController {
        id: _twoAxisController
    }

    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            reader();
        }
    }

    function update_move(player){
        if(player.x < 0)
            player.x = 0
        if(player.x > player.parent.width - player.width)
            player.x = player.parent.width - player.width
    }

    function update_control(){

    }
    function reader(){
        gameSprite.source = Qt.resolvedUrl("../../assets/img/kyo/" + status + ".png")
    }
}
