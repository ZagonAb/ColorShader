import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import "GameFilters.js" as GameFilters

Item {
    id: actionBar
    property bool showFavorite: true
    property bool showFilter: true
    property bool showLaunch: true
    property bool showBack: true
    property string currentFilter: "All Games"
    property var availableFilters: ["All Games"]
    property bool filterButtonEnabled: availableFilters.length > 1
    property Item rootReference: null
    property var metrics: null
    property bool compact: metrics ? metrics.actionButtonCompact : false

    signal favoriteClicked()
    signal filterClicked()
    signal launchClicked()
    signal backClicked()

    SoundEffect {
        id: buttonSound
        source: "assets/sound/ok.wav"
        volume: 0.5
    }

    function filterIconSource() {
        switch (currentFilter) {
            case "Favorites": return "assets/icons/favorites.svg";
            case "Last played": return "assets/icons/lastplayed.svg";
            default: return "assets/icons/allgames.svg";
        }
    }

    onCurrentFilterChanged: {
        filterButton.buttonText = currentFilter;
        console.log("Filtro cambiado a:", currentFilter);
    }

    Flow {
        id: buttonLayout
        spacing: metrics ? metrics.actionBarSpacing : (rootReference ? rootReference.width * 0.008 : 10)
        layoutDirection: Qt.LeftToRight
        anchors.centerIn: parent
        height: parent.height
        width: actionBar.compact ? parent.width : parent.width * 0.95

        ActionButton {
            id: favoriteButton
            visible: showFavorite
            rootReference: actionBar.rootReference
            metrics: actionBar.metrics
            compact: actionBar.compact
            iconSource: (currentgame && currentgame.favorite)
            ? "assets/icons/favorite-on.svg"
            : "assets/icons/favorite-off.svg"
            buttonText: currentgame ? (currentgame.favorite ? "Favorite -" : "Favorite +") : "Favorite"

            onClicked: {
                buttonSound.play();
                actionBar.favoriteClicked();
            }
        }

        ActionButton {
            id: filterButton
            visible: showFilter
            rootReference: actionBar.rootReference
            metrics: actionBar.metrics
            compact: actionBar.compact
            iconSource: actionBar.filterIconSource()
            buttonText: actionBar.currentFilter
            enabled: filterButtonEnabled
            opacity: enabled ? 1.0 : 0.3

            onClicked: {
                if (!enabled) return;
                buttonSound.play()
                actionBar.currentFilter = GameFilters.getNextFilter(
                    actionBar.currentFilter,
                    actionBar.availableFilters
                );
                actionBar.filterClicked();
            }
        }

        ActionButton {
            id: launchButton
            visible: showLaunch
            rootReference: actionBar.rootReference
            metrics: actionBar.metrics
            compact: actionBar.compact
            iconSource: "assets/icons/launch.svg"
            buttonText: "Play Game"

            onClicked: {
                buttonSound.play()
                actionBar.launchClicked()
            }
        }

        ActionButton {
            id: backButton
            visible: showBack
            rootReference: actionBar.rootReference
            metrics: actionBar.metrics
            compact: actionBar.compact
            iconSource: "assets/icons/back.svg"
            buttonText: "Back"

            onClicked: {
                buttonSound.play()
                actionBar.backClicked()
                console.log("Back action triggered")
                mainMenuVisible = true
                mainMenuFocused = true
                gamesGridVisible = false
                gamesGridFocused = false
            }
        }
    }
}
