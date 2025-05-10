import QtQuick 2.15
import QtGraphicalEffects 1.12
import "utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils

Item {
    id: gameInfoViewRoot
    width: parent.width * 0.8
    height: parent.height * 0.6
    visible: parent ? parent.gamesGridVisible : false
    clip: true

    property var currentgame

    Column {
        anchors.fill: parent
        anchors.leftMargin: parent ? parent.width * 0.020 : 0
        anchors.topMargin: parent ? parent.height * 0.010 : 0
        spacing: 20

        Item {
            width: parent.width * 0.40
            height: parent.height * 0.30

            Image {
                id: gameLogo
                anchors.fill: parent
                source: currentgame ? currentgame.assets.logo : "assets/logos/default.png"
                fillMode: Image.PreserveAspectFit
                mipmap: true
                visible: status !== Image.Error
            }

            Image {
                id: fallbackImage
                anchors.fill: parent
                source: "assets/logos/default.png"
                fillMode: Image.PreserveAspectFit
                mipmap: true
                visible: gameLogo.status === Image.Error
            }
        }

        Row {
            spacing: 10
            height: parent.height * 0.06
            width: parent.width * 0.8

            Rectangle {
                id: text_developer
                width: developer_text.contentWidth + 30
                height: parent.height
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: 2
                radius: 5

                Text {
                    id: developer_text
                    text: currentgame ? Utils.formatGameDeveloper(currentgame.developer) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }
            }

            Rectangle {
                width: releaseyear_text.contentWidth + 30
                height: parent.height
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: 2
                radius: 5

                Text {
                    id: releaseyear_text
                    text: currentgame ? Utils.getReleaseYearText(currentgame.releaseYear) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: Math.min(genre_text.implicitWidth + 30, parent.width * 0.3)
                height: parent.height
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: 2
                radius: 5

                Text {
                    id: genre_text
                    text: currentgame ? Utils.formatGameGenre(currentgame.genre) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.35
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: parent.right
                        margins: 15
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }
            }

            Rectangle {
                id: ratingContainer
                width: rating_content.width + 30
                height: parent.height
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: 2
                radius: 5

                Row {
                    id: rating_content
                    anchors.centerIn: parent
                    spacing: 5
                    height: parent.height * 0.8

                    Repeater {
                        model: currentgame ? Utils.displayRating(currentgame.rating).split(" ").length : 0
                        Image {
                            source: currentgame ? Utils.displayRating(currentgame.rating).split(" ")[index] : ""
                            width: parent.height * 0.8
                            height: width
                            mipmap: true
                        }
                    }
                }
            }

            Rectangle {
                width: players_content.width + 30
                height: parent.height
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: 2
                radius: 5
                visible: currentgame ? currentgame.players > 1 : false

                Row {
                    id: players_content
                    anchors.centerIn: parent
                    spacing: 5
                    height: parent.height * 0.8

                    Repeater {
                        model: {
                            var playersContent = currentgame ? Utils.getPlayersContent(currentgame.players) : null;
                            return playersContent ? playersContent.count : 0;
                        }

                        Item {
                            width: parent.height * 0.8
                            height: parent.height

                            Image {
                                source: {
                                    var playersContent = currentgame ? Utils.getPlayersContent(currentgame.players) : null;
                                    return playersContent ? playersContent.source : "";
                                }
                                width: parent.width
                                height: width
                                fillMode: Image.PreserveAspectFit
                                mipmap: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }

        PegasusUtils.AutoScroll {
            id: autoscroll

            anchors {
                left: parent.left
                right: parent.right
            }

            pixelsPerSecond: 50
            scrollWaitDuration: 3000
            height: parent.height * 0.35

            Text {
                id: descripText
                text: currentgame ? Utils.formatGameDescription(currentgame.description) : ""
                width: parent.width * 0.6
                wrapMode: Text.Wrap
                font.pixelSize: parent.width * 0.015
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "black"
                    radius: 2
                    samples: 5
                    spread: 0.5
                }
            }
        }
    }
}

