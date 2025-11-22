import QtQuick 2.15
import QtGraphicalEffects 1.12

ShaderEffect {
    id: noiseEffect

    property real noiseIntensity: 0.03
    property real noiseOpacity: 0.5

    fragmentShader: "
    varying highp vec2 qt_TexCoord0;
    uniform lowp float qt_Opacity;
    uniform highp float noiseIntensity;
    uniform highp float noiseOpacity;

    highp float random(highp vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
highp vec2 uv = qt_TexCoord0;
highp float noise = random(uv);
highp float smoothNoise = 0.0;
for(float x = -1.0; x <= 1.0; x += 1.0) {
    for(float y = -1.0; y <= 1.0; y += 1.0) {
        smoothNoise += random(uv + vec2(x, y) * 0.001);
}
}
smoothNoise /= 9.0;

highp float finalNoise = mix(smoothNoise, noise, 0.3);
highp vec3 color = vec3(0.0) + finalNoise * noiseIntensity;

gl_FragColor = vec4(color, noiseOpacity * qt_Opacity);
}
"
}
