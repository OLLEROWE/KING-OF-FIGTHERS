import QtQuick
import Felgo
import QtMultimedia
import QtQuick.Controls
import "../../assets"

Scene {
    id: videoPlayer
    anchors.fill: parent


    MediaPlayer {
        id: mediaplayer
        source: "../../assets/vedio/begin.mp4"
        autoOutput:autoOutput{}
        videoOutput: videoOutput

    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: mediaPlayer
    }
    Component.onCompleted:{
        mediaplayer.play()
    }

    signal finished()
}
