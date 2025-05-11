import QtQuick 2.15
import QtGraphicalEffects 1.12

Rectangle {
    id: actionButton

    property string iconSource: ""
    property string buttonText: ""
    property real iconSizeRatio: 0.6
    property real textSizeRatio: 0.35
    property int minHeight: 35
    property int maxHeight: 70
    property int minWidth: 100

    signal clicked()

    width: Math.max(minWidth, implicitWidth)
    height: Math.min(Math.max(minHeight, parent ? parent.height * 0.8 : minHeight), maxHeight)
    implicitWidth: (contentRow.width + padding * 2)
    property int padding: height * 0.3

    color: Qt.rgba(1, 1, 1, 0.5)
    radius: height / 2
    border.color: Qt.rgba(1, 1, 1, 0.7)
    border.width: 1

    scale: mouseArea.pressed ? 0.95 : 1.0
    Behavior on scale { NumberAnimation { duration: 100 } }
    Behavior on color { ColorAnimation { duration: 100 } }
    Behavior on opacity { NumberAnimation { duration: 100 } }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: height * 0.2

        Image {
            id: icon
            source: iconSource
            width: height
            height: parent.parent.height * iconSizeRatio
            fillMode: Image.PreserveAspectFit
            mipmap: true
            antialiasing: true
            verticalAlignment: Image.AlignVCenter
            opacity: mouseArea.containsMouse ? 1.0 : 0.8

            onStatusChanged: {
                if (status === Image.Error) {
                    source = "assets/icons/default.svg"
                }
                console.log("Icon status:", status, "Source:", source)
            }

            Behavior on opacity { NumberAnimation { duration: 100 } }
        }

        Text {
            id: text
            text: buttonText
            color: "white"
            font {
                pixelSize: parent.parent.height * textSizeRatio
                bold: true
            }
            verticalAlignment: Text.AlignVCenter
            height: icon.height
            opacity: icon.opacity
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        z: 100

        onEntered: actionButton.color = Qt.rgba(0.9, 0.9, 0.9, 0.6)
        onExited: actionButton.color = Qt.rgba(1, 1, 1, 0.5)
        onPressed: actionButton.color = Qt.rgba(0.7, 0.7, 0.7, 0.7)
        onReleased: if (!containsMouse) actionButton.color = Qt.rgba(1, 1, 1, 0.5)
        onClicked: {
            console.log("ActionButton clicked: " + buttonText)
            actionButton.clicked()
        }
    }
}
