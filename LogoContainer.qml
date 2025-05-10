import QtQuick 2.15

Item {
    id: logoContainer
    width: parent.width * 0.4
    height: parent.height * 0.3

    property real themeContainerOpacity: 1.0
    property string currentShortName: ""
    property bool visibleState: false

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

        onStatusChanged: {
            if (status === Image.Error) {
                //console.log("Error cargando la imagen del logo para:", currentShortName);
            }
        }
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
