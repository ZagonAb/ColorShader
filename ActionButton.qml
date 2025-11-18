import QtQuick 2.15
import QtGraphicalEffects 1.12

Rectangle {
    id: actionButton
    property string iconSource: ""
    property string buttonText: ""
    property real iconSizeRatio: 0.6
    property real textSizeRatio: 0.45
    property Item rootReference: null

    signal clicked()

    width: rootReference ? rootReference.width * 0.1 : 120
    height: rootReference ? rootReference.height * 0.06 : 60

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
        spacing: actionButton.height * 0.15
        width: Math.min(implicitWidth, actionButton.width - actionButton.padding * 2)
        height: actionButton.height * 0.7
        clip: true

        Image {
            id: icon
            source: iconSource
            width: height
            height: parent.height * iconSizeRatio
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            mipmap: true
            antialiasing: true
            opacity: mouseArea.containsMouse ? 1.0 : 0.8

            Component.onCompleted: {
                if (height < 12) height = 12
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
