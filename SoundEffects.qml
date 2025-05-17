// SoundEffects.qml
import QtQuick 2.15
import QtMultimedia 5.15

Item {
    id: soundEffects

    property real effectsVolume: 1.0

    SoundEffect {
        id: changeSound
        source: "assets/sound/change.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: goSound
        source: "assets/sound/go.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: backSound
        source: "assets/sound/back.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: playSound
        source: "assets/sound/go.wav"
        volume: 1.0 * effectsVolume
    }

    function playChange() { changeSound.play(); }
    function playGo() { goSound.play(); }
    function playBack() { backSound.play(); }
    function playPlay() { playSound.play(); }
}
