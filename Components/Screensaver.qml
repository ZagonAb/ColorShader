import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../utils.js" as Utils

Rectangle {
    id: screensaverRoot
    color: "black"
    width: parent.width
    height: parent.height
    visible: screensaverActive
    z: 1001

    property bool screensaverActive: false
    property int inactivityTimeout: 60000
    property var randomGames: []
    property int currentGameIndex: 0
    property var currentGame: null
    property bool showImage1: true
    property var metrics: null
    property var metadataLines: []

    signal screensaverStarted()
    signal screensaverStopped()

    FontLoader {
        id: titleFont
        source: "../assets/font/BlackHanSans.ttf"
    }

    FontLoader {
        id: metaFont
        source: "../assets/font/LeagueGothic.ttf"
    }

    Timer {
        id: inactivityTimer
        interval: inactivityTimeout
        running: !screensaverActive
        onTriggered: {
            screensaverActive = true;
            startScreensaver();
        }
    }

    Timer {
        id: gameCycleTimer
        interval: 8000
        running: screensaverActive
        repeat: true
        onTriggered: showNextGame()
    }

    function resetInactivityTimer() {
        inactivityTimer.restart();
    }

    function startScreensaver() {
        if (randomGames.length > 0) {
            currentGameIndex = 0;
            currentGame = null;
            showNextGame();
        }
        screensaverStarted();
    }

    function stopScreensaver() {
        screensaverActive = false;
        gameCycleTimer.stop();
        bgImage1.opacity = 0;
        bgImage2.opacity = 0;
        screensaverStopped();
    }

    function getBackgroundSource(game) {
        if (!game || !game.assets) return "";
        return game.assets.background || game.assets.screenshot || "";
    }

    function buildMetadataLines(game) {
        if (!game) return [];

        var lines = [];

        if (game.genre && game.genre.trim() !== "") {
            lines.push("<font color='#FFD966'><b>Genre:</b></font> " +
            Utils.formatGameGenre(game.genre));
        }
        if (game.developer && game.developer.trim() !== "") {
            lines.push("<font color='#FFD966'><b>Developer:</b></font> " +
            Utils.formatGameDeveloper(game.developer));
        }
        if (game.publisher && game.publisher.trim() !== "") {
            lines.push("<font color='#FFD966'><b>Publisher:</b></font> " + game.publisher);
        }
        if (game.rating && game.rating > 0) {
            lines.push("<font color='#FFD966'><b>Rating:</b></font> " +
            Utils.getRatingStars(game.rating));
        }
        lines.push("<font color='#FFD966'><b>Favorite:</b></font> " +
        (game.favorite ? "Yes" : "No"));

        var collectionName = "";
        if (game.collections && game.collections.count > 0) {
            collectionName = game.collections.get(0).name;
        }
        if (collectionName !== "") {
            lines.push("<font color='#FFD966'><b>Collection:</b></font> " + collectionName);
        }

        if (game.lastPlayed && !isNaN(game.lastPlayed.getTime()) &&
            game.lastPlayed.getTime() > 0) {
            lines.push("<font color='#FFD966'><b>LastPlayed:</b></font> " +
            Utils.formatLastPlayedShort(game.lastPlayed));
            }

            if (game.playTime && game.playTime > 0) {
                lines.push("<font color='#FFD966'><b>PlayTime:</b></font> " +
                Utils.formatPlayTimeLong(game.playTime));
            }

            if (game.playCount && game.playCount > 0) {
                lines.push("<font color='#FFD966'><b>PlayCount:</b></font> " + game.playCount);
            }

            return lines;
    }

    function showNextGame() {
        if (!screensaverActive) return;
        if (randomGames.length === 0) {
            stopScreensaver();
            return;
        }

        if (currentGameIndex >= randomGames.length) {
            currentGameIndex = 0;
        }

        currentGame = randomGames[currentGameIndex];

        var bgSource = getBackgroundSource(currentGame);
        if (showImage1) {
            bgImage2.source = bgSource;
            bgImage1.opacity = 0;
            bgImage2.opacity = 1;
        } else {
            bgImage1.source = bgSource;
            bgImage2.opacity = 0;
            bgImage1.opacity = 1;
        }

        var logoSource = (currentGame && currentGame.assets && currentGame.assets.logo)
        ? currentGame.assets.logo : "";
        if (logoSource !== "") {
            gameLogo.source = logoSource;
            gameLogo.visible = true;
            gameTitleFallback.visible = false;
        } else {
            gameLogo.source = "";
            gameLogo.visible = false;
            gameTitleFallback.visible = true;
        }

        metadataLines = buildMetadataLines(currentGame);

        contentRevealAnim.restart();

        currentGameIndex++;
        showImage1 = !showImage1;
    }

    Item {
        id: backgroundsContainer
        anchors.fill: parent

        Image {
            id: bgImage1
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            opacity: 0
            Behavior on opacity {
                NumberAnimation { duration: 1200; easing.type: Easing.InOutQuad }
            }
        }

        Image {
            id: bgImage2
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            opacity: 0
            Behavior on opacity {
                NumberAnimation { duration: 1200; easing.type: Easing.InOutQuad }
            }
        }
    }

    ShaderEffectSource {
        id: backgroundsSource
        sourceItem: backgroundsContainer
        hideSource: true
        live: true
        width: screensaverRoot.width
        height: screensaverRoot.height
    }

    ShaderEffect {
        id: crtEffect
        anchors.fill: parent
        property variant source: backgroundsSource
        property real time: 0.0

        fragmentShader: "
        uniform sampler2D source;
        uniform lowp float qt_Opacity;
        uniform lowp float time;
        varying highp vec2 qt_TexCoord0;

        void main() {
        vec2 uv = qt_TexCoord0;

        vec2 centered = uv - 0.5;
        float dist = length(centered);
        uv = centered * (1.0 + 0.08 * dist * dist) + 0.5;

        vec4 color = texture2D(source, uv);

        float scanline = sin(uv.y * 600.0) * 0.04;
        color.rgb -= scanline;

        float vignette = 1.0 - 0.2 * dist;
        color.rgb *= vignette;
        color.rgb *= 1.1;
        gl_FragColor = color * qt_Opacity;
    }
    "
    }

    LinearGradient {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: metrics ? metrics.screensaverPanelWidth * 1.4 : parent.width * 0.5
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#CC000000" }
            GradientStop { position: 0.7; color: "#40000000" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
        z: 10
    }

    LinearGradient {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height * 0.35
        start: Qt.point(0, height)
        end: Qt.point(0, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#AA000000" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
        z: 11
    }

    Item {
        id: favoriteBadge
        anchors {
            top: parent.top
            right: parent.right
            margins: 40
        }
        width: 64
        height: 64
        visible: currentGame && currentGame.favorite
        opacity: visible ? 1 : 0
        z: 100

        Behavior on opacity {
            NumberAnimation { duration: 400 }
        }

        Image {
            anchors.fill: parent
            source: "../assets/icons/favorite-on.svg"
            fillMode: Image.PreserveAspectFit
            mipmap: true

            layer.enabled: true
            layer.effect: DropShadow {
                color: "#A0000000"
                radius: 8
                samples: 16
                spread: 0.4
            }
        }
    }

    Item {
        id: leftPanel
        anchors {
            left: parent.left
            leftMargin: metrics ? metrics.screensaverPanelLeftMargin : screensaverRoot.width * 0.015
            bottom: parent.bottom
            bottomMargin: metrics ? metrics.screensaverPanelBottomMargin : screensaverRoot.height * 0.055
        }
        width: metrics ? metrics.screensaverPanelWidth : screensaverRoot.width * 0.40
        height: leftColumn.height
        opacity: 1
        z: 100

        Column {
            id: leftColumn
            width: parent.width
            spacing: 0

            Item {
                id: logoContainer
                width: parent.width
                height: {
                    if (!metrics) return parent.width * 0.5;
                    var wLimit = parent.width * metrics.screensaverLogoWidthFraction;
                    var hLimit = screensaverRoot.height * metrics.screensaverLogoMaxHeightFraction;
                    return Math.min(wLimit * 0.55, hLimit);
                }

                Image {
                    id: gameLogo
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                    asynchronous: true
                    visible: false
                    horizontalAlignment: Image.AlignLeft

                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "#A0000000"
                        radius: 14
                        samples: 22
                        spread: 0.5
                    }
                }

                Text {
                    id: gameTitleFallback
                    anchors.fill: parent
                    text: currentGame ? currentGame.title : ""
                    color: "white"
                    font.family: titleFont.name
                    font.pixelSize: 56
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 20
                    visible: false

                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "#A0000000"
                        radius: 14
                        samples: 22
                        spread: 0.5
                    }
                }
            }

            Item {
                width: 1
                height: metrics ? metrics.screensaverLogoBottomMargin : 18
            }

            Column {
                id: metadataColumn
                width: parent.width
                spacing: metrics ? metrics.screensaverMetadataRowSpacing : 8

                Repeater {
                    model: metadataLines

                    Rectangle {
                        id: pill

                        readonly property real paddingH: metrics ? metrics.screensaverMetadataPillPaddingH : 18
                        readonly property real paddingV: metrics ? metrics.screensaverMetadataPillPaddingV : 8

                        readonly property real maxTextWidth: leftPanel.width - paddingH * 2

                        width: Math.min(pillText.implicitWidth + paddingH * 2, leftPanel.width)
                        height: pillText.implicitHeight + paddingV * 2

                        radius: metrics ? metrics.screensaverMetadataPillRadius : 18
                        color: Qt.rgba(0, 0, 0, 0.65)
                        border.color: Qt.rgba(1, 1, 1, 0.10)
                        border.width: 1

                        Text {
                            id: pillText
                            anchors {
                                left: parent.left
                                leftMargin: pill.paddingH
                                verticalCenter: parent.verticalCenter
                            }
                            width: pill.maxTextWidth
                            text: modelData
                            textFormat: Text.StyledText
                            color: "#FFFFFF"
                            font.family: titleFont.name
                            font.pixelSize: metrics ? metrics.screensaverMetadataFontSize : 22
                            elide: Text.ElideRight
                            maximumLineCount: 1
                        }
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: contentRevealAnim
        PropertyAction { target: leftPanel; property: "opacity"; value: 0 }
        PauseAnimation { duration: 60 }
        NumberAnimation {
            target: leftPanel
            property: "opacity"
            to: 1
            duration: 700
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        anchors.fill: parent
        z: 1000
        onClicked: {
            if (screensaverActive) {
                stopScreensaver();
            }
        }
    }
}
