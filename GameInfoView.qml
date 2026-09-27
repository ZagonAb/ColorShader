import QtQuick 2.15
import QtGraphicalEffects 1.12
import "utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils

Item {
    id: gameInfoViewRoot
    width: metrics ? metrics.gameInfoViewWidth : parent.width * 0.50
    height: metrics ? metrics.gameInfoViewHeight : parent.height * 0.50
    visible: parent ? parent.gamesGridVisible : false
    property var currentgame: null
    property var metrics: null

    onCurrentgameChanged: {
        if (currentgame && currentgame.assets && currentgame.assets.logo) {
            gameLogo.source = currentgame.assets.logo;
        } else {
            gameLogo.source = "";
        }
    }

    Column {
        anchors.fill: parent
        anchors.leftMargin: metrics ? metrics.gameInfoViewColumnLeftMargin : (parent ? parent.width * 0.020 : 0)
        anchors.topMargin: metrics ? metrics.gameInfoViewColumnTopMargin : (parent ? parent.height * 0.010 : 0)
        spacing: metrics ? metrics.gameInfoViewColumnSpacing : 20

        Item {
            width: metrics ? metrics.gameInfoViewLogoWidth : parent.width * 0.42
            height: metrics ? metrics.gameInfoViewLogoHeight : parent.height * 0.32

            Image {
                id: gameLogo
                anchors.fill: parent
                source: (currentgame && currentgame.assets && currentgame.assets.logo)
                ? currentgame.assets.logo
                : ""
                fillMode: Image.PreserveAspectFit
                mipmap: true
                visible: source !== ""
                && status !== Image.Error
                && status !== Image.Null
            }

            Text {
                id: fallbackText
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    leftMargin: -parent.width * 0.1
                    rightMargin: -parent.width * 0.1
                }
                text: currentgame ? currentgame.title : ""
                color: "white"
                font.family: "Black Han Sans"
                font.pixelSize: metrics.topBarClockFontSize
                font.bold: false
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                minimumPixelSize: 12
                fontSizeMode: Text.Fit

                visible: !gameLogo.visible

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "black"
                    radius: 3
                    samples: 5
                    spread: 0.7
                }

                FontLoader {
                    id: blackHanSansFont
                    source: "assets/font/BlackHanSans.ttf"
                    onStatusChanged: {
                        if (status === FontLoader.Ready) {
                            fallbackText.font.family = blackHanSansFont.name
                        }
                    }
                }
            }
        }

        Row {
            spacing: metrics ? metrics.gameInfoViewPillRowSpacing : parent.width * 0.01
            height: metrics ? metrics.gameInfoViewPillRowHeight : parent.height * 0.06
            width: metrics ? metrics.gameInfoViewPillRowWidth : parent.width * 0.8

            Rectangle {
                id: text_developer
                width: developer_text.contentWidth + (metrics ? metrics.gameInfoViewPillPaddingH : 30)
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5

                Text {
                    id: developer_text
                    text: currentgame ? Utils.formatGameDeveloper(currentgame.developer) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.height * 0.45
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: (metrics && !metrics.isWide) ? Text.ElideNone : Text.ElideRight
                    maximumLineCount: 1
                }
            }

            Rectangle {
                width: releaseyear_text.contentWidth + (metrics ? metrics.gameInfoViewPillPaddingH : 30)
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5

                Text {
                    id: releaseyear_text
                    text: currentgame ? Utils.getReleaseYearText(currentgame.releaseYear) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.height * 0.45
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: {
                    var base = genre_text.implicitWidth + (metrics ? metrics.gameInfoViewPillPaddingH : 30);
                    if (metrics && !metrics.isWide) return base;
                    return Math.min(base, parent.width * 0.3);
                }
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5

                Text {
                    id: genre_text
                    text: currentgame ? Utils.formatGameGenre(currentgame.genre) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.height * 0.45
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: parent.right
                        margins: 15
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: (metrics && !metrics.isWide) ? Text.ElideNone : Text.ElideRight
                    maximumLineCount: 1
                }
            }

            Rectangle {
                id: ratingContainer
                width: rating_content.width + (metrics ? metrics.gameInfoViewPillPaddingH : 30)
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5

                Row {
                    id: rating_content
                    anchors.centerIn: parent
                    spacing: 5
                    height: parent.height * 0.8

                    Repeater {
                        model: (metrics && metrics.isWide && currentgame)
                        ? Utils.displayRating(currentgame.rating).split(" ").length
                        : 0
                        Image {
                            source: currentgame
                            ? Utils.displayRating(currentgame.rating).split(" ")[index]
                            : ""
                            width: parent.height * 0.8
                            height: width
                            mipmap: true
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Text {
                        visible: metrics && !metrics.isWide
                        text: currentgame ? Math.round((currentgame.rating || 0) * 100) + "%" : ""
                        color: "white"
                        font.bold: true
                        font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.parent.height * 0.45
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle {
                width: lastPlayedText.contentWidth + (metrics ? metrics.gameInfoViewPillPaddingH : 30)
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5
                visible: currentgame ? (currentgame.lastPlayed && currentgame.lastPlayed.getTime() > 0) : false

                Text {
                    id: lastPlayedText
                    text: currentgame ? Utils.formatLastPlayedDate(currentgame.lastPlayed) : ""
                    color: "white"
                    font.bold: true
                    font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.height * 0.45
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                width: players_content.width +
                (showEllipsisItem.visible ? showEllipsisItem.width : 0) +
                (metrics ? metrics.gameInfoViewPillPaddingH : 30)
                height: parent.height + (metrics ? metrics.gameInfoViewPillPaddingV : 10)
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "white"
                border.width: metrics ? metrics.gameInfoViewPillBorderWidth : 2
                radius: metrics ? metrics.gameInfoViewPillRadius : 5
                visible: currentgame ? currentgame.players > 1 : false

                Row {
                    id: players_content
                    anchors.centerIn: parent
                    spacing: 5
                    height: parent.height * 0.8

                    Repeater {
                        model: {
                            if (!(metrics && metrics.isWide)) return 0;
                            var pc = currentgame ? Utils.getPlayersContent(currentgame.players) : null;
                            return pc ? pc.count : 0;
                        }

                        Item {
                            width: parent.height * 0.8
                            height: parent.height

                            Image {
                                source: {
                                    var pc = currentgame ? Utils.getPlayersContent(currentgame.players) : null;
                                    return pc ? pc.source : "";
                                }
                                width: parent.width
                                height: width
                                fillMode: Image.PreserveAspectFit
                                mipmap: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    Text {
                        visible: metrics && !metrics.isWide
                        text: (currentgame && currentgame.players > 1) ? currentgame.players + "P" : ""
                        color: "white"
                        font.bold: true
                        font.pixelSize: metrics ? metrics.gameInfoViewPillFontSize : parent.parent.height * 0.45
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        id: showEllipsisItem
                        width: ellipsisText.implicitWidth
                        height: parent.height
                        visible: {
                            if (!(metrics && metrics.isWide)) return false;
                            var pc = currentgame ? Utils.getPlayersContent(currentgame.players) : null;
                            return pc ? pc.showEllipsis : false;
                        }

                        Text {
                            id: ellipsisText
                            text: "..."
                            color: "white"
                            font.bold: true
                            font.pixelSize: parent.height * 0.6
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }

        Item {
            id: scrollContainer
            anchors {
                left: parent.left
                right: parent.right
            }
            height: metrics ? metrics.gameInfoViewScrollHeight : parent.height * 0.43
            clip: true

            Rectangle {
                id: fadeContainer
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.05
                color: "transparent"
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: fadeContainer.width
                        height: fadeContainer.height
                        Rectangle {
                            anchors.top: parent.top
                            width: parent.width
                            height: parent.height * 0.15
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#00FFFFFF" }
                                GradientStop { position: 1.0; color: "#FFFFFFFF" }
                            }
                        }
                        Rectangle {
                            y: parent.height * 0.15
                            width: parent.width
                            height: parent.height * 0.7
                            color: "#FFFFFFFF"
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: parent.height * 0.15
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#FFFFFFFF" }
                                GradientStop { position: 1.0; color: "#00FFFFFF" }
                            }
                        }
                    }
                }

                PegasusUtils.AutoScroll {
                    id: autoscroll
                    anchors.fill: parent
                    pixelsPerSecond: 15
                    scrollWaitDuration: 3000

                    Item {
                        width: autoscroll.width
                        height: childrenRect.height + topPadding + bottomPadding

                        property real topPadding: autoscroll.height * 0.03
                        property real bottomPadding: autoscroll.height * 0.03

                        Item {
                            id: topSpacer
                            width: parent.width
                            height: parent.topPadding
                        }

                        Text {
                            id: descripText
                            anchors {
                                top: topSpacer.bottom
                                left: parent.left
                                leftMargin: parent.width * 0.01
                            }
                            text: currentgame ? Utils.formatGameDescription(currentgame.description) : ""
                            width: parent.width * (metrics ? metrics.gameInfoViewDescriptionWidthFactor : 0.90)
                            lineHeight: 1.2
                            wrapMode: Text.Wrap
                            font.pixelSize: metrics ? metrics.gameInfoViewDescriptionFontSize : autoscroll.width * 0.027
                            color: "white"
                            layer.enabled: true
                            layer.effect: DropShadow {
                                color: "black"
                                radius: 2
                                samples: 5
                                spread: 0.5
                            }
                        }

                        Item {
                            id: bottomSpacer
                            anchors.top: descripText.bottom
                            width: parent.width
                            height: parent.bottomPadding - 10
                        }
                    }
                }
            }
        }
    }
}
