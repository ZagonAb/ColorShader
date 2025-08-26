import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import "../utils.js" as Utils

Rectangle {
    id: screensaverRoot
    color: "transparent"
    width: parent.width
    height: parent.height
    visible: screensaverActive
    z: 1001

    property bool screensaverActive: false
    property int inactivityTimeout: 60000
    property var randomScreenshots: []
    property int currentScreenshotIndex: 0
    property bool showImage1: true
    property real containerOpacity: 1.0

    signal screensaverStarted()
    signal screensaverStopped()

    Timer {
        id: inactivityTimer
        interval: inactivityTimeout
        running: !screensaverActive
        onTriggered: {
            screensaverActive = true;
            startScreensaver();
        }
    }

    function resetInactivityTimer() {
        inactivityTimer.restart();
    }

    function startScreensaver() {
        containerOpacity = 0.0;
        if (randomScreenshots.length > 0) {
            currentScreenshotIndex = 0;
            showNextScreenshot();
        }
        screensaverStarted();
    }

    function stopScreensaver() {
        screensaverActive = false;
        containerOpacity = 1.0;
        screenshotTransition.stop();
        screenshotImage1.opacity = 0;
        screenshotImage2.opacity = 0;
        screensaverStopped();
    }

    function showNextScreenshot() {
        if (screensaverActive && randomScreenshots.length > 0) {
            if (currentScreenshotIndex >= randomScreenshots.length) {
                currentScreenshotIndex = 0;
            }

            if (showImage1) {
                screenshotImage2.source = randomScreenshots[currentScreenshotIndex];
                screenshotImage1.opacity = 0;
                screenshotImage2.opacity = 1;
            } else {
                screenshotImage1.source = randomScreenshots[currentScreenshotIndex];
                screenshotImage2.opacity = 0;
                screenshotImage1.opacity = 1;
            }

            var game = getGameFromScreenshot(randomScreenshots[currentScreenshotIndex]);
            if (game && game.assets.logo) {
                gameLogo1.source = game.assets.logo;
            } else {
                gameLogo1.source = "";
            }

            currentScreenshotIndex++;
            showImage1 = !showImage1;
            screenshotTransition.restart();
        } else if (randomScreenshots.length === 0) {
            stopScreensaver();
        }
    }

    function getGameFromScreenshot(screenshot) {
        return null;
    }

    Timer {
        id: screenshotTransition
        interval: 5000
        running: screensaverActive
        repeat: true
        onTriggered: showNextScreenshot()
    }

    Item {
        id: screenshotsContainer
        anchors.fill: parent

        Image {
            id: screenshotImage1
            width: parent.width * 1.05
            height: parent.height * 1.05
            opacity: 0
            fillMode: Image.Stretch
            scale: 1.2

            Behavior on opacity {
                NumberAnimation { duration: 1000 }
            }

            SequentialAnimation on x {
                loops: Animation.Infinite
                PropertyAnimation {
                    from: 0
                    to: parent.width - screenshotImage1.width
                    duration: 5000
                }
                PropertyAnimation {
                    from: parent.width - screenshotImage1.width
                    to: 0
                    duration: 5000
                }
            }
        }

        Image {
            id: screenshotImage2
            width: parent.width * 1.05
            height: parent.height * 1.05
            opacity: 0
            fillMode: Image.Stretch
            scale: 1.2

            Behavior on opacity {
                NumberAnimation { duration: 1000 }
            }

            SequentialAnimation on x {
                loops: Animation.Infinite
                PropertyAnimation {
                    from: 0
                    to: parent.width - screenshotImage2.width
                    duration: 10000
                }
                PropertyAnimation {
                    from: parent.width - screenshotImage2.width
                    to: 0
                    duration: 10000
                }
            }
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, parent.height)
            end: Qt.point(0, parent.height * 0.5)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 0.5; color: "#80000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }
    }

    Image {
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        source: "../assets/scanline-png/crt.png"
        visible: screensaverActive
        opacity: screensaverActive ? 1 : 0.8
        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
        mipmap: true
    }

    Image {
        id: gameLogo1
        width: parent.width * 0.5
        height: width * 0.5
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }
        fillMode: Image.PreserveAspectFit
        opacity: screensaverActive ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            if (screensaverActive) {
                stopScreensaver();
            }
            resetInactivityTimer();
        }
    }
}
