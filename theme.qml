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
    property int inactivityTimeout: 60000
    property bool gamesGridVisible: false
    property bool gamesGridFocused: false
    property bool debugOverlayEnabled: false
    property bool debugLogsEnabled: false
    property bool debugUpdateNotificationEnabled: false
    property alias proxyModel: proxyModel
    property string currentScreenshot: ""
    property string currentShortName: ""
    property bool mainMenuVisible: true
    property bool mainMenuFocused: true
    property bool useFirstImage: true
    property string pendingSource: ""
    property var currentgame: null
    property var colorMap: ({})

    readonly property string currentVersion: "1.0.1"
    property string _pendingVersion: ""
    property string _pendingUrl: ""
    property string _pendingNotes: ""

    SoundEffects {
        id: soundEffects
    }

    function isNewerVersion(latest, current) {
        var a = latest.split('.').map(Number);
        var b = current.split('.').map(Number);
        for (var i = 0; i < 3; i++) {
            if ((a[i] || 0) > (b[i] || 0)) return true;
            if ((a[i] || 0) < (b[i] || 0)) return false;
        }
        return false;
    }

    function showTestUpdateNotification() {
        console.log("[THEME][checkForUpdates] debugUpdateNotificationEnabled=true -> mostrando notificación de prueba");
        root._pendingVersion = "9.9.9";
        root._pendingUrl = "https://github.com/ZagonAb/ColorShader/releases";
        root._pendingNotes =
            "Notas de prueba para ajustar LayoutMetrics según el aspect ratio.\n\n" +
            "- Punto de ejemplo uno\n" +
            "- Punto de ejemplo dos\n" +
            "- Texto más largo para comprobar el wrap y el scroll de las notas " +
            "cuando el contenido no entra en la altura máxima de la tarjeta.";
        updateNotifyTimer.restart();
    }

    function checkForUpdates() {
        if (root.debugUpdateNotificationEnabled) {
            root.showTestUpdateNotification();
            return;
        }

        var xhr = new XMLHttpRequest();
        var url = "https://api.github.com/repos/ZagonAb/ColorShader/releases/latest";
        xhr.open("GET", url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        var latestTag = data.tag_name || "";
                        var latestVersion = latestTag.replace(/^v/, "");
                        var releaseUrl = data.html_url || "";
                        var releaseNotes = data.body || "";

                        if (latestVersion && root.isNewerVersion(latestVersion, root.currentVersion)) {
                            var lastNotified = api.memory.has('lastUpdateNotified')
                                ? api.memory.get('lastUpdateNotified')
                                : "";
                            if (latestVersion !== lastNotified) {
                                root._pendingVersion = latestVersion;
                                root._pendingUrl = releaseUrl;
                                root._pendingNotes = releaseNotes;
                                api.memory.set('lastUpdateNotified', latestVersion);
                                updateNotifyTimer.restart();
                            }
                        }
                    } catch (e) {
                        console.warn("[THEME][checkForUpdates] Error parseando JSON:", e);
                    }
                } else {
                    console.log("[THEME][checkForUpdates] Error HTTP:", xhr.status, xhr.statusText);
                }
            }
        };
        xhr.onerror = function(e) {
            console.error("[THEME][checkForUpdates] Error de red:", e);
        };
        xhr.send();
    }

    Timer {
        id: updateNotifyTimer
        interval: 900
        repeat: false
        onTriggered: {
            if (root._pendingVersion !== "") {
                updateNotification.show(root._pendingVersion, root._pendingUrl, root._pendingNotes);
                root._pendingVersion = "";
                root._pendingUrl = "";
                root._pendingNotes = "";
            }
        }
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

    /*function saveThemeState(game) {
        console.log("[THEME][SAVE] Guardando estado -> collectionIndex:", collectionsListView.currentIndex,
                     "| filter:", gameActionBar.currentFilter,
                     "| gameTitle:", (game ? game.title : "(null)"),
                     "| screen:", (gamesGridVisible ? "games" : "collections"));
        api.memory.set('lastCollectionIndex', collectionsListView.currentIndex);
        api.memory.set('lastFilter', gameActionBar.currentFilter);
        api.memory.set('lastGameTitle', game ? game.title : "");
        api.memory.set('lastScreen', gamesGridVisible ? "games" : "collections");
        console.log("[THEME][SAVE] Memoria tras guardar -> lastCollectionIndex:", api.memory.get('lastCollectionIndex'),
                     "| lastFilter:", api.memory.get('lastFilter'),
                     "| lastGameTitle:", api.memory.get('lastGameTitle'),
                     "| lastScreen:", api.memory.get('lastScreen'));
    }*/

    function saveThemeState(game) {
        console.log("[THEME][SAVE] Guardando estado -> collectionIndex:", collectionsListView.currentIndex,
                    "| filter:", gameActionBar.currentFilter,
                    "| gameTitle:", (game ? game.title : "(null)"),
                    "| screen:", (gamesGridVisible ? "games" : "collections"));
        api.memory.set('lastCollectionIndex', collectionsListView.currentIndex);
        api.memory.set('lastFilter', gameActionBar.currentFilter);
        api.memory.set('lastGameTitle', game ? game.title : "");
        api.memory.set('lastScreen', gamesGridVisible ? "games" : "collections");
        console.log("[THEME][SAVE] Memoria tras guardar -> lastCollectionIndex:", api.memory.get('lastCollectionIndex'),
                    "| lastFilter:", api.memory.get('lastFilter'),
                    "| lastGameTitle:", api.memory.get('lastGameTitle'),
                    "| lastScreen:", api.memory.get('lastScreen'));
    }

    function clearThemeState() {
        api.memory.set('lastCollectionIndex', 0);
        api.memory.set('lastFilter', "All Games");
        api.memory.set('lastGameTitle', "");
        api.memory.set('lastScreen', "collections");
        console.log("[THEME][CLEAR] Memoria de restauración limpiada -> vuelve a valores por defecto");
    }

    function logFinalRestoredState(tag) {
        console.log("[THEME][RESTORE-CHECK][" + tag + "] collectionsListView.currentIndex:", collectionsListView.currentIndex,
                     "| currentShortName:", currentShortName,
                     "| gameActionBar.currentFilter:", gameActionBar.currentFilter,
                     "| gameGrid.currentIndex:", gameGrid.currentIndex,
                     "| gameGrid.count:", gameGrid.count,
                     "| currentgame:", (currentgame ? currentgame.title : "(null)"),
                     "| mainMenuVisible:", mainMenuVisible,
                     "| gamesGridVisible:", gamesGridVisible);
    }

    onMainMenuVisibleChanged: {
        if (mainMenuVisible) {
            Qt.callLater(function() {
                collectionsListView.positionViewAtIndex(collectionsListView.currentIndex, ListView.Center);
                console.log("[THEME][ROOT] mainMenuVisible -> true. Reposicionando collectionsListView a index:",
                             collectionsListView.currentIndex, "| contentX:", collectionsListView.contentX);
            });
        }
    }

    onGamesGridVisibleChanged: {
        if (gamesGridVisible) {
            Qt.callLater(function() {
                gameGrid.positionViewAtIndex(gameGrid.currentIndex, GridView.Contain);
                console.log("[THEME][ROOT] gamesGridVisible -> true. Reposicionando gameGrid a index:",
                             gameGrid.currentIndex, "| contentY:", gameGrid.contentY);
            });
        }
    }

    Timer {

        id: safetyTimer
        interval: 500
        onTriggered: {
            if (gameGrid.count === 0 && currentFilter === "Favorites") {
                currentFilter = "All Games";
                Qt.callLater(proxyModel.invalidate);
            }
        }
    }

    Component.onCompleted: {
        Qt.onUncaughtError = function(error) {
            console.error("Error no capturado:", error);
            if (currentFilter === "Favorites" && proxyModel.count === 0) {
                console.error("Recuperando de error - cambiando a All Games");
                currentFilter = "All Games";
                proxyModel.invalidate();
            }
        };

        updateCurrentColor();
        screensaver.randomGames = Utils.getRandomGames(api.collections);
        logMetricsSnapshot();

        console.log("[THEME][ROOT] Component.onCompleted del root ejecutado. api.collections.count:", api.collections.count,
                     "| memory.has(lastCollectionIndex):", api.memory.has('lastCollectionIndex'));

        Qt.callLater(function() {
            logFinalRestoredState("root.onCompleted +1 tick");
        });

        Qt.callLater(function() {
            root.checkForUpdates();
        });
    }

    Components.LayoutMetrics {
        id: metrics
        viewportWidth: root.width
        viewportHeight: root.height
    }

    Components.Screensaver {
        id: screensaver
        inactivityTimeout: root.inactivityTimeout
        visible: screensaverActive
        metrics: metrics

        onScreensaverStarted: themeContainerOpacity = 0.0
        onScreensaverStopped: themeContainerOpacity = 1.0

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

    Timer {
        id: metricsLogDebounce
        interval: 250
        repeat: false
        onTriggered: logMetricsSnapshot()
    }

    function logMetricsSnapshot() {
        if (!metrics || !root.debugLogsEnabled) return;
        console.log("[LayoutMetrics] " +
        "viewport=" + Math.round(metrics.viewportWidth) + "x" + Math.round(metrics.viewportHeight) +
        " | aspect=" + metrics.aspectRatio.toFixed(4) +
        " | profile=" + metrics.profile +
        " | compact=" + metrics.compactness.toFixed(3) +
        " | uScale=" + metrics.uniformScale.toFixed(4) +
        " | slack=" + Math.round(metrics.horizontalSlack) + "/" + Math.round(metrics.verticalSlack) +
        " | gridCols=" + metrics.gameGridColumns +
        " | cell=" + Math.round(metrics.gameCellWidth) + "x" + Math.round(metrics.gameCellHeight));
    }

    Connections {
        target: metrics

        function onViewportWidthChanged()  { metricsLogDebounce.restart(); }
        function onViewportHeightChanged() { metricsLogDebounce.restart(); }

        function onProfileChanged() {
            if (root.debugLogsEnabled)
                console.log("[LayoutMetrics] *** PROFILE CHANGED → " + metrics.profile + " ***");
            metricsLogDebounce.restart();
        }

        function onGameGridColumnsChanged() {
            if (root.debugLogsEnabled)
                console.log("[Grid] *** COLUMNS CHANGED → " + metrics.gameGridColumns +
                " | cell=" + Math.round(metrics.gameCellWidth) + "x" + Math.round(metrics.gameCellHeight) +
                " | pageSize=" + metrics.gameGridPageSize + " ***");
        }

        function onCollectionItemScaleSelectedChanged() {
            if (root.debugLogsEnabled)
                console.log("[Collections] itemScaleSelected=" +
                metrics.collectionItemScaleSelected.toFixed(2) +
                " | itemWidth=" + Math.round(metrics.collectionItemWidth) +
                " | itemHeight=" + Math.round(metrics.collectionItemHeight) +
                " | isCompact=" + metrics.isCompact);
        }
    }

    Components.LayoutDebugPanel {
        id: layoutDebug
        visible: root.debugOverlayEnabled
        metrics: metrics
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        z: 5000
    }

    Keys.onPressed: {
        if (screensaver.screensaverActive)
            screensaver.stopScreensaver();
        screensaver.resetInactivityTimer();
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            if (!screensaver.screensaverActive)
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
                var gradCenterX = metrics.gradientCenterX;
                var gradCenterY = metrics.gradientCenterY;
                var gradRadius = Math.max(width, height);

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
        enabled: !updateNotification.active

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
                    NumberAnimation { duration: 800; easing.type: Easing.InOutQuad }
                }

                Image {
                    id: screenshotImage1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    visible: false
                }

                FastBlur {
                    anchors.fill: parent
                    source: screenshotImage1
                    radius: metrics.backgroundBlurRadius
                    visible: true
                    cached: true
                }
            }

            Item {
                id: container2
                anchors.fill: parent
                opacity: !useFirstImage ? 1 : 0.5

                Behavior on opacity {
                    NumberAnimation { duration: 800; easing.type: Easing.InOutQuad }
                }

                Image {
                    id: screenshotImage2
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    visible: false
                }

                FastBlur {
                    anchors.fill: parent
                    source: screenshotImage2
                    radius: metrics.backgroundBlurRadius
                    visible: true
                    cached: true
                }
            }

            LinearGradient {
                id: gradientLinear
                visible: true
                width: parent.width
                height: metrics.backgroundGradientHeight
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

            NoiseEffect {
                id: noiSe
                anchors.fill: parent
                noiseIntensity: 0.05
                noiseOpacity: 0.5
                visible: true
            }
        }

        SystemLogo {
            id: systemLogo
            currentShortName: root.currentShortName
            themeContainerOpacity: root.themeContainerOpacity
            visible: mainMenuVisible
            metrics: metrics
        }

        ListView {
            id: collectionsListView
            width: metrics.collectionListWidth
            height: metrics.collectionListHeight
            anchors.centerIn: parent
            model: api.collections
            orientation: Qt.Horizontal
            spacing: metrics.collectionListSpacing
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
                width: metrics.collectionItemWidth
                height: metrics.collectionItemHeight
                scale: (selected && collectionsListView.focus)
                ? metrics.collectionItemScaleSelected
                : metrics.collectionItemScaleNormal
                clip: false
                z: selected ? 1 : 0

                Behavior on scale {
                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
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
                        if (status === Image.Error)
                            source = "assets/systems/default.png";
                    }

                    Text {
                        anchors.centerIn: parent
                        text: model.shortName
                        color: "white"
                        visible: shortNameImage.status !== Image.Ready
                        font.pixelSize: metrics.collectionFallbackFontSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Behavior on scale {
                        NumberAnimation { duration: 1000; easing.type: Easing.InOutQuad }
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
                console.log("[THEME][COLLECTIONS] onCurrentIndexChanged -> nuevo currentIndex:", currentIndex);
                indexToPosition = currentIndex;
                currentShortName = model.get(currentIndex).shortName;
                updateCurrentColor();
                loadCollectionMetadata();

                var currentCollection = api.collections.get(currentIndex);
                gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);
                gameActionBar.currentFilter = "All Games";

                if (collectionInfo.autoscroll)
                    collectionInfo.autoscroll.restart();
            }

            Component.onCompleted: {
                console.log("[THEME][COLLECTIONS] Component.onCompleted disparado. model.count:", model.count,
                             "| memory.has(lastCollectionIndex):", api.memory.has('lastCollectionIndex'));

                var restoredIndex = 0;
                if (api.memory.has('lastCollectionIndex')) {
                    var saved = api.memory.get('lastCollectionIndex');
                    console.log("[THEME][COLLECTIONS] Valor guardado en memoria -> lastCollectionIndex:", saved,
                                 "(tipo:", typeof saved, ")");
                    if (typeof saved === "number" && saved >= 0 && saved < model.count) {
                        restoredIndex = saved;
                    } else {
                        console.log("[THEME][COLLECTIONS] Valor guardado inválido o fuera de rango (model.count=" + model.count + "), usando 0");
                    }
                } else {
                    console.log("[THEME][COLLECTIONS] No hay 'lastCollectionIndex' en memoria (primer arranque), usando 0 por defecto");
                }

                currentIndex = restoredIndex;
                currentShortName = model.get(currentIndex).shortName;
                updateCurrentColor();

                console.log("[THEME][COLLECTIONS] currentIndex final tras onCompleted:", currentIndex,
                             "| currentShortName:", currentShortName);

                var currentCollectionForFilter = api.collections.get(currentIndex);
                gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollectionForFilter);

                if (api.memory.has('lastFilter')) {
                    var savedFilter = api.memory.get('lastFilter');
                    console.log("[THEME][COLLECTIONS] Valor guardado en memoria -> lastFilter:", savedFilter,
                                 "| availableFilters:", JSON.stringify(gameActionBar.availableFilters));
                    if (gameActionBar.availableFilters.indexOf(savedFilter) !== -1) {
                        gameActionBar.currentFilter = savedFilter;
                        console.log("[THEME][COLLECTIONS] Filtro restaurado:", savedFilter);
                    } else {
                        gameActionBar.currentFilter = "All Games";
                        console.log("[THEME][COLLECTIONS] Filtro guardado no disponible en esta colección, usando 'All Games'");
                    }
                } else {
                    gameActionBar.currentFilter = "All Games";
                }

                proxyModel.invalidate();

                console.log("[THEME][COLLECTIONS] Tras invalidate() -> gameGrid.model.count:", gameGrid.model.count);
                var savedGameTitle = api.memory.has('lastGameTitle') ? api.memory.get('lastGameTitle') : "";
                var savedScreen = api.memory.has('lastScreen') ? api.memory.get('lastScreen') : "collections";
                console.log("[THEME][COLLECTIONS] savedGameTitle:", savedGameTitle, "| savedScreen:", savedScreen);

                var gridCount = gameGrid.model.count;
                var restoredGameIndex = 0;

                if (gridCount > 0) {
                    if (savedGameTitle) {
                        var found = false;
                        for (var i = 0; i < gridCount; i++) {
                            var g = gameGrid.model.get(i);
                            if (g && g.title === savedGameTitle) {
                                restoredGameIndex = i;
                                found = true;
                                break;
                            }
                        }
                        console.log("[THEME][COLLECTIONS] Búsqueda de '" + savedGameTitle + "' -> encontrado:", found,
                                     "| índice:", restoredGameIndex);
                    }

                    gameGrid.currentIndex = restoredGameIndex;
                    currentgame = gameGrid.model.get(restoredGameIndex);
                    console.log("[THEME][COLLECTIONS] gameGrid.currentIndex final:", gameGrid.currentIndex,
                                 "| currentgame:", (currentgame ? currentgame.title : "(null)"));
                } else {
                    console.log("[THEME][COLLECTIONS] gridCount es 0, no hay juego para restaurar");
                }

                if (savedScreen === "games" && gridCount > 0) {
                    mainMenuVisible = false;
                    mainMenuFocused = false;
                    gamesGridVisible = true;
                    gamesGridFocused = true;
                    console.log("[THEME][COLLECTIONS] Pantalla restaurada a 'games'");
                } else {
                    console.log("[THEME][COLLECTIONS] Pantalla se mantiene en 'collections'");
                }

                var restoreCollectionIndex = collectionsListView.currentIndex;
                var restoreGameIndex = gameGrid.currentIndex;
                var restoreGridHadItems = gridCount > 0;

                /*Qt.callLater(function() {
                    Qt.callLater(function() {
                        console.log("[THEME][COLLECTIONS] Reposicionando vistas -> collection:", restoreCollectionIndex,
                                     "| game:", restoreGameIndex);

                        collectionsListView.positionViewAtIndex(restoreCollectionIndex, ListView.Center);

                        if (restoreGridHadItems) {
                            gameGrid.positionViewAtIndex(restoreGameIndex, GridView.Contain);
                            if (gameGrid.currentItem && gameGrid.currentItem.updateVideoState)
                                gameGrid.currentItem.updateVideoState();
                        }

                        console.log("[THEME][COLLECTIONS] Reposicionamiento visual completado -> " +
                                     "collectionsListView.contentX:", collectionsListView.contentX,
                                     "| gameGrid.contentY:", gameGrid.contentY);
                    });
                });*/

                Qt.callLater(function() {
                    Qt.callLater(function() {
                        console.log("[THEME][COLLECTIONS] Reposicionando vistas -> collection:", restoreCollectionIndex,
                                    "| game:", restoreGameIndex);

                        collectionsListView.positionViewAtIndex(restoreCollectionIndex, ListView.Center);

                        if (restoreGridHadItems) {
                            gameGrid.positionViewAtIndex(restoreGameIndex, GridView.Contain);
                            if (gameGrid.currentItem && gameGrid.currentItem.updateVideoState)
                                gameGrid.currentItem.updateVideoState();
                        }

                        console.log("[THEME][COLLECTIONS] Reposicionamiento visual completado -> " +
                        "collectionsListView.contentX:", collectionsListView.contentX,
                        "| gameGrid.contentY:", gameGrid.contentY);

                        clearThemeState();
                    });
                });
            }

            onIndexToPositionChanged: {
                if (indexToPosition >= 0)
                    positionViewAtIndex(indexToPosition, ListView.Center);
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
                        soundEffects.playOk();
                        currentgame = gameGrid.model.get(gameGrid.currentIndex);
                        if (gameGrid.currentItem && gameGrid.currentItem.updateVideoState)
                            gameGrid.currentItem.updateVideoState();
                    } else if (api.keys.isNextPage(event)) {
                        event.accepted = true;
                        if (currentIndex < count - 1) {
                            currentIndex++;
                            soundEffects.playRight();
                        } else {
                            soundEffects.playStop();
                        }
                    } else if (api.keys.isPrevPage(event)) {
                        event.accepted = true;
                        if (currentIndex > 0) {
                            currentIndex--;
                            soundEffects.playLeft();
                        } else {
                            soundEffects.playStop();
                        }
                    }

                    if (screensaver.screensaverActive)
                        screensaver.stopScreensaver();
                }
                screensaver.resetInactivityTimer();
            }

            Keys.onLeftPressed: {
                if (currentIndex > 0) {
                    currentIndex--;
                    soundEffects.playLeft();
                } else {
                    soundEffects.playStop();
                }
                if (screensaver.screensaverActive)
                    screensaver.stopScreensaver();
                screensaver.resetInactivityTimer();
            }

            Keys.onRightPressed: {
                if (currentIndex < count - 1) {
                    currentIndex++;
                    soundEffects.playRight();
                } else {
                    soundEffects.playStop();
                }
                if (screensaver.screensaverActive)
                    screensaver.stopScreensaver();
                screensaver.resetInactivityTimer();
            }
        }

        Rectangle {
            id: gameGridContainer

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }

            width: parent.width
            height: metrics.gameGridContainerHeight
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

                width: metrics.gameGridWidth
                height: metrics.gameGridHeight

                property int columns: metrics.gameGridColumns
                property int rows: metrics.gameGridRows

                cellWidth: metrics.gameCellWidth
                cellHeight: metrics.gameCellHeight

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
                        console.log("[THEME][PROXYMODEL] onCountChanged -> count:", count,
                                     "| collectionsListView.currentIndex:", collectionsListView.currentIndex,
                                     "| gameActionBar.currentFilter:", gameActionBar.currentFilter,
                                     "| gameGrid.currentIndex:", gameGrid.currentIndex);
                        if (count > 0) {
                            if (gameGrid.currentIndex >= count)
                                gameGrid.currentIndex = count - 1;
                            currentgame = gameGrid.model.get(gameGrid.currentIndex);
                        } else {
                            currentgame = null;

                            if (gameActionBar.currentFilter === "Favorites") {
                                if (root.debugLogsEnabled)
                                    console.log("Lista de favoritos vacía - cambiando a All Games");
                                gameActionBar.currentFilter = "All Games";
                                Qt.callLater(proxyModel.invalidate);
                            } else {
                                if (gameActionBar.currentFilter === "Favorites") {
                                    if (root.debugLogsEnabled)
                                        console.log("Lista vacía - Activando timer de seguridad");
                                    safetyTimer.restart();
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    console.log("[THEME][GAMEGRID] Component.onCompleted disparado (estado por defecto, provisional). count:", count,
                                 "| collectionsListView.currentIndex:", collectionsListView.currentIndex,
                                 "| Nota: la restauración real ocurre en collectionsListView.onCompleted, que puede disparar después.");

                    if (count > 0) {
                        currentIndex = 0;
                        currentgame = model.get(0);
                        Qt.callLater(function() {
                            if (currentItem && currentItem.updateVideoState)
                                currentItem.updateVideoState();
                        });
                    }
                }

                delegate: Item {
                    id: delegateRoot
                    width: metrics.gameCellContentWidth
                    height: metrics.gameCellContentHeight
                    scale: (selected && gameGrid.focus)
                    ? metrics.gameCardScaleSelected
                    : metrics.gameCardScaleNormal
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
                        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                    }

                    z: selected ? 1 : 0

                    Component.onCompleted: updateGame()

                    function updateGame() {
                        game = gameGrid.model.get(index);
                        var indicator = loader.item ? loader.item.playTimeIndicator : null;
                        if (indicator)
                            indicator.playTimeSeconds = game ? game.playTime : 0;
                    }

                    function updateVideoState() {
                        if (loader.item && loader.item.videoLoader.item) {
                            var player = loader.item.videoLoader.item.mediaPlayer;
                            var output = loader.item.videoLoader.item.videoOutput;

                            if (selected && gameGrid.activeFocus) {
                                if (!player.source)
                                    player.source = game.assets.video;
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
                        }
                        function onSelectionCommitted() {
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
                            radius: metrics.gameCardRadius
                            color: "black"

                            property alias videoLoader: videoLoader
                            property alias playTimeIndicator: playTimeIndicator

                            Item {
                                anchors.fill: parent
                                clip: true

                                Rectangle {
                                    id: mask
                                    anchors.fill: parent
                                    radius: metrics.gameCardRadius
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
                                            radius: metrics.gameCardRadius
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
                                    radius: selected
                                    ? metrics.gameCardBlurRadiusActive
                                    : metrics.gameCardBlurRadiusIdle
                                    opacity: selected ? 0 : 1
                                    visible: opacity > 0 && (!videoLoader.item || !videoLoader.item.videoOutput.visible)

                                    Behavior on radius {
                                        NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on opacity {
                                        NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
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
                                                radius: metrics.gameCardRadius
                                                visible: false
                                            }

                                            MediaPlayer {
                                                id: mediaPlayer
                                                source: game ? game.assets.video : ""
                                                videoOutput: videoOutput
                                                loops: 1
                                                autoPlay: true
                                                volume: 0.1
                                                muted: api.memory.get('videoMuted') || false

                                                onStatusChanged: {
                                                    if (status === MediaPlayer.Loaded) {
                                                        play();
                                                        muted = api.memory.get('videoMuted') || false;
                                                    }
                                                    if (status === MediaPlayer.EndOfMedia) {
                                                        videoOutput.visible = false;
                                                        fastBlur.radius = metrics.gameCardBlurRadiusFinished;
                                                        fastBlur.opacity = 1;
                                                        logoOverlay.opacity = 1;
                                                    }
                                                }
                                            }

                                            VideoOutput {
                                                id: videoOutput
                                                anchors.fill: parent
                                                anchors.margins: metrics.gameCardBorderWidth * 0.15
                                                fillMode: VideoOutput.PreserveAspectCrop
                                                visible: delegateRoot.selected && gameGrid.activeFocus
                                                layer.enabled: true
                                                layer.effect: OpacityMask {
                                                    maskSource: Rectangle {
                                                        width: backgroundRect.width
                                                        height: backgroundRect.height
                                                        radius: metrics.gameCardRadius
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Image {
                                    id: logoOverlay
                                    anchors.centerIn: parent
                                    source: (game && game.assets && game.assets.logo) ? game.assets.logo : ""
                                    width: parent.width * metrics.gameCardLogoOverlayFraction
                                    height: parent.height * metrics.gameCardLogoOverlayFraction
                                    opacity: selected ? 0 : 1
                                    fillMode: Image.PreserveAspectFit
                                    asynchronous: true
                                    mipmap: true

                                    visible: source !== "" && status !== Image.Error

                                    Behavior on opacity {
                                        NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
                                    }
                                }

                                Rectangle {
                                    anchors.fill: parent
                                    color: "transparent"
                                    visible: boxfront.status !== Image.Ready ||
                                    (videoLoader.item &&
                                    videoLoader.item.mediaPlayer.status !== MediaPlayer.Loaded)

                                    Image {
                                        id: loadingSpinner
                                        anchors.centerIn: parent
                                        width: metrics.gameCardLoadingSpinnerSize
                                        height: metrics.gameCardLoadingSpinnerSize
                                        source: "assets/icons/loading-spinner.svg"
                                        mipmap: true
                                        visible: boxfront.status === Image.Loading ||
                                        (videoLoader.item &&
                                        videoLoader.item.mediaPlayer.status === MediaPlayer.Loading)

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
                                    width: parent.width * 0.85
                                    height: parent.height * 0.75
                                    text: game ? game.title : ""
                                    color: "white"
                                    font.pixelSize: parent.width * metrics.gameCardFallbackFontFraction
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    maximumLineCount: 4
                                    elide: Text.ElideRight
                                    fontSizeMode: Text.Fit
                                    minimumPixelSize: Math.max(10, parent.width * 0.035)

                                    visible: !logoOverlay.visible
                                }

                                Rectangle {
                                    id: playGameButton
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: parent.height * metrics.gameCardPlayButtonBottomMarginFraction
                                    width: parent.width * metrics.gameCardPlayButtonWidthFraction
                                    height: parent.height * metrics.gameCardButtonHeightFraction
                                    radius: metrics.gameCardButtonRadius
                                    color: Qt.rgba(0, 0, 0, 0.6)
                                    opacity: delegateRoot.selected ? 1 : 0
                                    z: 1000
                                    visible: true
                                    scale: playGameMouseArea.pressed ? 0.95 : 1.0

                                    Behavior on scale { NumberAnimation { duration: 100 } }
                                    Behavior on color { ColorAnimation { duration: 100 } }

                                    Text {
                                        anchors.centerIn: parent
                                        text: "Play"
                                        color: "white"
                                        font.pixelSize: parent.height * metrics.gameCardPlayButtonTextFraction
                                        font.bold: true
                                    }

                                    MouseArea {
                                        id: playGameMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            parent.color = Qt.rgba(0, 0, 0, 0.7);
                                            soundEffects.playOk();
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
                                        onPressed: parent.color = Qt.rgba(0, 0, 0, 0.7)
                                        onReleased: {
                                            if (!containsMouse)
                                                parent.color = Qt.rgba(0, 0, 0, 0.5);
                                        }
                                        onEntered: parent.color = Qt.rgba(0, 0, 0, 0.6)
                                        onExited: parent.color = Qt.rgba(0, 0, 0, 0.5)
                                    }

                                    Timer {
                                        id: timer
                                        interval: 150
                                        property var gameToLaunch: null
                                        onTriggered: {
                                            if (gameToLaunch) {
                                                api.memory.set('lastPlayedGame', gameToLaunch);
                                                saveThemeState(gameToLaunch);
                                                gameToLaunch.launch();
                                                gameToLaunch = null;
                                            }
                                            playGameButton.color = Qt.rgba(0, 0, 0, 0.5);
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
                                    }
                                }

                                Rectangle {
                                    id: muteButton
                                    property bool isMuted: api.memory.get('videoMuted') || false

                                    anchors {
                                        right: playGameButton.left
                                        rightMargin: parent.width * metrics.gameCardSideButtonMarginFraction
                                        verticalCenter: playGameButton.verticalCenter
                                    }
                                    width: parent.width * metrics.gameCardSideButtonWidthFraction
                                    height: parent.height * metrics.gameCardButtonHeightFraction
                                    radius: metrics.gameCardButtonRadius
                                    color: Qt.rgba(0, 0, 0, 0.6)
                                    z: 1000

                                    opacity: {
                                        if (!delegateRoot.selected) return 0;
                                        if (!videoLoader.item) return 0;
                                        return videoLoader.item.videoOutput.visible ? 1 : 0;
                                    }

                                    Image {
                                        anchors.centerIn: parent
                                        source: muteButton.isMuted
                                        ? "assets/icons/mute.png"
                                        : "assets/icons/volume.png"
                                        width: parent.width * 0.7
                                        height: width
                                        mipmap: true
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            soundEffects.playOk();
                                            muteButton.isMuted = !muteButton.isMuted;
                                            api.memory.set('videoMuted', muteButton.isMuted);
                                            if (videoLoader.item)
                                                videoLoader.item.mediaPlayer.muted = muteButton.isMuted;
                                        }
                                        onPressed: parent.color = Qt.rgba(0, 0, 0, 0.7)
                                        onReleased: parent.color = containsMouse
                                        ? Qt.rgba(0, 0, 0, 0.6)
                                        : Qt.rgba(0, 0, 0, 0.5)
                                        onEntered: parent.color = Qt.rgba(0, 0, 0, 0.6)
                                        onExited: parent.color = Qt.rgba(0, 0, 0, 0.5)
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
                                    }
                                }

                                Rectangle {
                                    id: favoriteButton
                                    property bool isFavorite: currentgame ? currentgame.favorite : false

                                    anchors {
                                        left: playGameButton.right
                                        leftMargin: parent.width * metrics.gameCardSideButtonMarginFraction
                                        verticalCenter: playGameButton.verticalCenter
                                    }
                                    width: parent.width * metrics.gameCardSideButtonWidthFraction
                                    height: parent.height * metrics.gameCardButtonHeightFraction
                                    radius: metrics.gameCardButtonRadius
                                    color: Qt.rgba(0, 0, 0, 0.6)
                                    opacity: delegateRoot.selected ? 1 : 0
                                    z: 1000

                                    Image {
                                        anchors.centerIn: parent
                                        source: favoriteButton.isFavorite
                                        ? "assets/icons/favorite-on.svg"
                                        : "assets/icons/favorite-off.svg"
                                        width: parent.width * 0.7
                                        height: width
                                        mipmap: true
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            soundEffects.playFav();
                                            if (currentgame) {
                                                var collection = api.collections.get(collectionsListView.currentIndex);
                                                for (var i = 0; i < collection.games.count; i++) {
                                                    var originalGame = collection.games.get(i);
                                                    if (originalGame.title === currentgame.title) {
                                                        originalGame.favorite = !originalGame.favorite;
                                                        currentgame.favorite = originalGame.favorite;
                                                        favoriteButton.isFavorite = originalGame.favorite;
                                                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);

                                                        if (gameActionBar.favoriteButton) {
                                                            gameActionBar.favoriteButton.buttonText =
                                                            currentgame.favorite ? "Favorite -" : "Favorite +";
                                                        }

                                                        proxyModel.invalidate();

                                                        if (gameActionBar.currentFilter === "Favorites" &&
                                                            proxyModel.count === 0) {
                                                            gameActionBar.currentFilter = "All Games";
                                                            }
                                                            break;
                                                    }
                                                }
                                            }
                                        }
                                        onPressed: parent.color = Qt.rgba(0, 0, 0, 0.7)
                                        onReleased: parent.color = containsMouse
                                        ? Qt.rgba(0, 0, 0, 0.6)
                                        : Qt.rgba(0, 0, 0, 0.5)
                                        onEntered: parent.color = Qt.rgba(0, 0, 0, 0.6)
                                        onExited: parent.color = Qt.rgba(0, 0, 0, 0.5)
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
                                    }
                                }

                                Rectangle {
                                    id: playTimeIndicator
                                    property int playTimeSeconds: game ? game.playTime : 0
                                    property string formattedTime: Utils.formatPlayTime(playTimeSeconds)
                                    property bool shouldShow: Utils.shouldShowPlayTime(playTimeSeconds) &&
                                    delegateRoot.selected

                                    anchors {
                                        top: parent.top
                                        right: parent.right
                                        topMargin: parent.height * metrics.gameCardPlayTimeTopMarginFraction
                                        rightMargin: parent.width * metrics.gameCardPlayTimeRightMarginFraction
                                    }
                                    width: parent.width * metrics.gameCardPlayTimeWidthFraction
                                    height: parent.height * metrics.gameCardPlayTimeHeightFraction
                                    radius: height * metrics.gameCardPlayTimeRadiusFactor
                                    color: Qt.rgba(0, 0, 0, 0.6)
                                    opacity: shouldShow ? 1 : 0
                                    visible: shouldShow
                                    z: 1000

                                    Behavior on opacity {
                                        NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
                                    }

                                    Row {
                                        anchors.centerIn: parent
                                        spacing: parent.width * metrics.gameCardPlayTimeRowSpacingFraction

                                        Image {
                                            id: playTimeIcon
                                            source: "assets/icons/playtime.svg"
                                            width: parent.parent.height * metrics.gameCardPlayTimeIconSizeFactor
                                            height: width
                                            sourceSize { width: 64; height: 64 }
                                            fillMode: Image.PreserveAspectFit
                                            mipmap: true
                                            asynchronous: true
                                        }

                                        Text {
                                            id: playTimeText
                                            text: playTimeIndicator.formattedTime
                                            color: "white"
                                            font.pixelSize: parent.parent.height * metrics.gameCardPlayTimeFontSizeFactor
                                            font.bold: true
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }

                                    Rectangle {
                                        anchors.fill: parent
                                        color: "transparent"
                                        border.width: 1
                                        border.color: Qt.rgba(1, 1, 1, 0.3)
                                        radius: parent.radius
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: selectionBorder
                        anchors.fill: parent
                        color: "transparent"
                        border.width: selected ? metrics.gameCardBorderWidth : 0
                        border.color: myColorMapping.getColor(root.currentShortName)
                        radius: metrics.gameCardRadius - 1
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

                signal selectionCommitted()
                property bool navFastScrolling: false

                Timer {
                    id: gridSettleTimer
                    interval: 120
                    repeat: false
                    onTriggered: gameGrid.commitSelection()
                }

                function commitSelection() {
                    gridSettleTimer.stop();
                    navFastScrolling = false;

                    var selectedGame = gameGrid.model.get(gameGrid.currentIndex);

                    if (selectedGame) {
                        var imageSource = selectedGame.assets.background ||
                        selectedGame.assets.screenshot || "";
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
                            gameActionBar.favoriteButton.buttonText =
                            currentgame.favorite ? "Favorite -" : "Favorite +";
                        }
                    } else {
                        currentgame = null;
                    }

                    if (gameActionBar.currentFilter === "Favorites") {
                        var currentCollection = api.collections.get(collectionsListView.currentIndex);
                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(currentCollection);
                    }

                    selectionCommitted();
                }

                onCurrentIndexChanged: {
                    if (navFastScrolling) {
                        gridSettleTimer.restart();
                    } else {
                        commitSelection();
                    }
                }

                focus: gamesGridFocused

                Keys.onLeftPressed: {
                    navFastScrolling = event.isAutoRepeat;
                    if (currentIndex > 0) {
                        currentIndex--;
                        soundEffects.playLeft();
                    }
                    if (screensaver.screensaverActive)
                        screensaver.stopScreensaver();
                    screensaver.resetInactivityTimer();
                }

                Keys.onRightPressed: {
                    navFastScrolling = event.isAutoRepeat;
                    if (currentIndex < count - 1) {
                        currentIndex++;
                        soundEffects.playRight();
                    }
                    if (screensaver.screensaverActive)
                        screensaver.stopScreensaver();
                    screensaver.resetInactivityTimer();
                }

                Keys.onUpPressed: {
                    navFastScrolling = event.isAutoRepeat;
                    var newIndex = currentIndex - gameGrid.columns;
                    if (newIndex >= 0) {
                        currentIndex = newIndex;
                        soundEffects.playUp();
                    } else {
                        soundEffects.playStop();
                    }
                    if (screensaver.screensaverActive)
                        screensaver.stopScreensaver();
                    screensaver.resetInactivityTimer();
                }

                Keys.onDownPressed: {
                    navFastScrolling = event.isAutoRepeat;
                    var newIndex = currentIndex + gameGrid.columns;
                    if (newIndex < count) {
                        currentIndex = newIndex;
                        soundEffects.playDown();
                    } else {
                        soundEffects.playStop();
                    }
                    if (screensaver.screensaverActive)
                        screensaver.stopScreensaver();
                    screensaver.resetInactivityTimer();
                }

                Keys.onReleased: {
                    if (!event.isAutoRepeat &&
                        (event.key === Qt.Key_Left || event.key === Qt.Key_Right ||
                         event.key === Qt.Key_Up || event.key === Qt.Key_Down)) {
                        gameGrid.commitSelection();
                    }
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

                            if (screensaver.screensaverActive)
                                screensaver.stopScreensaver();
                        } else if (api.keys.isAccept(event)) {
                            event.accepted = true;
                            var sourceIndex = proxyModel.mapToSource(gameGrid.currentIndex);
                            var sourceModel = api.collections.get(collectionsListView.currentIndex).games;
                            if (sourceModel && sourceIndex >= 0 && sourceIndex < sourceModel.count) {
                                var gameToLaunch = sourceModel.get(sourceIndex);
                                if (gameToLaunch) {
                                    api.memory.set('lastPlayedGame', gameToLaunch);
                                    saveThemeState(gameToLaunch);
                                    gameToLaunch.launch();
                                }
                            }
                        } else if (api.keys.isFilters(event)) {
                            event.accepted = true;
                            gameActionBar.currentFilter = GameFilters.getNextFilter(
                                gameActionBar.currentFilter,
                                gameActionBar.availableFilters
                            );
                            soundEffects.playOk();
                            proxyModel.invalidate();

                            if (gameGrid.count > 0) {
                                currentgame = gameGrid.model.get(gameGrid.currentIndex);
                            } else {
                                currentgame = null;
                            }

                            gameActionBar.filterButton.buttonText = gameActionBar.currentFilter;
                        } else if (api.keys.isDetails(event)) {
                            event.accepted = true;
                            soundEffects.playFav();

                            if (currentgame) {
                                var collection = api.collections.get(collectionsListView.currentIndex);
                                for (var i = 0; i < collection.games.count; i++) {
                                    var originalGame = collection.games.get(i);
                                    if (originalGame.title === currentgame.title) {
                                        originalGame.favorite = !originalGame.favorite;

                                        if (root.debugLogsEnabled)
                                            console.log("Favorito actualizado (tecla Details):",
                                                        originalGame.title, originalGame.favorite);

                                            currentgame.favorite = originalGame.favorite;
                                        gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);

                                        if (gameActionBar.favoriteButton) {
                                            gameActionBar.favoriteButton.buttonText =
                                            currentgame.favorite ? "Favorite -" : "Favorite +";
                                        }

                                        proxyModel.invalidate();
                                        if (gameActionBar.currentFilter === "Favorites" &&
                                            proxyModel.count === 0) {
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

            Rectangle {
                id: progressBarContainer

                anchors {
                    right: parent.right
                    rightMargin: parent.width * metrics.gameGridProgressBarRightMarginFraction
                    verticalCenter: gameGrid.verticalCenter
                }

                width: metrics.gameGridProgressBarWidth
                height: gameGrid.height * metrics.gameGridProgressBarHeightFraction
                color: Qt.rgba(1, 1, 1, 0.2)
                radius: metrics.gameGridProgressBarRadius
                visible: gameGrid.count > metrics.gameGridPageSize

                Rectangle {
                    id: progressIndicator
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top

                    height: {
                        if (gameGrid.count <= metrics.gameGridPageSize)
                            return parent.height;

                        var progress = (gameGrid.currentIndex + 1) / gameGrid.count;
                        var minHeight = parent.height * 0.1;
                        var calculatedHeight = parent.height * progress;

                        return Math.max(minHeight, calculatedHeight);
                    }

                    color: myColorMapping.getColor(root.currentShortName)
                    radius: metrics.gameGridProgressBarRadius

                    Behavior on height {
                        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                    }
                    Behavior on color {
                        ColorAnimation { duration: 300 }
                    }
                }

                Rectangle {
                    anchors.fill: progressIndicator
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.3) }
                        GradientStop { position: 0.5; color: "transparent" }
                        GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.2) }
                    }
                    radius: metrics.gameGridProgressBarRadius
                }
            }
        }

        CollectionInfo {
            id: collectionInfo
            anchors.top: collectionsListView.bottom
            anchors.topMargin: metrics.collectionInfoAnchorMargin
            visible: mainMenuVisible
            currentShortName: root.currentShortName
            collectionSystemInfo: root.collectionSystemInfo
            collectionDescription: root.collectionDescription
            metrics: metrics
        }

        ActionBar {
            id: gameActionBar

            anchors {
                top: parent.top
                topMargin: metrics.actionBarTopMargin
                right: parent.right
                rightMargin: metrics.actionBarRightMargin
            }
            width: metrics.actionBarWidth
            height: metrics.actionBarHeight
            visible: gamesGridVisible
            opacity: themeContainerOpacity
            rootReference: root
            metrics: metrics

            onFavoriteClicked: {
                if (currentgame) {
                    var collection = api.collections.get(collectionsListView.currentIndex);
                    for (var i = 0; i < collection.games.count; i++) {
                        var originalGame = collection.games.get(i);
                        if (originalGame.title === currentgame.title) {
                            originalGame.favorite = !originalGame.favorite;
                            gameActionBar.availableFilters = GameFilters.getAvailableFilters(collection);
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
                            saveThemeState(sourceGame);
                            sourceGame.launch();
                            break;
                        }
                    }
                }
            }

            onBackClicked: {
                mainMenuVisible = true;
                mainMenuFocused = true;
                gamesGridVisible = false;
                gamesGridFocused = false;
                soundEffects.playBack();
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
        metrics: metrics

        anchors {
            top: parent.top
            topMargin: metrics.topBarMargin
        }
    }

    GameInfoView {
        id: ganeinfoview
        currentgame: root.currentgame
        visible: gamesGridVisible
        opacity: themeContainerOpacity
        metrics: metrics

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: metrics.gameInfoViewLeftMargin
            topMargin: metrics.gameInfoViewTopMargin
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
        metrics: metrics

        anchors {
            top: topBar.bottom
            right: parent.right
            topMargin: metrics.logoContainerTopMargin
            rightMargin: metrics.logoContainerRightMargin
        }
    }

    Text {
        id: versionLabel
        text: "v" + root.currentVersion
        color: Qt.rgba(1, 1, 1, 0.15)
        font.family: global.fonts.condensed
        font.pixelSize: metrics.px(22)
        z: 10

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: metrics.px(14)
            bottomMargin: metrics.px(10)
        }
    }

    UpdateNotification {
        id: updateNotification
        metrics: metrics
        soundEffects: soundEffects
        accentColor: root.currentColor

        onClosed: {
            if (gamesGridVisible) {
                gameGrid.forceActiveFocus();
            } else {
                collectionsListView.forceActiveFocus();
            }
        }
    }
}
