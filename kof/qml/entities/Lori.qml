import QtQuick
import Felgo
import "controller.js" as Controller
EntityBase {
    id: player
    entityType: "player"
    scale: 1.5
    width: gameSprite.width * scale
    height: gameSprite.height * scale
    property alias collider: _collider
    property int speedx: 400
    property int speedy: 400
    property var pressed_keys:new Set
    property alias twoAxisController : _twoAxisController
    property alias gameSprite: gameSprite
    property bool isLeftPlayer: true
    property alias timer: _timer
    property int direction: 1
    property int status: 1
    property int timedelta: 10
    property int hp: 100

    property var count : [0, 9, 10, 9, 13, 6, 6, 7, 10, 11, 14, 13, 16, 16, 7, 10, 12, 12,12,12,30,17,23,16,29,12,27,27,60,11,9,14]
    property bool isNetGame: false
    signal keysChanged()
    signal positionChanged()
    GameAnimatedSprite{
        id:gameSprite
        mirrorX: direction === -1 ? true : false

        interpolate:false
    }
    BoxCollider {
        id:_collider
        anchors.fill: player
        bodyType: Body.Dynamic
    }
    TwoAxisController {
        id: _twoAxisController
        onXAxisChanged:positionChanged()
        onYAxisChanged: positionChanged()
    }


    Timer{
        id:_timer
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            Controller.update_move(player)
            Controller.update_control(player,isNetGame,isLeftPlayer)
            Controller.update_attack(player)
            Controller.update_direction(player)
            Controller.render(player,image,count,3)
            if(player.status === 20 && player.gameSprite.currentFrame === player.gameSprite.frameCount - 1){
                player.gameSprite.running = false
                player.collider.bodyType = Body.Static
            }

        }
    }
    Image{
        id:image
        source: update_image()
        visible: false
    }
    function update_image(){
        return "../../assets/img/lori/" + status + ".png"
    }

}
