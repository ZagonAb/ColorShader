import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import "GameFilters.js" as GameFilters

Item {
    id: actionBar
    width: parent.width * 0.8
    height: parent.height * 0.08
    z: 50

    property bool showFavorite: true
    property bool showFilter: true
    property bool showLaunch: true
    property bool showBack: true
    property string currentFilter: "All Games"
    property var availableFilters: ["All Games"]
    property bool filterButtonEnabled: availableFilters.length > 1

    signal favoriteClicked()
    signal filterClicked()
    signal launchClicked()
    signal backClicked()

    SoundEffect {
        id: buttonSound
        source: "assets/sound/change.wav"
        volume: 0.5
    }

    onCurrentFilterChanged: {
        filterButton.buttonText = currentFilter;
        console.log("Filtro cambiado a:", currentFilter);
    }

    Row {
        id: buttonLayout
        anchors.centerIn: parent
        spacing: width * 0.02

        ActionButton {
            id: favoriteButton
            visible: showFavorite
            width: actionBar.width * 0.2
            iconSource: "assets/icons/favorite.png"
            buttonText: currentgame ? (currentgame.favorite ? "Favorite -" : "Favorite +") : "Favorite"

            onClicked: {
                buttonSound.play();
                actionBar.favoriteClicked();
            }
        }

        ActionButton {
            id: filterButton
            visible: showFilter
            iconSource: "assets/icons/filter.png"
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
            width: actionBar.width * 0.2
            iconSource: "assets/icons/launch.png"
            buttonText: "Play Game"

            onClicked: {
                buttonSound.play()
                actionBar.launchClicked()
            }
        }

        ActionButton {
            id: backButton
            visible: showBack
            width: actionBar.width * 0.2
            iconSource: "assets/icons/back.png"
            buttonText: "Back"

            onClicked: {
                buttonSound.play()
                actionBar.backClicked()
                console.log("Back action triggered")
                mainMenuVisible = true
                mainMenuFocused = true
                gamesGridVisible = false
                gamesGridFocused = false
                backSound.play()
            }
        }
    }
}
