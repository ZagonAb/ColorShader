import QtQuick 2.15
import "utils.js" as Utils

Item {
    id: topBar
    width: parent.width
    height: root.height * 0.060
    property real themeContainerOpacity: 1.0
    property bool gamesGridVisible: false
    property string currentShortName: ""

    function getBatteryIcon() {
        return Utils.getBatteryIcon(api.device.batteryPercent, api.device.batteryCharging);
    }

    Timer {
        id: opacityTimer
        interval: 100
        onTriggered: clock.opacity = 1
    }

    Connections {
        target: topBar
        function onGamesGridVisibleChanged() {
            clock.opacity = 0
            opacityTimer.start()
        }
    }

    opacity: themeContainerOpacity

    Behavior on opacity {
        NumberAnimation { duration: 1000 }
    }

    Text {
        id: clock
        color: "white"
        font.pixelSize: root.width * 0.025
        font.bold: true
        visible: true
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: parent.verticalCenter

        x: gamesGridVisible ? (batteryIcon.x - width - root.width * 0.02) : root.width * 0.050

        function formatTime() {
            let date = new Date();
            let hours = date.getHours();
            let minutes = date.getMinutes();
            let ampm = hours >= 12 ? "PM" : "AM";
            hours = hours % 12;
            hours = hours ? hours : 12;
            let minutesStr = minutes < 10 ? "0" + minutes : minutes;
            return hours + ":" + minutesStr + " " + ampm;
        }

        text: formatTime()

        Timer {
            running: true
            interval: 1000
            repeat: true
            onTriggered: clock.text = clock.formatTime()
        }
    }

    Image {
        id: batteryIcon
        source: getBatteryIcon()
        width: root.width * 0.025
        height: root.height * 0.035
        fillMode: Image.PreserveAspectFit
        mipmap: true
        asynchronous: true
        visible: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: root.width * 0.050

        Timer {
            id: batteryUpdateTimer
            triggeredOnStart: true
            interval: 5000
            running: true
            repeat: true
            onTriggered: batteryIcon.source = getBatteryIcon()
        }
    }
}
