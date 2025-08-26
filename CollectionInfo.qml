import QtQuick 2.15
import QtGraphicalEffects 1.12
import "utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils

Rectangle {
    id: collectionInfo
    width: parent.width
    height: parent.height * 0.33
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"
    anchors.topMargin: 25
    visible: true
    property string currentShortName: ""
    property string collectionSystemInfo: ""
    property string collectionDescription: ""
    property int textWidth: 0

    FontLoader {
        id: gruppoFont
        source: "assets/font/LeagueGothic.ttf"
    }

    FontLoader {
        id: mitrFont
        source: "assets/font/BlackHanSans.ttf"
    }

    Item {
        id: container
        width: parent.width * 0.90
        height: parent.height
        anchors.centerIn: parent

        Text {
            id: systemInfoText
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 15
            text: collectionSystemInfo
            color: "white"
            font {
                family: mitrFont.name
                pixelSize: Math.max(14, width * 0.023)
            }
            horizontalAlignment: Text.AlignHCenter
            opacity: 0

            Text {
                id: textMetrics
                visible: false
                font: systemInfoText.font
                text: systemInfoText.text
                onTextChanged: Utils.updateTextWidth()
                Component.onCompleted: Utils.updateTextWidth()
            }

            Behavior on opacity {
                OpacityAnimator { duration: 800 }
            }
        }

        Rectangle {
            id: separator
            width: Math.min(Math.max(collectionInfo.textWidth, parent.width * 0.5), parent.width * 0.95)
            height: 1
            color: "#80ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: systemInfoText.bottom
            anchors.topMargin: 15
            opacity: 0

            Behavior on width {
                NumberAnimation { duration: 800; easing.type: Easing.OutQuad }
            }

            Behavior on opacity {
                OpacityAnimator { duration: 800 }
            }
        }

        Item {
            id: descriptionContainer
            width: parent.width
            anchors.top: separator.bottom
            anchors.topMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            clip: true

            Item {
                id: scrollWrapper
                width: parent.width
                height: parent.height

                PegasusUtils.AutoScroll {
                    id: autoscroll
                    width: parent.width
                    height: parent.height * 0.8
                    pixelsPerSecond: 40
                    scrollWaitDuration: 3000

                    Text {
                        id: descriptionText
                        width: parent.width
                        text: collectionDescription
                        color: "white"

                        font {
                            family: gruppoFont.name
                            pixelSize: systemInfoText.font.pixelSize
                        }

                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        opacity: 0

                        Behavior on opacity {
                            OpacityAnimator { duration: 1200 }
                        }
                    }
                }
            }
        }
    }

    onCollectionSystemInfoChanged: {
        systemInfoText.opacity = 0
        separator.opacity = 0
        systemInfoText.opacity = 0.3
        separator.opacity = 0.3
    }

    onCollectionDescriptionChanged: {
        descriptionText.opacity = 0
        descriptionText.opacity = 0.3
    }

    Component.onCompleted: {
        systemInfoText.opacity = 0.3
        separator.opacity = 0.3
        descriptionText.opacity = 0.3
    }
}
