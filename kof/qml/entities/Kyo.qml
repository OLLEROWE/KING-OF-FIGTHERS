import QtQuick
import Felgo

EntityBase {
    id: player
    entityType: "player"
    scale: 2
    width: gameSprite.width * 2
    height: gameSprite.height * 2
    property alias collider: _collider
    property var pressed_keys: new Set
    property int speedx: 400
    property int speedy: 400
    property alias twoAxisController : _twoAxisController
    property bool isLeftPlayer: true
    property int status: 1
    property int timedelta: 10
    property bool lp: false
    property bool hp: false
    property bool ll: false
    property bool hl: false
    signal keysChanged()
    GameAnimatedSprite{
        id:gameSprite
        mirrorX: !isLeftPlayer ? true : false

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
            update_move()
            update_control()
            render()
            if(conn.getMessage() !== "")
                console.log("-----" + conn.getMessage())
        }
    }

    function update_move(){
        if (player.x < 0)
            player.x = 0;
        else if (player.x + player.width > player.parent.width) {
            player.x = player.parent.width -player.width;
        }
    }

    function update_control(){
        let up, left, right, down, Lp, Hp, Ll, Hl;
        up = pressed_keys.has(Qt.Key_W) || _twoAxisController.yAxis > 0.6;
        left = pressed_keys.has(Qt.Key_A) || _twoAxisController.xAxis < -0.6;
        right = pressed_keys.has(Qt.Key_D) || _twoAxisController.xAxis > 0.6;
        down = pressed_keys.has(Qt.Key_S) || _twoAxisController.yAxis < -0.6;
        Lp = pressed_keys.has(Qt.Key_U) || lp;
        Hp = pressed_keys.has(Qt.Key_I) || hp;
        Ll = pressed_keys.has(Qt.Key_J) || ll;
        Hl = pressed_keys.has(Qt.Key_K) || hl;

        if(status === 1 || status === 2 || status === 3){
            if(Lp || Hp || Ll || Hl){
                if(Lp)
                    status = 6;
                else if(Hp)
                    status = 7;
                else if(Ll)
                    status = 8;
                else
                    status = 9;

                _collider.linearVelocity.x = 0
            }else if(down){
                _collider.linearVelocity.x = 0
                status = 5
            }else if(up){
                if(right)
                    _collider.linearVelocity.x = speedx
                else if(left)
                    _collider.linearVelocity.x = -speedx
                else
                    _collider.linearVelocity.x = 0

                _collider.linearVelocity.y = speedy
                status = 4;
            }else if(right){
                _collider.linearVelocity.x = speedx
                status = 2;
            }else if(left){
                _collider.linearVelocity.x = -speedx
                status = 3;
            }else{
                _collider.linearVelocity.x = 0
                status = 1;
            }
        }else if(status === 4){
            if(Lp || Hp || Ll || Hl){
                if(Lp)
                    status = 10;
                else if(Hp){
                    status = 11;
                }
                else if(Ll)
                    status = 12;
                else
                    status = 13
            }
        }else if(status === 5){
            if(Lp || Hp || Ll || Hl){
                if(Lp)
                    status = 14;
                else if(Hp){
                    status = 15;
                }
                else if(Ll)
                    status = 16;
                else
                    status = 17
                _collider.linearVelocity.x = 0
                gameSprite.running = true
            }
            if(!down){
                status = 1
                gameSprite.running = true
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


    function render(){
        var count = [0, 10, 6, 6, 13, 4, 7, 4, 6, 11, 15, 14, 17, 15, 8, 4, 4, 13]

        var toFirst = [4,6,7,8,9,10,11,12,13,18]
        var toFive = [14,15,16,17,19]
        var jumps = [4,10,11,12,13]
        gameSprite.source = Qt.resolvedUrl(image.source)
        gameSprite.frameCount = count[status]
        gameSprite.frameWidth = image.width / gameSprite.frameCount
        gameSprite.frameHeight = image.height

        if(jumps.includes(status))
            gameSprite.frameDuration = timedelta * 4
        else
            gameSprite.frameDuration = timedelta * 7

        if(toFirst.includes(status) && gameSprite.currentFrame === gameSprite.frameCount - 1){
            status = 1
        }
        if(status === 5 && gameSprite.currentFrame === gameSprite.frameCount - 2){
            gameSprite.currentFrame = gameSprite.frameCount - 2
            gameSprite.running = false
        }
        if(toFive.includes(status) && gameSprite.currentFrame === gameSprite.frameCount - 1){
            status = 5
            gameSprite.running = false
            if(status === 19)
                gameSprite.currentFrame =  count[status] - 1
            else
                gameSprite.currentFrame =  count[status] - 2

        }
        if(status === 20 && gameSprite.currentFrame === gameSprite.frameCount - 1){
            gameSprite.running = false
        }
    }
    function settoString(keys){
        let str = ""
        for(let i of keys)
            str += i + "|"
        if(str === "")
            return ""
        else return str.slice(0,-1);
    }
}
