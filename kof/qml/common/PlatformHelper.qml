import QtQuick
import QtQuick.Controls
QtObject {
    property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    property bool isDesktop: !isMobile
}
