import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils
import "ColorMapping.js" as ColorMapping
import "gameSystems.js" as GameSystems

FocusScope {
    id: root
    focus: true

    property bool mainMenuVisible: true
    property bool mainMenuFocused: true
    property bool gamesGridVisible: false
    property bool gamesGridFocused: false
    property string currentShortName: ""
    property string collectionDescription: ""
    property var colorMap: ({})
    property string currentColor: "#333333"
    property var currentgame: null
    property bool screensaverActive: false
    property int inactivityTimeout: 60000
    property var randomScreenshots: []
    property int currentScreenshotIndex: 0
    property bool showImage1: true
    property real themeContainerOpacity: 1.0

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
        themeContainerOpacity = 0.0;
        randomScreenshots = Utils.getRandomScreenshots(api.collections);
        if (randomScreenshots.length > 0) {
            currentScreenshotIndex = 0;
            showNextScreenshot();
        }
    }

    function stopScreensaver() {
        screensaverActive = false;
        themeContainerOpacity = 1.0;
        screenshotTransition.stop();
        screenshotImage1.opacity = 0;
        screenshotImage2.opacity = 0;
    }

    function showNextScreenshot() {
        if (screensaverActive && randomScreenshots.length > 0) {
            if (currentScreenshotIndex >= randomScreenshots.length) {
                currentScreenshotIndex = 0;
            }

            var game = Utils.getGameFromScreenshot(api.collections, randomScreenshots[currentScreenshotIndex]);

            if (showImage1) {
                screenshotImage2.source = randomScreenshots[currentScreenshotIndex];
                screenshotImage1.opacity = 0;
                screenshotImage2.opacity = 1;
            } else {
                screenshotImage1.source = randomScreenshots[currentScreenshotIndex];
                screenshotImage2.opacity = 0;
                screenshotImage1.opacity = 1;
            }

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

    function updateCurrentColor() {
        currentColor = ColorMapping.getColor(currentShortName);  // Updated this line
        gradientCanvas.requestPaint();
    }

    function getBatteryIcon() {
        return Utils.getBatteryIcon(api.device.batteryPercent, api.device.batteryCharging);
    }

    Timer {
        id: screenshotTransition
        interval: 5000
        running: screensaverActive
        repeat: true
        onTriggered: showNextScreenshot()
    }

    Rectangle {
        id: imagesScreenshots
        color: "transparent"
        width: parent.width
        height: parent.height
        z: 1001

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

        Image {
            width: parent.width
            height: parent.height
            fillMode: Image.Stretch
            source: "assets/scanline-png/crt.png"
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

    Keys.onPressed: {
        if (screensaverActive) {
            stopScreensaver();
        }
        resetInactivityTimer();
    }

    SoundEffect {
        id: changeSound
        source: "assets/sound/change.wav"
        volume: 0.5
    }

    SoundEffect {
        id: goSound
        source: "assets/sound/go.wav"
        volume: 0.5
    }

    SoundEffect {
        id: backSound
        source: "assets/sound/back.wav"
        volume: 0.5
    }

    SoundEffect {
        id: playSound
        source: "assets/sound/go.wav"
        volume: 1.0
    }

    Component.onCompleted: {
        updateCurrentColor();
    }

    Rectangle {
        id: gradientBackground
        anchors.fill: parent
        color: "transparent"

        Canvas {
            id: gradientCanvas
            anchors.fill: parent
            onPaint: {
                var ctx = gradientCanvas.getContext('2d');
                var gradCenterX = 9;
                var gradCenterY = height;
                var gradRadius = Math.max(width, height)

                var gradient = ctx.createRadialGradient(gradCenterX, gradCenterY, 0, gradCenterX, gradCenterY, gradRadius);
                gradient.addColorStop(0.1, "#000000");
                gradient.addColorStop(0.4, "#191919");
                gradient.addColorStop(1, currentColor);

                ctx.fillStyle = gradient;
                ctx.fillRect(0, 0, width, height);
            }
        }
    }

    Item {
        id: themeContainer
        anchors.fill: parent
        opacity: themeContainerOpacity

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }

        Image {
            id: gamescreenshot
            anchors.top: parent.top
            anchors.right: parent.right
            width: parent.width
            height: parent.height
            fillMode: Image.Stretch
            asynchronous: true
            opacity: 0.2
            visible: gamesGridVisible
        }

        FastBlur {
            id: fastBlurEffect
            source: gamescreenshot
            anchors.fill: gamescreenshot
            radius: 80
            visible: gamesGridVisible
        }

        LinearGradient {
            id: gradientLinear
            visible: gamesGridVisible
            width: parent.width
            height: parent.height * 0.25
            anchors.bottom: gamescreenshot.bottom
            anchors.right: gamescreenshot.right
            start: Qt.point(0, height)
            end: Qt.point(0, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }

        ListView {
            id: collectionsListView
            width: parent.width * 0.90
            height: parent.height * 0.30
            anchors.centerIn: parent
            model: api.collections
            orientation: Qt.Horizontal
            spacing: Math.max(5, width * 0.01)
            visible: mainMenuVisible
            property int indexToPosition: -1

            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 600; easing.type: Easing.OutQuad }
            }

            highlightMoveDuration: 500
            highlightMoveVelocity: -1

            add: Transition {
                NumberAnimation { properties: "x"; from: width; duration: 500 }
            }

            remove: Transition {
                NumberAnimation { properties: "x"; to: -width; duration: 500 }
            }

            delegate: Item {
                id: itemRectangle
                property bool selected: ListView.isCurrentItem
                width: collectionsListView.width * 0.10
                height: collectionsListView.height * 0.90
                scale: selected && collectionsListView.focus ? 1.50 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                }

                clip: false
                z: selected ? 1 : 0

                Behavior on opacity {
                    NumberAnimation { duration: 500 }
                }

                opacity: selected ? 1.0 : 0.5

                Image {
                    id: shortNameImage
                    source: "assets/systems/" + model.shortName + ".png"
                    width: parent.width
                    height: parent.height
                    fillMode: Image.PreserveAspectFit
                    sourceSize { width: 640; height: 480 }
                    scale: selected ? 1.2 : 1
                    mipmap: true
                    asynchronous: true

                    onStatusChanged: {
                        if (status === Image.Error) {
                            source = "assets/systems/default.png";
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: model.shortName
                        color: "white"
                        visible: shortNameImage.status !== Image.Ready
                        font.pixelSize: root.width * 0.012
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 1000
                            easing.type: Easing.InOutQuad
                        }
                    }

                    SequentialAnimation {
                        running: selected
                        loops: Animation.Infinite
                        PropertyAnimation {
                            target: shortNameImage
                            property: "y"
                            from: -5
                            to: 5
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAnimation {
                            target: shortNameImage
                            property: "y"
                            from: 5
                            to: -5
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }

            onCurrentIndexChanged: {
                indexToPosition = currentIndex
                currentShortName = model.get(currentIndex).shortName
                gameGrid.model = api.collections.get(currentIndex).games;
                updateCurrentColor()
                loadCollectionMetadata()
            }

            Component.onCompleted: {
                currentIndex = 0
                currentShortName = model.get(currentIndex).shortName
                updateCurrentColor()
            }

            onIndexToPositionChanged: {
                if (indexToPosition >= 0) {
                    positionViewAtIndex(indexToPosition, ListView.Center)
                }
            }

            focus: mainMenuFocused

            Keys.onPressed: {
                if (!event.isAutoRepeat) {
                    if (api.keys.isAccept(event)) {
                        event.accepted = true;
                        mainMenuVisible = false;
                        mainMenuFocused = false;
                        gamesGridVisible = true;
                        gamesGridFocused = true;
                        goSound.play();
                        currentgame = gameGrid.model.get(gameGrid.currentIndex);
                        if (gameGrid.currentItem && gameGrid.currentItem.updateVideoState) {
                            gameGrid.currentItem.updateVideoState();
                        }
                    } else if (api.keys.isNextPage(event)) {
                        event.accepted = true;
                        if (currentIndex < count - 1) {
                            currentIndex++;
                            changeSound.play();
                        }
                    } else if (api.keys.isPrevPage(event)) {
                        event.accepted = true;
                        if (currentIndex > 0) {
                            currentIndex--;
                            changeSound.play();
                        }
                    }

                    if (root.screensaverActive) {
                        root.stopScreensaver();
                    }
                }
                root.resetInactivityTimer();
            }

            Keys.onLeftPressed: {
                if (currentIndex > 0) {
                    currentIndex--;
                    changeSound.play();
                }

                if (root.screensaverActive) {
                    root.stopScreensaver();
                }
                root.resetInactivityTimer();
            }

            Keys.onRightPressed: {
                if (currentIndex < count - 1) {
                    currentIndex++;
                    changeSound.play();
                }

                if (root.screensaverActive) {
                    root.stopScreensaver();
                }
                root.resetInactivityTimer();
            }
        }

        Rectangle{
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            width: parent.width
            height: parent.height / 2
            color: "transparent"
            clip: true
            visible: gamesGridVisible

            opacity: themeContainerOpacity

            Behavior on opacity {
                NumberAnimation { duration: 1000 }
            }

            GridView {
                id: gameGrid

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }

                width: parent.width * 0.90
                height: parent.height * 0.98

                property int columns: 6
                property int rows: 3

                cellWidth: width / columns
                cellHeight: height / rows

                cacheBuffer: 200

                Component.onCompleted: {
                    if (count > 0) {
                        currentIndex = 0;
                        currentgame = model.get(0);
                        Qt.callLater(function() {
                            if (currentItem && currentItem.updateVideoState) {
                                currentItem.updateVideoState();
                            }
                        });
                    }
                }

                delegate: Item {
                    id: delegateRoot
                    width: gameGrid.cellWidth - gameGrid.cellWidth * 0.030
                    height: gameGrid.cellHeight - gameGrid.cellHeight * 0.050
                    property bool selected: GridView.isCurrentItem

                    scale: selected && gameGrid.focus ? 1.05 : 1

                    property var game
                    property bool isVisible: {
                        var itemY = y + height / 2;
                        var gridTop = gameGrid.contentY;
                        var gridBottom = gameGrid.contentY + gameGrid.height;

                        return itemY >= gridTop && itemY <= gridBottom;
                    }

                    opacity: isVisible ? 1 : 0

                    Behavior on scale {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutQuad
                        }
                    }

                    z: selected ? 1 : 0

                    Component.onCompleted: {
                        updateGame();
                    }

                    function updateGame() {
                        game = gameGrid.model.get(index);
                    }

                    function updateVideoState() {
                        if (loader.item && loader.item.videoLoader.item) {
                            var player = loader.item.videoLoader.item.mediaPlayer;
                            var output = loader.item.videoLoader.item.videoOutput;

                            if (selected && gameGrid.activeFocus) {
                                if (!player.source) {
                                    player.source = game.assets.video;
                                }
                                player.play();
                                player.muted = false;
                                output.visible = true;
                            } else {
                                player.stop();
                                player.source = "";
                                player.muted = true;
                                output.visible = false;
                            }
                        }
                    }

                    Connections {
                        target: gameGrid
                        function onCurrentIndexChanged() {
                            delegateRoot.updateGame();
                            delegateRoot.updateVideoState();
                        }
                        function onActiveFocusChanged() {
                            delegateRoot.updateVideoState();
                        }
                    }

                    Loader {
                        id: loader
                        anchors.fill: parent
                        active: gamesGridVisible && isVisible
                        sourceComponent: Rectangle {
                            id: backgroundRect
                            anchors.fill: parent
                            radius: 10
                            color: "black"

                            property alias videoLoader: videoLoader

                            Item {
                                anchors.fill: parent

                                Rectangle {
                                    id: mask
                                    anchors.fill: parent
                                    radius: 10
                                    visible: false
                                }

                                Image {
                                    id: boxfront
                                    source: game ? game.assets.screenshot : ""
                                    fillMode: Image.PreserveAspectCrop
                                    width: parent.width
                                    height: parent.height
                                    visible: true
                                    asynchronous: true
                                    sourceSize { width: 256; height: 256 }
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: Rectangle {
                                            width: backgroundRect.width
                                            height: backgroundRect.height
                                            radius: 10
                                        }
                                    }
                                }

                                OpacityMask {
                                    anchors.fill: boxfront
                                    source: boxfront
                                    maskSource: mask
                                    visible: true
                                }

                                FastBlur {
                                    id: fastBlur
                                    anchors.fill: parent
                                    source: boxfront
                                    radius: selected ? 0 : 10
                                    opacity: selected ? 0 : 1
                                    visible: opacity > 0 && (!videoLoader.item || !videoLoader.item.videoOutput.visible)

                                    Behavior on radius {
                                        NumberAnimation {
                                            duration: 500
                                            easing.type: Easing.InOutQuad
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 500
                                            easing.type: Easing.InOutQuad
                                        }
                                    }

                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: mask
                                    }
                                }

                                Item {
                                    id: videoContainer
                                    anchors.fill: parent

                                    Loader {
                                        id: videoLoader
                                        anchors.fill: parent
                                        active: delegateRoot.selected && gameGrid.activeFocus
                                        sourceComponent: Item {
                                            property alias mediaPlayer: mediaPlayer
                                            property alias videoOutput: videoOutput

                                            Rectangle {
                                                id: videoMask
                                                anchors.fill: parent
                                                radius: 10
                                                visible: false
                                            }

                                            MediaPlayer {
                                                id: mediaPlayer
                                                source: game ? game.assets.video : ""
                                                videoOutput: videoOutput
                                                loops: 1
                                                autoPlay: true

                                                onStatusChanged: {
                                                    if (status === MediaPlayer.Loaded) {
                                                        play();
                                                    }
                                                    if (status === MediaPlayer.EndOfMedia) {
                                                        videoOutput.visible = false;
                                                        fastBlur.radius = 10;
                                                        fastBlur.opacity = 1;
                                                        logoOverlay.opacity = 1;
                                                    }
                                                    if (status === MediaPlayer.Error) {
                                                        //console.log("Video error:", errorString);
                                                    }
                                                }
                                            }

                                            VideoOutput {
                                                id: videoOutput
                                                anchors.fill: parent
                                                fillMode: VideoOutput.PreserveAspectCrop
                                                visible: delegateRoot.selected && gameGrid.activeFocus

                                                layer.enabled: true
                                                layer.effect: OpacityMask {
                                                    maskSource: Rectangle {
                                                        width: backgroundRect.width
                                                        height: backgroundRect.height
                                                        radius: 10
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Image {
                                    id: logoOverlay
                                    anchors.centerIn: parent
                                    source: game ? game.assets.logo : ""
                                    width: parent.width * 0.6
                                    height: width
                                    opacity: selected ? 0 : 1
                                    fillMode: Image.PreserveAspectFit
                                    asynchronous: true

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 500
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }

                                Rectangle {
                                    anchors.fill: parent
                                    color: "transparent"
                                    visible: boxfront.status !== Image.Ready || (videoLoader.item && videoLoader.item.mediaPlayer.status !== MediaPlayer.Loaded)

                                    Image {
                                        id: loadingSpinner
                                        anchors.centerIn: parent
                                        width: 50
                                        height: 50
                                        source: "assets/icons/loading-spinner.svg"
                                        mipmap: true
                                        visible: boxfront.status === Image.Loading || (videoLoader.item && videoLoader.item.mediaPlayer.status === MediaPlayer.Loading)

                                        RotationAnimator on rotation {
                                            loops: Animator.Infinite
                                            from: 0
                                            to: 360
                                            duration: 1000
                                        }
                                    }
                                }

                                Text {
                                    id: fallbackText
                                    anchors.centerIn: parent
                                    text: game ? game.title : ""
                                    color: "white"
                                    font.pixelSize: parent.width * 0.1
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.Wrap
                                    width: parent.width * 0.9
                                    visible: {
                                        return (!boxfront.source || boxfront.status === Image.Error) &&
                                        (!logoOverlay.source || logoOverlay.status === Image.Error)
                                    }
                                }

                                Rectangle {
                                    id: playGameButton
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: parent.height * 0.05
                                    width: parent.width * 0.5
                                    height: parent.height * 0.2
                                    color: Qt.rgba(1, 1, 1, 0.5)
                                    radius: 20
                                    opacity: delegateRoot.selected ? 1 : 0
                                    z: 1000

                                    visible: true

                                    scale: playGameMouseArea.pressed ? 0.95 : 1.0
                                    Behavior on scale {
                                        NumberAnimation { duration: 100 }
                                    }

                                    Behavior on color {
                                        ColorAnimation { duration: 100 }
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: "Play"
                                        color: "white"
                                        font.pixelSize: parent.height * 0.4
                                        font.bold: true
                                    }

                                    MouseArea {
                                        id: playGameMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            parent.color = Qt.rgba(0.8, 0.8, 0.8, 0.7);
                                            playSound.play();

                                            timer.start();
                                        }

                                        onPressed: {
                                            parent.color = Qt.rgba(0.7, 0.7, 0.7, 0.7);
                                        }

                                        onReleased: {
                                            if (!containsMouse) {
                                                parent.color = Qt.rgba(1, 1, 1, 0.5);
                                            }
                                        }

                                        onEntered: {
                                            parent.color = Qt.rgba(0.9, 0.9, 0.9, 0.6);
                                        }

                                        onExited: {
                                            parent.color = Qt.rgba(1, 1, 1, 0.5);
                                        }
                                    }

                                    Timer {
                                        id: timer
                                        interval: 150
                                        onTriggered: {
                                            if (currentgame) {
                                                api.memory.set('lastPlayedGame', currentgame);
                                                currentgame.launch();
                                            }
                                            playGameButton.color = Qt.rgba(1, 1, 1, 0.5);
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 600
                                            easing.type: Easing.InOutQuad
                                        }
                                    }

                                    onVisibleChanged: {
                                        opacity = visible ? 1 : 0
                                    }
                                }
                            }
                        }
                    }
                }

                onCurrentIndexChanged: {
                    changeSound.play();
                    var selectedGame = gameGrid.model.get(gameGrid.currentIndex);
                    gamescreenshot.source = selectedGame.assets.screenshot;
                    currentgame = gameGrid.model.get(currentIndex);
                }

                focus: gamesGridFocused

                Keys.onLeftPressed: {
                    if (currentIndex > 0) {
                        currentIndex--;
                        changeSound.play()
                    }

                    if (root.screensaverActive) {
                        root.stopScreensaver();
                    }
                    root.resetInactivityTimer();
                }

                Keys.onRightPressed: {
                    if (currentIndex < count - 1) {
                        currentIndex++;
                        changeSound.play()
                    }

                    if (root.screensaverActive) {
                        root.stopScreensaver();
                    }
                    root.resetInactivityTimer();
                }

                Keys.onPressed: {
                    if (!event.isAutoRepeat && api.keys.isCancel(event)) {
                        event.accepted = true;
                        mainMenuVisible = true;
                        mainMenuFocused = true;
                        gamesGridVisible = false;
                        gamesGridFocused = false;
                        backSound.play();

                        if (root.screensaverActive) {
                            root.stopScreensaver();
                        }
                    }
                    root.resetInactivityTimer();
                }
            }
        }

        Rectangle {
            id: bottomRectangle
            width: parent.width
            height: parent.height * 0.33
            anchors.top: collectionsListView.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            anchors.topMargin: 25
            visible: mainMenuVisible

            Image {
                id: logoImage
                source: "assets/logos/" + currentShortName + ".png"
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
                anchors.leftMargin: root.width *0.080
                anchors.top: parent.top
                anchors.topMargin: 20
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
                    font.pixelSize: root.width * 0.012
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
    }

    Item {
        id: topBar
        width: parent.width
        height: root.height * 0.060
        anchors {
            top: parent.top
            topMargin: 20
        }

        opacity: themeContainerOpacity

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }

        Row {
            id: topRow
            width: parent.width
            height: parent.height
            anchors.margins: 10
            spacing: 10

            Item { width: root.width * 0.015; height: 60 }

            Text {
                id: clock
                color: "white"
                font.pixelSize: root.width * 0.02
                font.bold: true
                visible: true
                horizontalAlignment: Text.AlignLeft
                width: contentWidth
                anchors.verticalCenter: parent.verticalCenter
                x: gamesGridVisible ? root.width * 0.80 : root.width * 0.015;
                function formatTime() {
                    let date = new Date();
                    let hours = date.getHours();
                    let minutes = date.getMinutes();
                    let ampm = hours >= 12 ? "PM" : "AM";
                    hours = hours % 12;
                    hours = hours ? hours : 12;
                    let minutesStr = minutes < 10 ? "0" + minutes : minutes;
                    return hours + ":" + minutesStr + " " + ampm;
                }
                text: formatTime()
                Timer {
                    running: true
                    interval: 1000
                    repeat: true
                    onTriggered: clock.text = clock.formatTime()
                }
            }

            Item { width: parent.width - clock.width - batteryIcon.width - 20; height: 60 }

            Image {
                id: batteryIcon
                source: getBatteryIcon()
                width: root.width * 0.20
                height: root.height * 0.03
                fillMode: Image.PreserveAspectFit
                mipmap: true
                asynchronous: true
                visible: true
                anchors.verticalCenter: parent.verticalCenter
                Timer {
                    id: batteryUpdateTimer
                    triggeredOnStart: true
                    interval: 5000
                    running: true
                    repeat: true
                    onTriggered: batteryIcon.source = getBatteryIcon()
                }
            }

            Item { width: root.width * 0.010; height: 60 }
        }
    }

    Item {
        id: logoContainer
        width: parent.width * 0.4
        height: parent.height * 0.3

        anchors {
            top: topBar.bottom
            right: parent.right
            topMargin: 20
            rightMargin: parent.width * 0.05
        }

        visible: gamesGridVisible && gamesGridFocused
        opacity: 0.1 * themeContainerOpacity

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }

        Image {
            id: logoImage2
            source: "assets/logos/" + currentShortName + ".png"
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            mipmap: true
            anchors.centerIn: parent

            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Error cargando la imagen del logo.");
                }
            }
        }
    }

    Item {
        id: leftColumn
        width: parent.width * 0.80
        height: parent.height * 0.51
        visible: gamesGridVisible
        clip: true

        anchors {
            left: parent.left
            leftMargin: parent.width * 0.03
            top: parent.top
            topMargin: root.height * 0.01
        }

        opacity: themeContainerOpacity

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }

        Column {
            anchors.fill: parent
            anchors.leftMargin: root.width * 0.020
            anchors.topMargin: root.height * 0.010
            spacing: 20

            Item {
                width: root.width * 0.30
                height: root.height * 0.20

                Image {
                    id: gameLogo
                    anchors.fill: parent
                    source: currentgame.assets.logo
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                    visible: status !== Image.Error
                }

                Image {
                    id: fallbackImage
                    anchors.fill: parent
                    source: "assets/logos/default.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                    visible: gameLogo.status === Image.Error
                }
            }

            Row {
                spacing: 10

                Rectangle {
                    id: text_developer
                    width: developer_text.width + 20
                    height: developer_text.height + 6
                    color: Qt.rgba(0, 0, 0, 0.5)
                    border.color: "white"
                    border.width: 2

                    Text {
                        id: developer_text
                        text: Utils.formatGameDeveloper(currentgame.developer)
                        color: "white"
                        font.bold: true
                        font.pixelSize: root.width * 0.012
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: releaseyear_text.width + 20
                    height: releaseyear_text.height + 6
                    color: Qt.rgba(0, 0, 0, 0.5)
                    border.color: "white"
                    border.width: 2

                    Text {
                        id: releaseyear_text
                        text: Utils.getReleaseYearText(currentgame.releaseYear)
                        color: "white"
                        font.bold: true
                        font.pixelSize: root.width * 0.012
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: genre_text.width + 20
                    height: genre_text.height + 6
                    color: Qt.rgba(0, 0, 0, 0.5)
                    border.color: "white"
                    border.width: 2

                    Text {
                        id: genre_text
                        text: Utils.formatGameGenre(currentgame.genre)
                        color: "white"
                        font.bold: true
                        font.pixelSize: root.width * 0.012
                        anchors.centerIn: parent
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        elide: Text.ElideMiddle
                    }
                }

                Rectangle {
                    id: ratingContainer
                    width: rating_content.width + 20
                    height: text_developer.height
                    color: Qt.rgba(0, 0, 0, 0.5)
                    border.color: "white"
                    border.width: 2

                    Row {
                        id: rating_content
                        anchors.centerIn: parent
                        spacing: 2

                        Repeater {
                            model: Utils.displayRating(currentgame.rating).split(" ").length
                            Image {
                                source: Utils.displayRating(currentgame.rating).split(" ")[index]
                                width: root.width * 0.012
                                height: width
                                mipmap: true
                            }
                        }
                    }
                }

                Rectangle {
                    width: players_content.width + 20
                    height: text_developer.height
                    color: Qt.rgba(0, 0, 0, 0.5)
                    border.color: "white"
                    border.width: 2
                    visible: currentgame.players > 1

                    Row {
                        id: players_content
                        anchors.centerIn: parent
                        spacing: 2

                        Repeater {
                            model: {
                                var playersContent = Utils.getPlayersContent(currentgame.players);
                                return playersContent ? playersContent.count : 0;
                            }

                            Image {
                                source: {
                                    var playersContent = Utils.getPlayersContent(currentgame.players);
                                    return playersContent ? playersContent.source : "";
                                }
                                width: root.width * 0.012
                                height: width
                                fillMode: Image.PreserveAspectFit
                                mipmap: true
                            }
                        }
                    }
                }
            }

            PegasusUtils.AutoScroll {
                id: autoscroll
                anchors {
                    left: parent.left
                    right: parent.right
                }

                pixelsPerSecond: 50
                scrollWaitDuration: 3000

                height: parent.height * 0.35

                Text {
                    id: descripText
                    text: Utils.formatGameDescription(currentgame.description)
                    width: parent.width * 0.6
                    wrapMode: Text.Wrap
                    font.pixelSize: root.width * 0.012
                    color: "white"
                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "black"
                        radius: 2
                        samples: 5
                        spread: 0.5
                    }
                }
            }
        }
    }

    function loadCollectionMetadata() {
        var metadataFound = false;
        var systemName = "None";
        var releaseYear = "None";
        var description = "None";
        var gameCount = 0;

        var systemData = GameSystems.getSystemMetadata(currentShortName);  // Changed from Utils to GameSystems
        if (systemData) {
            systemName = systemData.systemName;
            releaseYear = systemData.releaseYear.toString();
            description = systemData.description;
            metadataFound = true;
        }

        gameCount = api.collections.get(collectionsListView.currentIndex).games.count;

        collectionDescription = "Release Year: " + releaseYear + "\n" +
        "Games in your collection: " + gameCount + "\n" +
        "Description: " + description;
    }
}
