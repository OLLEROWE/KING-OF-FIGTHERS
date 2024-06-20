.pragma library

let players = []
function update_move(player){
    if (player.x < 0)
        player.x = 0;
    else if (player.x + player.width > player.parent.width) {
        player.x = player.parent.width -player.width;
    }
}
function update_control(player){
    let up, left, right, down, Lp, Hp, Ll, Hl;
    up = player.pressed_keys.has(Qt.Key_W) || player.twoAxisController.yAxis > 0.6;
    left = player.pressed_keys.has(Qt.Key_A) || player.twoAxisController.xAxis < -0.6;
    right = player.pressed_keys.has(Qt.Key_D) || player.twoAxisController.xAxis > 0.6;
    down = player.pressed_keys.has(Qt.Key_S) || player.twoAxisController.yAxis < -0.6;
    Lp = player.pressed_keys.has(Qt.Key_U)
    Hp = player.pressed_keys.has(Qt.Key_I)
    Ll = player.pressed_keys.has(Qt.Key_J)
    Hl = player.pressed_keys.has(Qt.Key_K)

    if(player.status === 1 || player.status === 2 || player.status === 3){
        if(Lp || Hp || Ll || Hl){
            if(Lp)
                player.status = 6;
            else if(Hp)
                player.status = 7;
            else if(Ll)
                player.status = 8;
            else
                player.status = 9;

            player.collider.linearVelocity.x = 0
        }else if(down){
            player.collider.linearVelocity.x = 0
            player.status = 5
        }else if(up){
            if(right)
                player.collider.linearVelocity.x = player.speedx
            else if(left)
                player.collider.linearVelocity.x = -player.speedx
            else
                player.collider.linearVelocity.x = 0

            player.collider.linearVelocity.y = player.speedy
            player.status = 4;
        }else if(right){
            player.collider.linearVelocity.x = player.speedx
            player.status = 2;
        }else if(left){
            player.collider.linearVelocity.x = -player.speedx
            player.status = 3;
        }else{
            player.collider.linearVelocity.x = 0
            player.status = 1;
        }
    }else if(player.status === 4){
        if(Lp || Hp || Ll || Hl){
            if(Lp)
                player.status = 10;
            else if(Hp){
                player.status = 11;
            }
            else if(Ll)
                player.status = 12;
            else
                player.status = 13
        }
    }else if(player.status === 5){
        if(Lp || Hp || Ll || Hl){
            if(Lp)
                player.status = 14;
            else if(Hp){
                player.status = 15;
            }
            else if(Ll)
                player.status = 16;
            else
                player.status = 17
            player.collider.linearVelocity.x = 0
            player.gameSprite.running = true
        }
        if(!down){
            player.status = 1
            player.gameSprite.running = true
        }
    }

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
        player.gameSprite.currentFrame = player.gameSprite.frameCount - 2
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
function  update_direction(player) {
    if (player.status === 20 && player.gameSprite.currentFrame === player.gameSprite.frameCount-1) return;
    if (players.length === 2) {
        let id = player.isLeftPlayer? 0 : 1
        let me = players[id],you = players[1-id];
        if (me.x < you.x) player.direction = 1;
        else player.direction = -1;
    }
}
function is_collision(r1, r2) {
    if (Math.max(r1.x1, r2.x1) > Math.min(r1.x2, r2.x2))
        return false;
    if (Math.max(r1.y1, r2.y1) > Math.min(r1.y2, r2.y2))
        return false;
    return true;
}
function is_attack(other) {
    if (other.status === 20) return;
    other.status = 18;
    other.hp = Math.max(other.hp-20,0)
    if (other.hp <= 0) {
        other.status = 20;
    }
}
function update_attack(player) {
    if(players.length !== 2)
        return;
    if ((player.status === 6) && (player.gameSprite.currentFrame === player.gameSprite.frameCount-4)) {
        let id = player.isLeftPlayer? 0 : 1
        let me = players[id], you = players[1 - id];
        let r1;
        if (player.direction > 0) {
            r1 = {
                x1: me.x + me.width - 20 -10,
                y1: me.y + 24,
                x2: me.x + me.width - 20 -10 + 20,
                y2: me.y + 34 + 20,
            };
        } else {
            r1 = {
                x1: me.x,
                y1: me.y + 34,
                x2: me.x + 20,
                y2: me.y + 34 + 20,
            };
        }

        let r2 = {
            x1: you.x,
            y1: you.y,
            x2: you.x + you.width,
            y2: you.y + you.height
        };

        if (is_collision(r1, r2)) {
            is_attack(you)
        }
    }
}
