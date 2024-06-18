import QtQuick
import QtQuick.Controls
AnimatedImage{
    id:image
    anchors.fill: parent
    visible: true
    source :"../../assets/img/bgc/" + getRandomInt(1, 23) + ".gif";

    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
}
