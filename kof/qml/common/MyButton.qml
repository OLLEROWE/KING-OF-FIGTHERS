import QtQuick
import Felgo

/*

// EXAMPLE USAGE:
// add this piece of code in your Scene to display the Button

MyButton {
  text: "Click Me!"
  width: 80
  height: 40
  anchors.centerIn: parent

  onClicked: {
    console.log("Clicked!")
  }
}

*/

Item {
    id: button

    // public events
    signal clicked
    signal pressed
    signal released

    property string defaultColor: "red"
    property string hoverColor: "blue"
    property alias text: buttonText.text

    // button background
    Rectangle {
        id: background
        color: mouseArea.containsMouse ? hoverColor : defaultColor
        anchors.fill: parent
    }

    // button text
    Text {
        id: buttonText
        anchors.centerIn: background
    }

    // mouse area to handle click events
    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true

        onPressed: button.pressed()
        onReleased: button.released()
        onClicked: button.clicked()
    }

    // change opacity on pressed and released events, so we have a "pressed" state
    onPressed: {
        opacity = 0.5
    }

    onReleased: {
        opacity = 1.0
    }
}