import QtQuick 2.15
import QtGraphicalEffects 1.12

Rectangle {
    id: actionButton
    property string iconSource: ""
    property string buttonText: ""
    property real iconSizeRatio: 0.6
    property real textSizeRatio: 0.45
    property Item rootReference: null
    property var metrics: null
    property bool compact: false

    signal clicked()

    width: compact
    ? (metrics ? metrics.actionButtonDiameterCompact : 60)
    : (metrics ? metrics.actionButtonWidth : (rootReference ? rootReference.width * 0.1 : 120))
    height: compact
    ? width
    : (metrics ? metrics.actionButtonHeight : (rootReference ? rootReference.height * 0.06 : 60))

    property real padding: height * 0.2

    color: Qt.rgba(0, 0, 0, 0.6)
    radius: height / 2
    border.color: Qt.rgba(0, 0, 0, 0.7)
    border.width: Math.max(1, height * 0.02)

    scale: mouseArea.pressed ? 0.95 : 1.0
    Behavior on scale { NumberAnimation { duration: 100 } }
    Behavior on color { ColorAnimation { duration: 100 } }
    Behavior on opacity { NumberAnimation { duration: 100 } }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: actionButton.compact ? 0 : actionButton.height * 0.15
        width: actionButton.compact
        ? Math.round(actionButton.height * 0.55)
        : Math.min(implicitWidth, actionButton.width - actionButton.padding * 2)
        height: actionButton.compact
        ? Math.round(actionButton.height * 0.55)
        : actionButton.height * 0.7
        clip: true

        Image {
            id: icon
            source: iconSource
            width: actionButton.compact ? parent.height : height
            height: actionButton.compact ? parent.height : parent.height * iconSizeRatio
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            mipmap: true
            antialiasing: true
            opacity: mouseArea.containsMouse ? 1.0 : 0.8

            Component.onCompleted: {
                if (!actionButton.compact && height < 12) height = 12
            }

            onStatusChanged: {
                if (status === Image.Error) {
                    source = "assets/icons/default.svg"
                }
            }

            Behavior on opacity { NumberAnimation { duration: 100 } }
        }

        Text {
            id: textElement
            visible: !actionButton.compact
            text: buttonText
            color: "white"
            font {
                pixelSize: Math.max(8, contentRow.height * textSizeRatio)
                bold: true
            }
            anchors.verticalCenter: parent.verticalCenter
            opacity: icon.opacity
            elide: Text.ElideRight
            width: Math.min(implicitWidth,
                            actionButton.width - icon.width - contentRow.spacing - actionButton.padding * 2)

            Behavior on text {
                SequentialAnimation {
                    NumberAnimation { target: textElement; property: "opacity"; to: 0; duration: 100 }
                    PropertyAction {}
                    NumberAnimation { target: textElement; property: "opacity"; to: 1; duration: 100 }
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        z: 100

        onEntered: actionButton.color = Qt.rgba(0, 0, 0, 0.8)
        onExited: actionButton.color = Qt.rgba(0, 0, 0, 0.6)
        onPressed: actionButton.color = Qt.rgba(0, 0, 0, 0.9)
        onReleased: if (!containsMouse) actionButton.color = Qt.rgba(0, 0, 0, 0.7)
        onClicked: {
            actionButton.clicked()
        }
    }
}
