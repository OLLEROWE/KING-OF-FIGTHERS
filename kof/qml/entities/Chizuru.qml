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
    property var count : [0, 31, 8, 7, 15, 8, 8, 14, 6, 15, 17, 18, 17, 17, 7, 6, 12, 11, 24, 24, 24, 13, 14,14,24,24,16,16,73,9,10,10]
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
            Controller.render(player,image,count,5)
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
        return "../../assets/img/chizuru/" + status + ".png"
    }

}
