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

    opacity: themeContainerOpacity

    Behavior on opacity {
        NumberAnimation { duration: 1000 }
    }

    Row {
        id: topRow
        width: parent.width
        height: parent.height
        anchors.margins: 10
        spacing: 10

        Item { width: root.width * 0.035; height: 60 }

        Text {
            id: clock
            color: "white"
            font.pixelSize: root.width * 0.025
            font.bold: true
            visible: true
            horizontalAlignment: Text.AlignLeft
            width: contentWidth
            anchors.verticalCenter: parent.verticalCenter
            x: gamesGridVisible ? root.width * 0.80 : root.width * 0.015;
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

        Item { width: parent.width - clock.width - batteryIcon.width - 20; height: 60 }

        Image {
            id: batteryIcon
            source: getBatteryIcon()
            width: root.width * 0.25
            height: root.height * 0.035
            fillMode: Image.PreserveAspectFit
            mipmap: true
            asynchronous: true
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            Timer {
                id: batteryUpdateTimer
                triggeredOnStart: true
                interval: 5000
                running: true
                repeat: true
                onTriggered: batteryIcon.source = getBatteryIcon()
            }
        }

        Item { width: root.width * 0.010; height: 60 }
    }
}
