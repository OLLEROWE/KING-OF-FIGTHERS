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
    property int direction: 1
    property int status: 1
    property int timedelta: 10
    property int hp: 100
    property var count : [0, 56, 5, 5, 13, 4, 7, 8, 4, 11, 15, 15, 16, 15, 4, 4, 7, 8, 8, 0, 21, 35,15,15,16,14,24,23,21,24,72]
    property var combos: []
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
        (e)=>{pressed_keys.add(e.key);keysChanged()}
    Keys.onReleased:
        (e)=>{pressed_keys.delete(e.key);keysChanged()}
    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            Controller.update_move(player)
            Controller.update_control(player)
            Controller.update_attack(player)
            Controller.update_direction(player)
            Controller.render(player,image,count)
            if(player.status === 20 && player.gameSprite.currentFrame === player.gameSprite.frameCount - 1){
                player.gameSprite.running = false
                player.collider.bodyType = Body.Static
            }
            if(isLeftPlayer){
                console.log(status)
            }
        }
    }
    Image{
        id:image
        source: update_image()
        visible: false
    }
    function update_image(){
        return "../../assets/img/andy/" + status + ".png"
    }
    function render(player,image,count){

        var toFirst = [4,6,7,8,9,10,11,12,13,18]
        var toFive = [14,15,16,17,19]
        var jumps = [4,10,11,12,13]
        player.gameSprite.source = Qt.resolvedUrl(image.source)
        player.gameSprite.frameCount = count[player.status]
        player.gameSprite.frameWidth = image.width / player.gameSprite.frameCount
        player.gameSprite.frameHeight = image.height

        if(jumps.includes(player.status))
            player.gameSprite.frameDuration = player.timedelta * 4
        else
            player.gameSprite.frameDuration = player.timedelta * 7

        if(toFirst.includes(player.status) && player.gameSprite.currentFrame === player.gameSprite.frameCount - 1){
            player.status = 1
        }
        if(player.status === 5 && player.gameSprite.currentFrame === player.gameSprite.frameCount - 2){
            player.gameSprite.currentFrame = player.gameSprite.frameCount - 3
            player.gameSprite.running = false
        }
        if(toFive.includes(player.status) && player.gameSprite.currentFrame === player.gameSprite.frameCount - 1){
            player.status = 5
            player.gameSprite.running = false
            if(player.status === 19)
                player.gameSprite.currentFrame =  count[player.status] - 1
            else
                player.gameSprite.currentFrame =  count[player.status] - 2

        }

    }
}
