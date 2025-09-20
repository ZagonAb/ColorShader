import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "./Components" as Components
import "GameFilters.js" as GameFilters
import "utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    id: root
    focus: true
    property var filterFunctions: GameFilters.getFilterFunctions()
    property bool screensaverActive: screensaver.screensaverActive
    property string collectionDescription: ""
    property string collectionSystemInfo: ""
    property real themeContainerOpacity: 1.0
    property string currentColor: "#333333"
    property int inactivityTimeout: 240000
    property bool gamesGridVisible: false
    property bool gamesGridFocused: false
    property alias proxyModel: proxyModel
    property string currentScreenshot: ""
    property string currentShortName: ""
    property bool mainMenuVisible: true
    property bool mainMenuFocused: true
    property var randomScreenshots: []
    property bool useFirstImage: true
    property string pendingSource: ""
    property var currentgame: null
    property var colorMap: ({})

    SoundEffects {
        id: soundEffects
    }

    function updateCurrentColor() {
        currentColor = myColorMapping.getColor(currentShortName);
        gradientCanvas.requestPaint();
    }

    function getGameFromScreenshot(screenshot) {
        return Utils.getGameFromScreenshot(api.collections, screenshot);
    }

    function updateFilterButtonState() {
        var currentCollection = api.collections.get(collectionsListView.currentIndex);
        gameActionBar.filterButtonEnabled =
        GameFilters.hasGamesWithFilter(currentCollection, "Favorites") ||
        GameFilters.hasGamesWithFilter(currentCollection, "Last played");
    }

    function getCurrentFilterFunction() {
        return filterFunctions[gameActionBar.currentFilter] || filterFunctions["All Games"];
    }

    Timer {
        id: safetyTimer
        interval: 500
        onTriggered: {
            if (gameGrid.count === 0 && currentFilter === "Favorites") {
                //console.log("[Safety Timer] No hay favoritos - Cambiando a All Games");
                currentFilter = "All Games";
                Qt.callLater(proxyModel.invalidate);
            }
        }
    }

    Component.onCompleted: {
        Qt.onUncaughtError = function(error) {
            console.error("Error no capturado:", error);
            if (currentFilter === "Favorites" && proxyModel.count === 0) {
                console.log("Recuperando de error - cambiando a All Games");
                currentFilter = "All Games";
                proxyModel.invalidate();
            }
        };

        updateCurrentColor();
        screensaver.randomScreenshots = Utils.getRandomScreenshots(api.collections);

    }

    Components.Screensaver {
        id: screensaver
        inactivityTimeout: root.inactivityTimeout
        visible: screensaverActive

        onScreensaverStarted: {
            themeContainerOpacity = 0.0;
        }

        onScreensaverStopped: {
            themeContainerOpacity = 1.0;
        }

        function getGameFromScreenshot(screenshot) {
            return Utils.getGameFromScreenshot(api.collections, screenshot);
        }
    }

    Components.GameSystems {
        id: myGameSystems
    }

    Components.ColorMapping {
        id: myColorMapping
    }

    Keys.onPressed: {
        if (screensaver.screensaverActive) {
            screensaver.stopScreensaver();
        }
        screensaver.resetInactivityTimer();
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            if (screensaver.screensaverActive) {
                screensaver.stopScreensaver();
            }
            screensaver.resetInactivityTimer();
        }
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

        Item {
            id: screenshotsContainer
            anchors.top: parent.top
            anchors.right: parent.right
            width: parent.width
            height: parent.height
            visible: gamesGridVisible

            Item {
                id: container1
                anchors.fill: parent
                opacity: useFirstImage ? 1 : 0.5

                Behavior on opacity {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.InOutQuad
                    }
                }

                Image {
                    id: screenshotImage1
                    anchors.fill: parent
                    fillMode: Image.Stretch
                    asynchronous: true
                    visible: false
                }


                FastBlur {
                    anchors.fill: parent
                    source: screenshotImage1
                    radius: 80
                    visible: true
                    cached: true
                }
            }

            Item {
                id: container2
                anchors.fill: parent
                opacity: !useFirstImage ? 1 : 0.5

                Behavior on opacity {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.InOutQuad
                    }
                }

                Image {
                    id: screenshotImage2
                    anchors.fill: parent
                    fillMode: Image.Stretch
                    asynchronous: true
                    visible: false
                }

                FastBlur {
                    anchors.fill: parent
                    source: screenshotImage2
                    radius: 80
                    visible: true
                    cached: true
                }
            }

            LinearGradient {
                id: gradientLinear
                visible: true
                width: parent.width
                height: parent.height * 0.25
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                start: Qt.point(0, height)
                end: Qt.point(0, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF000000" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
                z: 10
            }

            Timer {
                id: transitionTimer
                interval: 50
                onTriggered: {
                    if (pendingSource !== "") {
                        if (useFirstImage) {
                            screenshotImage1.source = pendingSource;
                        } else {
                            screenshotImage2.source = pendingSource;
                        }
                        pendingSource = "";

                        Qt.callLater(function() {
                            if (useFirstImage) {
                                container2.opacity = 0;
                                container1.opacity = 1;
                            } else {
                                container1.opacity = 0;
                                container2.opacity = 1;
                            }
                        });
                    }
                }
            }

            function setScreenshot(source) {
                var imageSource = "";
                var selectedGame = gameGrid.model.get(gameGrid.currentIndex);
                if (selectedGame) {
                    imageSource = selectedGame.assets.background || selectedGame.assets.screenshot || "";
                }

                if (imageSource !== currentScreenshot) {
                    currentScreenshot = imageSource;
                    pendingSource = imageSource;
                    useFirstImage = !useFirstImage;
                    transitionTimer.start();
                }
            }

            Component.onCompleted: {
                if (gameGrid.model && gameGrid.model.count > 0 && gameGrid.currentIndex >= 0) {
                    var selectedGame = gameGrid.model.get(gameGrid.currentIndex);
                    if (selectedGame && selectedGame.assets) {
                        var imageSource = selectedGame.assets.background || selectedGame.assets.screenshot || "";
                        if (imageSource) {
                            screenshotImage1.source = imageSource;
                            container1.opacity = 0.2;
                            currentScreenshot = imageSource;
                        }
                    }
                }
            }
        }

        SystemLogo {
            id: systemLogo
            currentShortName: root.currentShortName
            themeContainerOpacity: root.themeContainerOpacity
            visible: mainMenuVisible
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
                width: collectionsListView.width * 0.13
                height: collectionsListView.height * 0.90
                scale: selected && collectionsListView.focus ? 1.50 : 1.0
                clip: false
                z: selected ? 1 : 0

                Behavior on scale {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 500 }
                }

                opacity: selected ? 1.0 : 0.3

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
                indexToPosition = currentIndex;
                currentShortName = model.get(currentIndex).shortName;
                updateCurrentColor();
                loadCollectionMetadata();
                var currentCollection = api.collections.get(currentIndex);
                gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);
                gameActionBar.currentFilter = "All Games";

                if (collectionInfo.autoscroll) {
                    collectionInfo.autoscroll.restart();
                }
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
                        soundEffects.playChange();
                        currentgame = gameGrid.model.get(gameGrid.currentIndex);
                        if (gameGrid.currentItem && gameGrid.currentItem.updateVideoState) {
                            gameGrid.currentItem.updateVideoState();
                        }
                    } else if (api.keys.isNextPage(event)) {
                        event.accepted = true;
                        if (currentIndex < count - 1) {
                            currentIndex++;
                            soundEffects.playChange();
                        }
                    } else if (api.keys.isPrevPage(event)) {
                        event.accepted = true;
                        if (currentIndex > 0) {
                            currentIndex--;
                            soundEffects.playChange();
                        }
                    }

                    if (screensaver.screensaverActive) {
                        screensaver.stopScreensaver();
                    }
                }
                screensaver.resetInactivityTimer();
            }

            Keys.onLeftPressed: {
                if (currentIndex > 0) {
                    currentIndex--;
                    soundEffects.playChange()
                }

                if (screensaver.screensaverActive) {
                    screensaver.stopScreensaver();
                }
                screensaver.resetInactivityTimer();
            }

            Keys.onRightPressed: {
                if (currentIndex < count - 1) {
                    currentIndex++;
                    soundEffects.playChange();
                }

                if (screensaver.screensaverActive) {
                    screensaver.stopScreensaver();
                }
                screensaver.resetInactivityTimer();
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

                property int columns: 4
                property int rows: 2

                cellWidth: width / columns
                cellHeight: height / rows

                cacheBuffer: 200

                model: SortFilterProxyModel {
                    id: proxyModel
                    sourceModel: api.collections.get(collectionsListView.currentIndex).games

                    filters: ExpressionFilter {
                        expression: {
                            var filterFunc = root.getCurrentFilterFunction();
                            return filterFunc(model);
                        }
                    }

                    sorters: [
                        RoleSorter {
                            roleName: "lastPlayed"
                            sortOrder: Qt.DescendingOrder
                            enabled: gameActionBar.currentFilter === "Last played"
                        },
                        RoleSorter {
                            roleName: "title"
                            sortOrder: Qt.AscendingOrder
                            enabled: gameActionBar.currentFilter !== "Last played"
                        }
                    ]

                    onCountChanged: {
                        if (count > 0) {
                            if (gameGrid.currentIndex >= count) {
                                gameGrid.currentIndex = count - 1;
                            }
                            currentgame = gameGrid.model.get(gameGrid.currentIndex);
                        } else {
                            currentgame = null;

                            if (gameActionBar.currentFilter === "Favorites") {
                                console.log("Lista de favoritos vacía - cambiando a All Games");
                                gameActionBar.currentFilter = "All Games";
                                Qt.callLater(proxyModel.invalidate);
                            } else {
                                currentgame = null;
                                if (gameActionBar.currentFilter === "Favorites") {
                                    console.log("Lista vacía - Activando timer de seguridad");
                                    safetyTimer.restart();
                                }
                            }
                        }
                    }
                }

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
                    scale: selected && gameGrid.focus ? 1.05 : 1
                    property bool selected: GridView.isCurrentItem
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
                                player.muted = api.memory.get('videoMuted') || false;
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
                                clip: true

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
                                    width: parent.width - 1
                                    height: parent.height - 2
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
                                    visible: tru
                                }

                                FastBlur {
                                    id: fastBlur
                                    anchors.fill: parent
                                    source: boxfront
                                    radius: selected ? 0 : 40
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
                                                muted: api.memory.get('videoMuted') || false

                                                onStatusChanged: {
                                                    if (status === MediaPlayer.Loaded) {
                                                        play();
                                                        muted = api.memory.get('videoMuted') || false;
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
                                                anchors.margins: 1
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
                                    width: parent.width * 0.7
                                    height: parent.height * 0.7
                                    opacity: selected ? 0 : 1
                                    fillMode: Image.PreserveAspectFit
                                    asynchronous: true
                                    mipmap: true

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
                                            soundEffects.playChange();
                                            var sourceIndex = proxyModel.mapToSource(gameGrid.currentIndex);
                                            var sourceModel = api.collections.get(collectionsListView.currentIndex).games;
                                            if (sourceModel && sourceIndex >= 0 && sourceIndex < sourceModel.count) {
                                                var gameToLaunch = sourceModel.get(sourceIndex);
                                                if (gameToLaunch) {
                                                    timer.gameToLaunch = gameToLaunch;
                                                    timer.start();
                                                }
                                            }
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
                                        property var gameToLaunch: null
                                        onTriggered: {
                                            if (gameToLaunch) {
                                                api.memory.set('lastPlayedGame', gameToLaunch);
                                                gameToLaunch.launch();
                                                gameToLaunch = null;
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

                                Rectangle {
                                    id: muteButton
                                    property bool isMuted: api.memory.get('videoMuted') || false

                                    anchors {
                                        right: playGameButton.left
                                        rightMargin: parent.width * 0.02
                                        verticalCenter: playGameButton.verticalCenter
                                    }

                                    width: parent.width * 0.15
                                    height: parent.height * 0.2
                                    color: Qt.rgba(1, 1, 1, 0.5)
                                    radius: 20
                                    z: 1000

                                    opacity: {
                                        if (!delegateRoot.selected) return 0;
                                        if (!videoLoader.item) return 0;
                                        return videoLoader.item.videoOutput.visible ? 1 : 0;
                                    }

                                    Image {
                                        anchors.centerIn: parent
                                        source: muteButton.isMuted ? "assets/icons/mute.png" : "assets/icons/volume.png"
                                        width: parent.width * 0.7
                                        height: width
                                        mipmap: true
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            soundEffects.playChange();
                                            muteButton.isMuted = !muteButton.isMuted;
                                            api.memory.set('videoMuted', muteButton.isMuted);

                                            if (videoLoader.item) {
                                                videoLoader.item.mediaPlayer.muted = muteButton.isMuted;
                                            }
                                        }

                                        onPressed: parent.color = Qt.rgba(0.7, 0.7, 0.7, 0.7)
                                        onReleased: parent.color = containsMouse ? Qt.rgba(0.9, 0.9, 0.9, 0.6) : Qt.rgba(1, 1, 1, 0.5)
                                        onEntered: parent.color = Qt.rgba(0.9, 0.9, 0.9, 0.6)
                                        onExited: parent.color = Qt.rgba(1, 1, 1, 0.5)
                                    }

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 600
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }

                                Rectangle {
                                    id: favoriteButton
                                    property bool isFavorite: currentgame ? currentgame.favorite : false

                                    anchors {
                                        left: playGameButton.right
                                        leftMargin: parent.width * 0.02
                                        verticalCenter: playGameButton.verticalCenter
                                    }

                                    width: parent.width * 0.15
                                    height: parent.height * 0.2
                                    color: Qt.rgba(1, 1, 1, 0.5)
                                    radius: 20
                                    opacity: delegateRoot.selected ? 1 : 0
                                    z: 1000

                                    Image {
                                        anchors.centerIn: parent
                                        source: favoriteButton.isFavorite ? "assets/icons/favorite-on.png" : "assets/icons/favorite-off.png"
                                        width: parent.width * 0.7
                                        height: width
                                        mipmap: true
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            soundEffects.playChange();
                                            if (currentgame) {
                                                var collection = api.collections.get(collectionsListView.currentIndex);
                                                for (var i = 0; i < collection.games.count; i++) {
                                                    var originalGame = collection.games.get(i);
                                                    if (originalGame.title === currentgame.title) {
                                                        originalGame.favorite = !originalGame.favorite;
                                                        //console.log("Favorito actualizado (botón):", originalGame.title, originalGame.favorite);

                                                        currentgame.favorite = originalGame.favorite;
                                                        favoriteButton.isFavorite = originalGame.favorite;
                                                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);
                                                        if (gameActionBar.favoriteButton) {
                                                            gameActionBar.favoriteButton.buttonText = currentgame.favorite ? "Favorite -" : "Favorite +";
                                                        }

                                                        proxyModel.invalidate();

                                                        if (gameActionBar.currentFilter === "Favorites" && proxyModel.count === 0) {
                                                            gameActionBar.currentFilter = "All Games";
                                                        }

                                                        break;
                                                    }
                                                }
                                            }
                                        }

                                        onPressed: parent.color = Qt.rgba(0.7, 0.7, 0.7, 0.7)
                                        onReleased: parent.color = containsMouse ? Qt.rgba(0.9, 0.9, 0.9, 0.6) : Qt.rgba(1, 1, 1, 0.5)
                                        onEntered: parent.color = Qt.rgba(0.9, 0.9, 0.9, 0.6)
                                        onExited: parent.color = Qt.rgba(1, 1, 1, 0.5)
                                    }

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 600
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: selectionBorder
                        anchors.fill: parent
                        color: "transparent"
                        border.width: selected ? 6 : 0
                        border.color: myColorMapping.getColor(root.currentShortName)
                        radius: 9
                        z: 1001
                        visible: selected

                        SequentialAnimation {
                            running: selected
                            loops: Animation.Infinite

                            PropertyAnimation {
                                target: selectionBorder
                                property: "border.color"
                                from: myColorMapping.getColor(root.currentShortName)
                                to: "#cecece"
                                duration: 600
                                easing.type: Easing.InOutQuad
                            }

                            PropertyAnimation {
                                target: selectionBorder
                                property: "border.color"
                                from: "#cecece"
                                to: myColorMapping.getColor(root.currentShortName)
                                duration: 600
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

                onCurrentIndexChanged: {
                    soundEffects.playChange();
                    var selectedGame = gameGrid.model.get(gameGrid.currentIndex);

                    if (selectedGame) {
                        var imageSource = selectedGame.assets.background || selectedGame.assets.screenshot || "";
                        screenshotsContainer.setScreenshot(imageSource);

                        var collection = api.collections.get(collectionsListView.currentIndex);
                        for (var i = 0; i < collection.games.count; i++) {
                            var originalGame = collection.games.get(i);
                            if (originalGame.title === selectedGame.title) {
                                selectedGame.favorite = originalGame.favorite;
                                break;
                            }
                        }

                        currentgame = selectedGame;

                        if (gameActionBar.favoriteButton) {
                            gameActionBar.favoriteButton.buttonText = currentgame.favorite ? "Favorite -" : "Favorite +";
                        }

                        /*console.log("Juego cambiado a:", selectedGame.title,
                                    "Favorite:", selectedGame.favorite,
                                    "Filtro actual:", gameActionBar.currentFilter);*/
                    } else {
                        currentgame = null;
                    }

                    if (gameActionBar.currentFilter === "Favorites") {
                        var currentCollection = api.collections.get(collectionsListView.currentIndex);
                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);
                    }
                }

                focus: gamesGridFocused

                Keys.onLeftPressed: {
                    if (currentIndex > 0) {
                        currentIndex--;
                        soundEffects.playChange()
                    }

                    if (screensaver.screensaverActive) {
                        screensaver.stopScreensaver();
                    }
                    screensaver.resetInactivityTimer();
                }

                Keys.onRightPressed: {
                    if (currentIndex < count - 1) {
                        currentIndex++;
                        soundEffects.playChange()
                    }

                    if (screensaver.screensaverActive) {
                        screensaver.stopScreensaver();
                    }
                    screensaver.resetInactivityTimer();
                }

                Keys.onPressed: {
                    if (!event.isAutoRepeat) {
                        if (api.keys.isCancel(event)) {
                            event.accepted = true;
                            mainMenuVisible = true;
                            mainMenuFocused = true;
                            gamesGridVisible = false;
                            gamesGridFocused = false;
                            soundEffects.playBack();

                            if (screensaver.screensaverActive) {
                                screensaver.stopScreensaver();
                            }
                        }
                        else if (api.keys.isAccept(event)) {
                            event.accepted = true;
                            var sourceIndex = proxyModel.mapToSource(gameGrid.currentIndex);
                            var sourceModel = api.collections.get(collectionsListView.currentIndex).games;
                            if (sourceModel && sourceIndex >= 0 && sourceIndex < sourceModel.count) {
                                var gameToLaunch = sourceModel.get(sourceIndex);
                                if (gameToLaunch) {
                                    api.memory.set('lastPlayedGame', gameToLaunch);
                                    gameToLaunch.launch();
                                }
                            }
                        }
                        else if (api.keys.isFilters(event)) {
                            event.accepted = true;
                            gameActionBar.currentFilter = GameFilters.getNextFilter(
                                gameActionBar.currentFilter,
                                gameActionBar.availableFilters
                            );
                            soundEffects.playChange();
                            proxyModel.invalidate();

                            if (gameGrid.count > 0) {
                                currentgame = gameGrid.model.get(gameGrid.currentIndex);
                            } else {
                                currentgame = null;
                            }

                            gameActionBar.filterButton.buttonText = gameActionBar.currentFilter;
                        }
                        else if (api.keys.isDetails(event)) {
                            event.accepted = true;
                            soundEffects.playChange();

                            if (currentgame) {
                                var collection = api.collections.get(collectionsListView.currentIndex);
                                for (var i = 0; i < collection.games.count; i++) {
                                    var originalGame = collection.games.get(i);
                                    if (originalGame.title === currentgame.title) {
                                        originalGame.favorite = !originalGame.favorite;
                                        console.log("Favorito actualizado (tecla Details):",
                                                    originalGame.title, originalGame.favorite);
                                        currentgame.favorite = originalGame.favorite;
                                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);

                                        if (gameActionBar.favoriteButton) {
                                            gameActionBar.favoriteButton.buttonText = currentgame.favorite ? "Favorite -" : "Favorite +";
                                        }
                                        proxyModel.invalidate();
                                        if (gameActionBar.currentFilter === "Favorites" && proxyModel.count === 0) {
                                            gameActionBar.currentFilter = "All Games";
                                        }

                                        break;
                                    }
                                }
                            }
                        }
                    }
                    screensaver.resetInactivityTimer();
                }
            }
        }

        CollectionInfo {
            id: collectionInfo
            anchors.top: collectionsListView.bottom
            anchors.topMargin: parent.height * 0.05
            visible: mainMenuVisible
            currentShortName: root.currentShortName
            collectionSystemInfo: root.collectionSystemInfo
            collectionDescription: root.collectionDescription
        }

        ActionBar {
            id: gameActionBar

            anchors {
                top: parent.top
                topMargin: parent.height * 0.43
                right: parent.right
                rightMargin: parent.width * 0.03
            }
            width: parent.width * 0.45
            height: parent.height * 0.07
            visible: gamesGridVisible
            opacity: themeContainerOpacity
            rootReference: root

            onFavoriteClicked: {
                if (currentgame) {
                    var collection = api.collections.get(collectionsListView.currentIndex);
                    for (var i = 0; i < collection.games.count; i++) {
                        var originalGame = collection.games.get(i);
                        if (originalGame.title === currentgame.title) {
                            originalGame.favorite = !originalGame.favorite;
                            //console.log("Favorito actualizado:", originalGame.title, originalGame.favorite);
                            gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);
                            //console.log("Filtros disponibles actualizados:", gameActionBar.availableFilters);
                            break;
                        }
                    }

                    currentgame.favorite = !currentgame.favorite;

                    if (currentFilter === "Favorites") {
                        var hasFavorites = false;
                        for (var j = 0; j < collection.games.count; j++) {
                            if (collection.games.get(j).favorite) {
                                hasFavorites = true;
                                break;
                            }
                        }

                        if (!hasFavorites) {
                            //console.log("No hay más favoritos, cambiando a All Games");
                            currentFilter = "All Games";
                            Qt.callLater(function() {
                                proxyModel.invalidate();
                                if (gameGrid.count > 0) {
                                    gameGrid.currentIndex = 0;
                                    currentgame = gameGrid.model.get(0);
                                }
                            });
                            return;
                        }
                    }

                    proxyModel.invalidate();

                    if (gameGrid.count > 0 && gameGrid.currentIndex >= 0) {
                        currentgame = gameGrid.model.get(gameGrid.currentIndex);
                    } else {
                        currentgame = null;
                    }
                }
            }

            onFilterClicked: {
                var currentCollection = api.collections.get(collectionsListView.currentIndex);
                gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);

                if (gameActionBar.availableFilters.includes(gameActionBar.currentFilter)) {
                    proxyModel.invalidate();
                } else {
                    gameActionBar.currentFilter = "All Games";
                }

                if (gameGrid.count > 0) {
                    currentgame = gameGrid.model.get(gameGrid.currentIndex);
                } else {
                    currentgame = null;
                }
            }

            onLaunchClicked: {
                if (currentgame) {
                    var sourceModel = api.collections.get(collectionsListView.currentIndex).games;
                    for (var i = 0; i < sourceModel.count; i++) {
                        var sourceGame = sourceModel.get(i);
                        if (sourceGame && sourceGame.title === currentgame.title) {
                            api.memory.set('lastPlayedGame', sourceGame);
                            sourceGame.launch();
                            break;
                        }
                    }
                }
            }

            onBackClicked: {
                mainMenuVisible = true
                mainMenuFocused = true
                gamesGridVisible = false
                gamesGridFocused = false
                soundEffects.playBack()
            }

            Behavior on opacity {
                NumberAnimation { duration: 500 }
            }
        }
    }

    TopBar {
        id: topBar
        themeContainerOpacity: root.themeContainerOpacity
        gamesGridVisible: root.gamesGridVisible
        currentShortName: root.currentShortName

        anchors {
            top: parent.top
            topMargin: 20
        }
    }

    GameInfoView {
        id: ganeinfoview
        currentgame: root.currentgame
        visible: gamesGridVisible
        opacity: themeContainerOpacity

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: parent ? parent.width * 0.03 : 0
            topMargin: parent ? parent.height * 0.03 : 0
        }

        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
    }

    LogoContainer {
        id: logoContainer
        themeContainerOpacity: root.themeContainerOpacity
        currentShortName: root.currentShortName
        visibleState: gamesGridVisible && gamesGridFocused

        anchors {
            top: topBar.bottom
            right: parent.right
            topMargin: 10
            rightMargin: parent.width * 0.03
        }
    }

    function loadCollectionMetadata() {
        var systemData = myGameSystems.getSystemMetadata(currentShortName) || {};
        var currentCollection = api.collections.get(collectionsListView.currentIndex);
        var gameCount = currentCollection.games.count || 0;
        gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);
        collectionSystemInfo = "┌CONSOLE: " + (systemData.systemName || "None") + "┐┌" +
        "YEAR: " + (systemData.releaseYear || "None") + "┐┌" +
        "GAMES: " + gameCount + "┐";
        collectionDescription = systemData.description || "No description available";
    }
}
