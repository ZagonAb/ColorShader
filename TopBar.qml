import QtQuick 2.15
import "utils.js" as Utils

Item {
    id: topBar
    width: parent.width
    height: metrics ? metrics.topBarHeight : root.height * 0.060
    property real themeContainerOpacity: 1.0
    property bool gamesGridVisible: false
    property string currentShortName: ""
    property var metrics: null

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
        font.pixelSize: metrics ? metrics.topBarClockFontSize : root.width * 0.025
        font.bold: true
        visible: true
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: parent.verticalCenter

        x: gamesGridVisible ? (batteryStatus.x - width - root.width * 0.02) : root.width * 0.050

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

    Item {
        id: batteryStatus

        readonly property real statusFontSize:
        metrics ? metrics.topBarBatteryFontSize : Math.round(root.height * 0.025)

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin:
        metrics ? metrics.topBarBatteryRightMargin : root.width * 0.050

        width: statusRow.width
        height: statusFontSize * 1.4

        QtObject {
            id: batteryPoller
            property int cachedPercent: 0
            property bool cachedCharging: false
            property bool hasBattery: false

            function poll() {
                const pct = api.device.batteryPercent;
                if (!isNaN(pct)) {
                    hasBattery = true;
                    cachedPercent = Math.round(pct * 100);
                    cachedCharging = api.device.batteryCharging;
                } else {
                    hasBattery = false;
                }
            }
        }

        Timer {
            id: batteryTimer
            interval: 500
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: batteryPoller.poll()
        }

        Connections {
            target: api.device
            function onBatteryChargingChanged() { batteryPoller.poll() }
            function onBatteryPercentChanged() { batteryPoller.poll() }
        }

        Row {
            id: statusRow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: metrics ? metrics.topBarBatteryGap : 8

            Text {
                id: batteryPercentText
                anchors.verticalCenter: parent.verticalCenter
                visible: batteryPoller.hasBattery
                text: batteryPoller.cachedPercent + "%"
                color: "white"
                font.pixelSize: batteryStatus.statusFontSize
                font.bold: true
            }

            Image {
                id: batteryIcon
                anchors.verticalCenter: parent.verticalCenter
                width: metrics ? metrics.topBarBatteryIconSize : 48
                height: width
                mipmap: true
                smooth: true
                fillMode: Image.PreserveAspectFit
                sourceSize { width: 128; height: 128 }

                readonly property int iconIndex: {
                    if (batteryPoller.cachedCharging)
                        return Math.min(10, Math.round(batteryPoller.cachedPercent / 10));
                    else
                        return Math.min(9, Math.floor(batteryPoller.cachedPercent / 10));
                }

                source: {
                    if (!batteryPoller.hasBattery)
                        return "assets/icons/no_battery.svg";
                    if (batteryPoller.cachedCharging)
                        return "assets/icons/charging/fluent--battery-charge-" + iconIndex + "-20-regular.svg";
                    return "assets/icons/not-charging/fluent--battery-" + iconIndex + "-20-regular.svg";
                }

                onStatusChanged: {
                    if (status === Image.Error) {
                        source = "assets/icons/no_battery.svg";
                    }
                }
            }
        }
    }
}
