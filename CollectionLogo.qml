import QtQuick 2.15

Rectangle {
    id: collectionLogo
    width: parent.width
    height: parent.height * 0.33
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"
    anchors.topMargin: 25
    visible: true

    property string currentShortName: ""
    property string collectionDescription: ""

    Image {
        id: logoImage
        source: currentShortName ? "assets/logos/" + currentShortName + ".png" : "assets/logos/default.png"
        width: parent.width * 0.3
        height: parent.height * 0.8
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        mipmap: true
        opacity: 0

        Behavior on opacity {
            OpacityAnimator { duration: 1500 }
        }
        onSourceChanged: {
            logoImage.opacity = 0
            logoImage.opacity = 0.7
            logoText.opacity = 0
            logoText.opacity = 0.7
        }

        anchors.left: parent.left
        anchors.leftMargin: width * 0.27
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    Image {
        id: fallbackImage
        width: parent.width * 0.3
        height: parent.height * 0.8
        source: "assets/logos/default.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
        visible: logoImage.status === Image.Error
        anchors {
            horizontalCenter: parent.left
            horizontalCenterOffset: parent.width * 0.25
            top: parent.top
            topMargin: 20
        }
        opacity: 0.7
    }

    Item {
        id: descriptionText
        width: (parent.width / 2) + (parent.width * 0.1)
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Text {
            id: logoText
            width: parent.width * 0.90
            text: collectionDescription
            color: "white"
            font.pixelSize: width * 0.022
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            opacity: 0
            Behavior on opacity {
                OpacityAnimator { duration: 1500 }
            }
        }
    }
}
