import QtQuick 2.15

FocusScope {
    id: updateNotification
    anchors.fill: parent
    z: 9999

    property var metrics: null
    property var soundEffects: null
    property color accentColor: "#ffffff"

    property string latestVersion: ""
    property string releaseUrl: ""
    property string releaseNotes: ""
    property bool expanded: false

    property bool active: false
    property bool cardShown: false

    signal closed()

    visible: active
    focus: active
    enabled: active

    function show(version, url, notes) {
        latestVersion = version || "";
        releaseUrl = url || "";
        releaseNotes = notes || "";
        expanded = false;
        active = true;
        cardShown = false;
        slideInTimer.restart();
        noticeTimer.restart();
    }

    function hide() {
        cardShown = false;
        hideTimer.restart();
    }

    Timer {
        id: slideInTimer
        interval: 20
        repeat: false
        onTriggered: {
            updateNotification.cardShown = true;
            focusTimer.restart();
        }
    }

    Timer {
        id: focusTimer
        interval: (updateNotification.metrics ? updateNotification.metrics.updateCardSlideDuration : 380) + 40
        repeat: false
        onTriggered: {
            updateNotification.forceActiveFocus();
            viewButton.forceActiveFocus();
        }
    }

    Timer {
        id: noticeTimer
        interval: 180
        repeat: false
        onTriggered: {
            if (updateNotification.soundEffects) updateNotification.soundEffects.playNotice();
        }
    }

    Timer {
        id: hideTimer
        interval: (updateNotification.metrics ? updateNotification.metrics.updateCardSlideDuration : 380) + 40
        repeat: false
        onTriggered: {
            updateNotification.active = false;
            updateNotification.closed();
        }
    }

    Rectangle {
        id: scrim
        anchors.fill: parent
        color: "#000000"
        opacity: updateNotification.cardShown ? 0.55 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: updateNotification.metrics ? updateNotification.metrics.updateCardSlideDuration : 380
                easing.type: Easing.OutQuad
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
                updateNotification.hide();
            }
        }
    }

    Rectangle {
        id: card
        anchors.horizontalCenter: parent.horizontalCenter
        width: metrics
            ? Math.max(metrics.updateCardMinWidth, metrics.updateCardWidth)
            : parent.width * 0.4
        height: contentColumn.implicitHeight + (metrics ? metrics.updateCardPadding * 2 : 40)
        radius: metrics ? metrics.updateCardRadius : 14
        color: Qt.rgba(0, 0, 0, 0.88)
        border.color: updateNotification.accentColor
        border.width: metrics ? metrics.updateCardBorderWidth : 2
        clip: true

        y: updateNotification.cardShown
            ? (metrics ? metrics.updateCardTopMargin : 20)
            : -(height + (metrics ? metrics.updateCardTopMargin : 20) + 40)

        Behavior on y {
            NumberAnimation {
                duration: metrics ? metrics.updateCardSlideDuration : 380
                easing.type: updateNotification.cardShown ? Easing.OutBack : Easing.InCubic
                easing.overshoot: updateNotification.cardShown ? 1.1 : 1.0
            }
        }

        Behavior on height {
            NumberAnimation { duration: 220; easing.type: Easing.OutQuad }
        }

        Column {
            id: contentColumn
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: metrics ? metrics.updateCardPadding : 20
            spacing: metrics ? metrics.updateCardSpacing : 12

            Text {
                width: parent.width
                text: "New update available"
                color: updateNotification.accentColor
                font.family: global.fonts.condensed
                font.bold: true
                font.pixelSize: metrics ? metrics.updateCardTitleFontSize : 24
                wrapMode: Text.WordWrap
            }

            Text {
                width: parent.width
                text: "ColorShader " + updateNotification.latestVersion + " It is now available.."
                color: "white"
                font.family: global.fonts.sans
                font.pixelSize: metrics ? metrics.updateCardBodyFontSize : 18
                wrapMode: Text.WordWrap
            }

            Row {
                spacing: metrics ? metrics.updateCardButtonSpacing : 10

                Rectangle {
                    id: viewButton
                    height: metrics ? metrics.updateCardButtonHeight : 42
                    width: Math.max(
                        metrics ? metrics.updateCardButtonMinWidth : 110,
                        viewButtonText.implicitWidth + height * 0.6
                    )
                    radius: height / 2
                    color: updateNotification.accentColor
                    border.color: activeFocus ? "white" : Qt.rgba(1, 1, 1, 0.3)
                    border.width: activeFocus ? Math.max(2, height * 0.045) : 1
                    focus: true

                    Behavior on border.width { NumberAnimation { duration: 100 } }

                    Text {
                        id: viewButtonText
                        anchors.centerIn: parent
                        text: updateNotification.expanded ? "Hide changes" : "View changes"
                        color: "#101010"
                        font.family: global.fonts.sans
                        font.bold: true
                        font.pixelSize: metrics ? metrics.updateCardButtonFontSize : 15
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playOk();
                            updateNotification.expanded = !updateNotification.expanded;
                        }
                    }

                    Keys.onPressed: {
                        if (event.isAutoRepeat) return;
                        if (api.keys.isAccept(event)) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playOk();
                            updateNotification.expanded = !updateNotification.expanded;
                        } else if (api.keys.isCancel(event)) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
                            updateNotification.hide();
                        } else if (event.key === Qt.Key_Right) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playRight();
                            openButton.forceActiveFocus();
                        }
                    }
                }

                Rectangle {
                    id: openButton
                    height: metrics ? metrics.updateCardButtonHeight : 42
                    width: Math.max(
                        metrics ? metrics.updateCardButtonMinWidth : 110,
                        openButtonText.implicitWidth + height * 0.6
                    )
                    radius: height / 2
                    color: Qt.rgba(1, 1, 1, 0.08)
                    border.color: activeFocus ? "white" : Qt.rgba(1, 1, 1, 0.25)
                    border.width: activeFocus ? Math.max(2, height * 0.045) : 1

                    Behavior on border.width { NumberAnimation { duration: 100 } }

                    Text {
                        id: openButtonText
                        anchors.centerIn: parent
                        text: "Open on GitHub"
                        color: "white"
                        font.family: global.fonts.sans
                        font.pixelSize: metrics ? metrics.updateCardButtonFontSize : 15
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playOk();
                            if (updateNotification.releaseUrl) Qt.openUrlExternally(updateNotification.releaseUrl);
                            updateNotification.hide();
                        }
                    }

                    Keys.onPressed: {
                        if (event.isAutoRepeat) return;
                        if (api.keys.isAccept(event)) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playOk();
                            if (updateNotification.releaseUrl) Qt.openUrlExternally(updateNotification.releaseUrl);
                            updateNotification.hide();
                        } else if (api.keys.isCancel(event)) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
                            updateNotification.hide();
                        } else if (event.key === Qt.Key_Left) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playLeft();
                            viewButton.forceActiveFocus();
                        } else if (event.key === Qt.Key_Right) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playRight();
                            closeButton.forceActiveFocus();
                        }
                    }
                }

                Rectangle {
                    id: closeButton
                    height: metrics ? metrics.updateCardButtonHeight : 42
                    width: Math.max(
                        metrics ? metrics.updateCardButtonMinWidth : 110,
                        closeButtonText.implicitWidth + height * 0.6
                    )
                    radius: height / 2
                    color: Qt.rgba(1, 1, 1, 0.08)
                    border.color: activeFocus ? "white" : Qt.rgba(1, 1, 1, 0.25)
                    border.width: activeFocus ? Math.max(2, height * 0.045) : 1

                    Behavior on border.width { NumberAnimation { duration: 100 } }

                    Text {
                        id: closeButtonText
                        anchors.centerIn: parent
                        text: "Close"
                        color: "white"
                        font.family: global.fonts.sans
                        font.pixelSize: metrics ? metrics.updateCardButtonFontSize : 15
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
                            updateNotification.hide();
                        }
                    }

                    Keys.onPressed: {
                        if (event.isAutoRepeat) return;
                        if (api.keys.isAccept(event) || api.keys.isCancel(event)) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
                            updateNotification.hide();
                        } else if (event.key === Qt.Key_Left) {
                            event.accepted = true;
                            if (updateNotification.soundEffects) updateNotification.soundEffects.playLeft();
                            openButton.forceActiveFocus();
                        }
                    }
                }
            }

            Item {
                id: notesContainer
                width: parent.width
                visible: updateNotification.expanded && updateNotification.releaseNotes.length > 0
                height: visible
                    ? Math.min(notesText.implicitHeight, metrics ? metrics.updateCardNotesMaxHeight : 220)
                    : 0
                clip: true

                Behavior on height { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }

                Flickable {
                    anchors.fill: parent
                    contentWidth: width
                    contentHeight: notesText.implicitHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    Text {
                        id: notesText
                        width: parent.width
                        text: updateNotification.releaseNotes
                        color: Qt.rgba(1, 1, 1, 0.75)
                        font.family: global.fonts.condensed
                        font.pixelSize: metrics ? metrics.updateCardNotesFontSize : 16
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }

    Keys.onPressed: {
        if (event.isAutoRepeat) return;
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            if (updateNotification.soundEffects) updateNotification.soundEffects.playBack();
            updateNotification.hide();
        }
    }
}
