import QtQuick 2.15

Rectangle {
    id: debugPanel

    property var metrics: null
    property bool debugVisible: true

    visible: debugVisible && metrics !== null

    color: Qt.rgba(0, 0, 0, 0.78)
    border.color: "#00ff88"
    border.width: 1
    radius: 6

    implicitWidth: contentColumn.implicitWidth + 20
    implicitHeight: contentColumn.implicitHeight + 16

    enabled: false

    Column {
        id: contentColumn
        anchors.centerIn: parent
        spacing: 2

        Text {
            text: "── LAYOUTMETRICS ──"
            color: "#00ff88"
            font.family: "monospace"
            font.pixelSize: 12
            font.bold: true
        }

        Text {
            text: "viewport : " + Math.round(debugPanel.metrics ? debugPanel.metrics.viewportWidth : 0) +
            " x " + Math.round(debugPanel.metrics ? debugPanel.metrics.viewportHeight : 0)
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "aspect   : " + (debugPanel.metrics ? debugPanel.metrics.aspectRatio.toFixed(4) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "profile  : " + (debugPanel.metrics ? debugPanel.metrics.profile : "—")
            color: {
                if (!debugPanel.metrics) return "#ff6666";
                switch (debugPanel.metrics.profile) {
                    case "wide": return "#00ff88";
                    case "standard": return "#ffff00";
                    case "square": return "#ffaa00";
                    case "portrait": return "#ff6666";
                    default: return "#ffffff";
                }
            }
            font.family: "monospace"
            font.pixelSize: 12
            font.bold: true
        }

        Text {
            text: "compact  : " + (debugPanel.metrics ? debugPanel.metrics.compactness.toFixed(3) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "uScale   : " + (debugPanel.metrics ? debugPanel.metrics.uniformScale.toFixed(4) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "slack X/Y: " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.horizontalSlack) : "—") + " / " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.verticalSlack) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "grid cols: " + (debugPanel.metrics ? debugPanel.metrics.gameGridColumns : "—") +
            "  rows: " + (debugPanel.metrics ? debugPanel.metrics.gameGridRows : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "cell     : " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.gameCellWidth) : "—") + " x " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.gameCellHeight) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Text {
            text: "grid     : " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.gameGridWidth) : "—") + " x " +
            (debugPanel.metrics ? Math.round(debugPanel.metrics.gameGridHeight) : "—")
            color: "#88ffcc"
            font.family: "monospace"
            font.pixelSize: 12
        }
    }
}
