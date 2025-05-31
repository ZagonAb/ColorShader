import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12

Item {
    id: root
    property string currentShortName: ""
    property real themeContainerOpacity: 1.0
    property bool animate: true

    width: parent ? parent.width * 0.3 : 200
    height: parent ? parent.height * 0.1 : 80

    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: parent ? parent.height * 0.05 : 50
    }

    visible: true

    property string _activeShortName: ""
    property bool _animationInProgress: false

    Item {
        id: imageContainer
        anchors.fill: parent
        opacity: 0
        scale: 0.5

        Image {
            id: systemLogo
            anchors.fill: parent
            source: _activeShortName !== "" ? "assets/logos/" + _activeShortName + ".png" : ""
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            mipmap: true
            smooth: true
            antialiasing: true
            sourceSize { width: 256; height: 256 }
            opacity: 0.1

            onStatusChanged: {
                if (status === Image.Error && _activeShortName !== "") {
                    source = "assets/logos/default.png"
                }
            }
        }

        DropShadow {
            anchors.fill: systemLogo
            horizontalOffset: 0
            verticalOffset: 3
            radius: 6
            samples: 12
            color: "#60000000"
            source: systemLogo
            visible: systemLogo.status === Image.Ready
            opacity: 0.3 * imageContainer.opacity
        }
    }

    Behavior on themeContainerOpacity {
        NumberAnimation { duration: 300 }
    }

    onCurrentShortNameChanged: {
        if (currentShortName === _activeShortName) return;

        imageShowAnim.stop();
        resetAnimation.stop();

        if (currentShortName !== "") {
            resetAnimation.start();
        }
    }

    SequentialAnimation {
        id: resetAnimation
        ScriptAction {
            script: {
                _animationInProgress = true;
                _activeShortName = "";
                imageContainer.opacity = 0;
                imageContainer.scale = 0.5;
            }
        }
        PauseAnimation { duration: 50 }
        ScriptAction {
            script: {
                _activeShortName = currentShortName;
                imageShowAnim.start();
            }
        }
    }

    ParallelAnimation {
        id: imageShowAnim
        NumberAnimation {
            target: imageContainer
            property: "opacity"
            to: themeContainerOpacity
            duration: 600
            easing.type: Easing.OutCubic
            onStopped: _animationInProgress = false
        }
        NumberAnimation {
            target: imageContainer
            property: "scale"
            to: 1
            duration: 700
            easing.type: Easing.OutBack
        }
    }

    Connections {
        target: systemLogo
        function onStatusChanged() {
            if (systemLogo.status === Image.Ready && !_animationInProgress) {
                imageContainer.opacity = themeContainerOpacity;
                imageContainer.scale = 1;
            }
        }
    }

    Component.onCompleted: {
        if (currentShortName !== "") {
            _activeShortName = currentShortName;
            imageContainer.opacity = themeContainerOpacity;
            imageContainer.scale = 1;
        }
    }
}
