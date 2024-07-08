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
    property alias twoAxisController : _twoAxisController
    property alias gameSprite: gameSprite
    property bool isLeftPlayer: true
    property int direction: 1
    property int status: 1
    property int timedelta: 10
    property int hp: 100
    property var count : [0, 10, 6, 6, 13, 4, 7, 4, 6, 11, 15, 14,14, 17, 15, 8, 4, 4, 13, 4, 4, 12]

    signal keysChanged()
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
    }

    focus:true
    Keys.onPressed:
        (e)=>{Controller.pressed_keys.add(e.key);keysChanged();}
    Keys.onReleased:
        (e)=>{Controller.pressed_keys.delete(e.key);keysChanged()}
    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            Controller.update_move(player)
            Controller.update_control(player)
            Controller.update_attack(player)
            Controller.update_direction(player)
            Controller.render(player,image,count,2)
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
        return "../../assets/img/kyo/" + status + ".png"
    }
}
