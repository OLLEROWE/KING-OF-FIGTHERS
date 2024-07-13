.pragma library
let players = []
let toFirst = [4,6,7,8,9,10,11,12,13,18,21,22,23,24,25,26,27,28,29,30,31]
let toFive = [14,15,16,17,19]
let jumps = [4,10,11,12,13]
let attacks = [6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,30]
function update_move(player){
    if (player.x < 0)
        player.x = 0;
    else if (player.x + player.width > player.parent.width) {
        player.x = player.parent.width -player.width;
    }
}
function update_control(player,isNetGame,isLeftPlayer){
    let up, left, right, down, A, B, C, D;
    if(isNetGame){
        up = player.pressed_keys.has(Qt.Key_Up) || player.twoAxisController.yAxis > 0.6;
        left = player.pressed_keys.has(Qt.Key_Left) || player.twoAxisController.xAxis < -0.6;
        right = player.pressed_keys.has(Qt.Key_Right) || player.twoAxisController.xAxis > 0.6;
        down = player.pressed_keys.has(Qt.Key_Down) || player.twoAxisController.yAxis < -0.6;
        A = player.pressed_keys.has(Qt.Key_A)
        B = player.pressed_keys.has(Qt.Key_S)
        C = player.pressed_keys.has(Qt.Key_D)
        D = player.pressed_keys.has(Qt.Key_F)
    }else if(!isNetGame && isLeftPlayer){
        up = player.pressed_keys.has(Qt.Key_W)
        left = player.pressed_keys.has(Qt.Key_A)
        right = player.pressed_keys.has(Qt.Key_D)
        down = player.pressed_keys.has(Qt.Key_S)
        A = player.pressed_keys.has(Qt.Key_U)
        B = player.pressed_keys.has(Qt.Key_I)
        C = player.pressed_keys.has(Qt.Key_J)
        D = player.pressed_keys.has(Qt.Key_K)
    }else if(!isNetGame && !isLeftPlayer){
        up = player.pressed_keys.has(Qt.Key_Up)
        left = player.pressed_keys.has(Qt.Key_Left)
        right = player.pressed_keys.has(Qt.Key_Right)
        down = player.pressed_keys.has(Qt.Key_Down)
        A = player.pressed_keys.has(Qt.Key_1)
        B = player.pressed_keys.has(Qt.Key_2)
        C = player.pressed_keys.has(Qt.Key_4)
        D = player.pressed_keys.has(Qt.Key_5)
    }



    if(player.status === 1){
        if(A || B || C || D){
            if(A)
                player.status = 6;
            else if(B)
                player.status = 7;
            else if(C)
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
    }else if(player.status === 3){
        if(isNetGame && !isLeftPlayer){
            if(A){
                player.status = 25;
                player.collider.linearVelocity.x = 0
            }else if(B){
                player.status = 26;
                player.collider.linearVelocity.x = 0
            }else if(C){
                player.status = 27;
                player.collider.linearVelocity.x = 0
            }else if(D){
                player.status = 30;
                player.collider.linearVelocity.x = 0
            }else if(up){
                player.status = 5;
            }else if(!left && !right){
                player.status = 1;
            }
        }else{
            if(A){
                player.status = 24;
                player.collider.linearVelocity.x = 0
            }else if(B){
                player.status = 23;
                player.collider.linearVelocity.x = 0
            }else if(C){
                player.status = 21;
                player.collider.linearVelocity.x = 0
            }else if(D){
                player.status = 22;
                player.collider.linearVelocity.x = 0
            }else if(up){
                player.status = 5;
            }else if(!left && !right){
                player.status = 1;
            }
        }

    }else if(player.status === 2){
        if(isNetGame && !isLeftPlayer){
            if(A){
                player.status = 24;
                player.collider.linearVelocity.x = 0
            }else if(B){
                player.status = 23;
                player.collider.linearVelocity.x = 0
            }else if(C){
                player.status = 21;
                player.collider.linearVelocity.x = 0
            }else if(D){
                player.status = 22;
                player.collider.linearVelocity.x = 0
            }else if(up){
                player.status = 5;
            }else if(!left && !right){
                player.status = 1;
            }
        }else{
            if(A){
                player.status = 25;
                player.collider.linearVelocity.x = 0
            }else if(B){
                player.status = 26;
                player.collider.linearVelocity.x = 0
            }else if(C){
                player.status = 27;
                player.collider.linearVelocity.x = 0
            }else if(D){
                player.status = 30;
                player.collider.linearVelocity.x = 0
            }else if(up){
                player.status = 5;
            }else if(!left && !right){
                player.status = 1;
            }
        }


    }
    else if(player.status === 4){
        if(A || B || C || D){
            if(A)
                player.status = 10;
            else if(B){
                player.status = 11;
            }
            else if(C)
                player.status = 12;
            else
                player.status = 13

        }
    }else if(player.status === 5){
        if(A || B || C || D){
            if(A)
                player.status = 14;
            else if(B){
                player.status = 15;
            }
            else if(C)
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

function render(player,image,count,point){


    player.gameSprite.source = Qt.resolvedUrl(image.source)
    player.gameSprite.frameCount = count[player.status]
    player.gameSprite.frameWidth = image.width / player.gameSprite.frameCount
    player.gameSprite.frameHeight = image.height

    if(jumps.includes(player.status))
        player.gameSprite.frameDuration = player.timedelta * 4
    else
        player.gameSprite.frameDuration = player.timedelta * 7

    if(toFirst.includes(player.status) && player.gameSprite.currentFrame === player.gameSprite.frameCount - 1){
        //        if(player.status === 23 || player.status === 25 || player.status === 26 || player.status === 25 || player.status === 27 || player.status === 30)  player.x += player.gameSprite.width
        //        else if(player.status === 24 ) player.x += player.gameSprite.width / 2
        player.status = 1
    }
    if(player.status === 5 && player.gameSprite.currentFrame === player.gameSprite.frameCount - 2){
        player.gameSprite.currentFrame = player.gameSprite.frameCount - point
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
    if(other.status === 3){
        other.hp = Math.max(other.hp-5,0)
        other.status = 31
    }else if(jumps.includes(other.status)){
        other.hp = Math.max(other.hp-5,0)
        other.status = 33
    }else if(toFive.includes(other.status) || other.status === 5){
        other.hp = Math.max(other.hp-5,0)
        other.status = 32
    }else{
        other.hp = Math.max(other.hp-20,0)
        other.status = 18;
    }
    if (other.hp <= 0) {
        other.status = 20;
    }
}
function update_attack(player) {
    if(players.length !== 2)
        return;
    if ((attacks.includes(player.status)) && (player.gameSprite.currentFrame === player.gameSprite.frameCount-1)) {
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
