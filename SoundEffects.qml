import QtQuick 2.15
import QtMultimedia 5.15

Item {
    id: soundEffects

    property real effectsVolume: 0.2

    SoundEffect {
        id: changeSound
        source: "assets/sound/change.wav"
        volume: 0.5 * effectsVolume
    }

    SoundEffect {
        id: backSound
        source: "assets/sound/back.wav"
        volume: 0.5 * effectsVolume
    }

    function playChange() { changeSound.play(); }
    function playBack() { backSound.play(); }
}
