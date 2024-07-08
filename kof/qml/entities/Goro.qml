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
    property var pressed_keys: new Set
    property int speedx: 400
    property int speedy: 400
    property alias twoAxisController : _twoAxisController
    property alias gameSprite: gameSprite
    property bool isLeftPlayer: true
    property alias timer: _timer
    property int direction: 1
    property int status: 1
    property int timedelta: 10
    property int hp: 100

    property var count : [0, 12, 8, 8, 13, 6, 4, 5, 7, 7, 13, 12, 13, 12, 4, 4, 5, 4,8,0,26,25,34,24,25,33,84,23,69,84,10]
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

    focus:true
    Keys.onPressed:
        (e)=>{pressed_keys.add(e.key);keysChanged();}
    Keys.onReleased:
        (e)=>{pressed_keys.delete(e.key);keysChanged()}
    Timer{
        id:_timer
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            Controller.update_move(player)
            Controller.update_control(player)
            Controller.update_attack(player)
            Controller.update_direction(player)
            Controller.render(player,image,count,4)
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
        return "../../assets/img/goro/" + status + ".png"
    }

}
