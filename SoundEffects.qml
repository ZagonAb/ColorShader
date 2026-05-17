import QtQuick 2.15
import QtMultimedia 5.15

Item {
    id: soundEffects

    property real effectsVolume: 0.2

    SoundEffect {
        id: rightSound
        source: "assets/sound/right.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: leftSound
        source: "assets/sound/left.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: favSound
        source: "assets/sound/fav.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: backSound
        source: "assets/sound/back.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: okSound
        source: "assets/sound/ok.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: upSound
        source: "assets/sound/up.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: downSound
        source: "assets/sound/down.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: stopSound
        source: "assets/sound/stop.wav"
        volume: 0.5 * effectsVolume
    }

    function playOk() { okSound.play(); }
    function playRight() { rightSound.play(); }
    function playLeft() { leftSound.play(); }
    function playFav() { favSound.play(); }
    function playBack() { backSound.play(); }
    function playUp() { upSound.play(); }
    function playDown() { downSound.play(); }
    function playStop() { stopSound.play(); }
}
