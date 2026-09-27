import QtQuick 2.15

Item {
    id: logoContainer
    width: metrics ? metrics.logoContainerWidth : parent.width * 0.4
    height: metrics ? metrics.logoContainerHeight : parent.height * 0.3
    property real themeContainerOpacity: 1.0
    property string currentShortName: ""
    property bool visibleState: false
    property var metrics: null
    visible: visibleState
    opacity: 0.1 * themeContainerOpacity

    Behavior on opacity {
        NumberAnimation { duration: 1000 }
    }

    Image {
        id: logoImage2
        source: currentShortName ? "assets/logos/" + currentShortName + ".png" : "assets/logos/default.png"
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        mipmap: true
        anchors.centerIn: parent
        visible: status === Image.Ready
    }

    Image {
        id: fallbackImage
        anchors.fill: parent
        source: "assets/logos/default.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
        visible: logoImage2.status === Image.Error
    }
}
