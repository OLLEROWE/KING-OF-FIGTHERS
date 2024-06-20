import QtQuick
import Felgo
import QtMultimedia
import QtQuick.Controls
import QtQuick.Dialogs
import "scenes"


Rectangle{
    anchors.fill: parent
       MediaPlayer {
           id: mediaplayer
           source: "../assets/vedio/begin.mp4"
           audioOutput: AudioOutput {}
           videoOutput: videoOutput

           Component.onCompleted: {
               mediaplayer.play();
           }

       // 监听视频播放状态
             onPlaybackStateChanged: {
                 if (playbackState === MediaPlayer.EndedState) {
                     console.log("Video finished.");
                     if (loader.source === "scenes/StartScene.qml") {
                         // 如果当前场景是 StartScene，则重播视频
                         mediaplayer.stop();
                         mediaplayer.play();
                     }
                 }
             }
        }

       VideoOutput {
           id: videoOutput
           anchors.fill: parent

           TapHandler {
               id: tapHandler
               onTapped: {
                          console.log("OpenScreen tapped, switching to StartScene.");
                          loader.source = "scenes/StartScene.qml";
                          loader.visible = true;
                          mediaplayer.destroy();// 停止开场视频播放,并且销毁视频资源对象
                          tapHandler.enabled = false; // 同时禁用TapHandler
                      }
                  }
       }

       Loader{
           id:loader
           anchors.fill: parent
           visible: false  // 初始不可见
           focus:true
           onLoaded: {
                      if (loader.item) {
                          // 设置 loaderContext
                          loader.item.loaderContext = loader;
                      }
            }
       }



}
