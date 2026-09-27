import QtQuick 2.15

QtObject {
    id: metrics

    property real viewportWidth: 1920
    property real viewportHeight: 1080

    readonly property real designWidth: 1920
    readonly property real designHeight: 1080
    readonly property real designAspect: designWidth / designHeight

    readonly property real aspectRatio: viewportWidth / viewportHeight

    readonly property string profile: {
        var ar = aspectRatio;
        if (ar >= 1.60) return "wide";
        if (ar >= 1.20) return "standard";
        if (ar >= 0.90) return "square";
        return "portrait";
    }

    readonly property bool isWide: profile === "wide"
    readonly property bool isStandard: profile === "standard"
    readonly property bool isSquare: profile === "square"
    readonly property bool isPortrait: profile === "portrait"
    readonly property bool isCompact: profile === "square" || profile === "portrait"

    readonly property real compactness: {
        var ar = aspectRatio;
        if (ar >= designAspect) return 0;
        if (ar <= 1.0) return 1;
        return (designAspect - ar) / (designAspect - 1.0);
    }

    readonly property real uniformScale:
    Math.min(viewportWidth / designWidth, viewportHeight / designHeight)

    readonly property real scaledWidth: designWidth * uniformScale
    readonly property real scaledHeight: designHeight * uniformScale

    readonly property real horizontalSlack: viewportWidth - scaledWidth
    readonly property real verticalSlack: viewportHeight - scaledHeight

    readonly property real contentOffsetX: horizontalSlack / 2
    readonly property real contentOffsetY: verticalSlack / 2

    function px(designPixels) {
        return designPixels * uniformScale;
    }

    readonly property real safeMarginTop: px(20)
    readonly property real safeMarginBottom: px(20)
    readonly property real safeMarginLeft: px(30)
    readonly property real safeMarginRight: px(30)

    readonly property real spacingSmall: px(8)
    readonly property real spacingMedium: px(16)
    readonly property real spacingLarge: px(32)

    readonly property real fontSmall: px(16)
    readonly property real fontBody: px(22)
    readonly property real fontMedium: px(30)
    readonly property real fontTitle: px(44)
    readonly property real fontDisplay: px(60)

    readonly property real gameGridContainerTop: viewportHeight * 0.50
    readonly property real gameGridContainerHeight: viewportHeight * 0.50

    readonly property real gameGridWidth: viewportWidth * 0.90
    readonly property real gameGridHeight: gameGridContainerHeight * 0.98

    readonly property real gameCellAspect: 1.6
    readonly property int gameGridRows: 2
    readonly property real gameGridRowHeight: gameGridHeight / gameGridRows
    readonly property real gameCellMaxWidthFromHeight: gameGridRowHeight * gameCellAspect

    readonly property int gameGridColumns: {
        if (gameCellMaxWidthFromHeight <= 0) return 1;
        var cols = Math.floor(gameGridWidth / gameCellMaxWidthFromHeight);
        return Math.max(1, cols);
    }

    readonly property real gameCellWidth: gameGridWidth / gameGridColumns
    readonly property real gameCellHeight: gameGridHeight / gameGridRows

    readonly property real gameCellPaddingX: gameCellWidth * 0.030
    readonly property real gameCellPaddingY: gameCellHeight * 0.050

    readonly property real gameCellContentWidth: gameCellWidth - gameCellPaddingX
    readonly property real gameCellContentHeight: gameCellHeight - gameCellPaddingY

    readonly property real gameGridProgressBarWidth: {
        switch (profile) {
            case "wide": return 8;
            case "standard": return 10;
            case "square": return 10;
            case "portrait": return 6;
            default: return 6;
        }
    }

    readonly property real gameGridProgressBarRadius: {
        switch (profile) {
            case "wide": return 3;
            case "standard": return 6;
            case "square": return 6;
            case "portrait": return 3;
            default: return 3;
        }
    }

    readonly property real gameGridProgressBarRightMarginFraction: 0.02
    readonly property real gameGridProgressBarHeightFraction: 0.90

    readonly property real gameCardRadius: {
        switch (profile) {
            case "wide": return px(10);
            case "standard": return px(40);
            case "square": return px(30);
            case "portrait": return px(10);
            default: return px(10);
        }
    }

    readonly property real gameCardBorderWidth: {
        switch (profile) {
            case "wide": return px(6);
            case "standard": return px(10);
            case "square": return px(12);
            case "portrait": return px(6);
            default: return px(6);
        }
    }

    readonly property real gameCardScaleSelected: 1.05
    readonly property real gameCardScaleNormal: 1.0

    readonly property int gameGridPageSize: gameGridColumns * gameGridRows

    readonly property real collectionListWidth: viewportWidth * 0.90

    readonly property int collectionVisibleItems: {
        switch (profile) {
            case "wide": return 7;
            case "standard": return 5;
            case "square": return 4;
            case "portrait": return 4;
            default: return 7;
        }
    }

    readonly property real collectionListHeight: {
        switch (profile) {
            case "wide": return viewportHeight * 0.30;
            case "standard": return viewportHeight * 0.26;
            case "square": return viewportHeight * 0.24;
            case "portrait": return viewportHeight * 0.24;
            default: return viewportHeight * 0.30;
        }
    }

    readonly property real collectionListSpacing: {
        switch (profile) {
            case "wide": return Math.max(px(5), px(10));
            case "standard": return Math.max(px(5), px(10));
            case "square": return Math.max(px(3), px(5));
            case "portrait": return Math.max(px(3), px(5));
            default: return Math.max(px(5), px(10));
        }
    }

    readonly property real collectionItemWidth:
    (collectionListWidth - (collectionVisibleItems - 1) * collectionListSpacing)
    / collectionVisibleItems

    readonly property real collectionItemHeight: collectionListHeight * 0.90

    readonly property real collectionItemScaleSelected: {
        switch (profile) {
            case "wide": return 1.50;
            case "standard": return 1.30;
            case "square": return 1.15;
            case "portrait": return 1.15;
            default: return 1.50;
        }
    }

    readonly property real collectionItemScaleNormal: 1.0

    readonly property real collectionFallbackFontSize: collectionItemWidth * 0.10

    readonly property real collectionInfoWidth: viewportWidth * 0.90

    readonly property real collectionInfoHeight: {
        switch (profile) {
            case "wide": return viewportHeight * 0.33;
            case "standard": return viewportHeight * 0.30;
            case "square": return viewportHeight * 0.28;
            case "portrait": return viewportHeight * 0.28;
            default: return viewportHeight * 0.33;
        }
    }

    readonly property real collectionInfoTopMargin: px(25)

    readonly property real collectionInfoFontSize: {
        switch (profile) {
            case "wide": return px(40);
            case "standard": return px(42);
            case "square": return px(54);
            case "portrait": return px(54);
            default: return px(40);
        }
    }

    readonly property real collectionInfoDescriptionFontSize: {
        switch (profile) {
            case "wide": return px(40);
            case "standard": return px(50);
            case "square": return px(72);
            case "portrait": return px(72);
            default: return px(40);
        }
    }

    readonly property real collectionInfoAnchorMargin: {
        switch (profile) {
            case "wide": return viewportHeight * 0.05;
            case "standard": return viewportHeight * 0.1;
            case "square": return viewportHeight * 0.1;
            case "portrait": return viewportHeight * 0.03;
            default: return viewportHeight * 0.05;
        }
    }

    readonly property real topBarHeight: viewportHeight * 0.060
    readonly property real topBarMargin: px(20)

    readonly property real topBarClockFontSize: {
        switch (profile) {
            case "wide": return px(48);
            case "standard": return px(48);
            case "square": return px(62);
            case "portrait": return px(62);
            default: return px(48);
        }
    }

    readonly property real topBarBatteryFontSize: {
        switch (profile) {
            case "wide": return px(48);
            case "standard": return px(48);
            case "square": return px(64);
            case "portrait": return px(64);
            default: return px(48);
        }
    }

    readonly property real topBarBatteryIconSize: {
        switch (profile) {
            case "wide": return px(78);
            case "standard": return px(78);
            case "square": return px(100);
            case "portrait": return px(84);
            default: return px(48);
        }
    }

    readonly property real topBarBatteryGap: {
        switch (profile) {
            case "wide": return px(32);
            case "standard": return px(20);
            case "square": return px(20);
            case "portrait": return px(14);
            default: return px(8);
        }
    }

    readonly property real topBarBatteryRightMargin: px(96)

    readonly property real actionBarHeight: viewportHeight * 0.07

    readonly property real actionBarTopMargin: {
        switch (profile) {
            case "wide": return viewportHeight * 0.43;
            case "standard": return viewportHeight * 0.42;
            case "square": return viewportHeight * 0.42;
            case "portrait": return viewportHeight * 0.38;
            default: return viewportHeight * 0.43;
        }
    }

    readonly property bool actionButtonCompact: profile !== "wide"

    readonly property real actionBarSpacing: {
        if (actionButtonCompact) return actionButtonDiameterCompact * 0.45;
        return px(10);
    }

    readonly property real actionBarWidth: {
        if (actionButtonCompact) {
            var contentWidth = actionButtonDiameterCompact * 4 + actionBarSpacing * 3;
            return contentWidth + px(30);
        }
        return viewportWidth * 0.45;
    }

    readonly property real actionBarRightMargin: {
        if (actionButtonCompact) return px(80);
        return viewportWidth * 0.03;
    }

    readonly property real actionButtonWidth: viewportWidth * 0.10
    readonly property real actionButtonHeight: viewportHeight * 0.06
    readonly property real actionButtonRadius: actionButtonHeight / 2

    readonly property real actionButtonDiameterCompact: viewportHeight * 0.065

    readonly property real gameInfoViewWidth: {
        switch (profile) {
            case "wide": return viewportWidth * 0.55;
            case "standard": return viewportWidth * 0.60;
            case "square": return viewportWidth * 0.56;
            case "portrait": return viewportWidth * 0.55;
            default: return viewportWidth * 0.50;
        }
    }

    readonly property real gameInfoViewHeight: viewportHeight * 0.50

    readonly property real gameInfoViewLeftMargin: viewportWidth * 0.03

    readonly property real gameInfoViewTopMargin: {
        switch (profile) {
            case "wide": return viewportHeight * 0.03;
            case "standard": return viewportHeight * 0.015;
            case "square": return viewportHeight * 0.0;
            case "portrait": return viewportHeight * 0.010;
            default: return viewportHeight * 0.03;
        }
    }

    readonly property real gameInfoViewColumnTopMargin: {
        switch (profile) {
            case "wide": return gameInfoViewHeight * 0.010;
            case "standard": return gameInfoViewHeight * 0.005;
            case "square": return 0;
            case "portrait": return 0;
            default: return gameInfoViewHeight * 0.010;
        }
    }

    readonly property real gameInfoViewColumnLeftMargin: {
        switch (profile) {
            case "wide": return gameInfoViewWidth * 0.020;
            case "standard": return gameInfoViewWidth * 0.010;
            case "square": return gameInfoViewWidth * 0.010;
            case "portrait": return gameInfoViewWidth * 0.010;
            default: return gameInfoViewWidth * 0.020;
        }
    }

    readonly property real gameInfoViewColumnSpacing: {
        switch (profile) {
            case "wide": return px(20);
            case "standard": return px(24);
            case "square": return px(30);
            case "portrait": return px(30);
            default: return px(20);
        }
    }

    readonly property real gameInfoViewLogoWidth: {
        switch (profile) {
            case "wide": return gameInfoViewWidth * 0.42;
            case "standard": return gameInfoViewWidth * 0.46;
            case "square": return gameInfoViewWidth * 0.56;
            case "portrait": return gameInfoViewWidth * 0.46;
            default: return gameInfoViewWidth * 0.42;
        }
    }

    readonly property real gameInfoViewLogoHeight: {
        switch (profile) {
            case "wide": return gameInfoViewHeight * 0.32;
            case "standard": return gameInfoViewHeight * 0.35;
            case "square": return gameInfoViewHeight * 0.45;
            case "portrait": return gameInfoViewHeight * 0.35;
            default: return gameInfoViewHeight * 0.32;
        }
    }

    readonly property real gameInfoViewPillRowWidth: gameInfoViewWidth * 0.80
    readonly property real gameInfoViewPillRowHeight: gameInfoViewHeight * 0.06
    readonly property real gameInfoViewPillRowSpacing: gameInfoViewWidth * 0.01

    readonly property real gameInfoViewPillPaddingH: {
        switch (profile) {
            case "wide": return px(30);
            case "standard": return px(24);
            case "square": return px(20);
            case "portrait": return px(20);
            default: return px(30);
        }
    }

    readonly property real gameInfoViewPillPaddingV: px(10)
    readonly property real gameInfoViewPillBorderWidth: px(2)
    readonly property real gameInfoViewPillRadius: px(5)

    readonly property real gameInfoViewPillFontSize: {
        switch (profile) {
            case "wide": return px(24);
            case "standard": return px(32);
            case "square": return px(40);
            case "portrait": return px(42);
            default: return px(20);
        }
    }

    readonly property real gameInfoViewScrollHeight: gameInfoViewHeight * 0.43

    readonly property real gameInfoViewDescriptionFontSize: {
        switch (profile) {
            case "wide": return gameInfoViewWidth * 0.027;
            case "standard": return gameInfoViewWidth * 0.034;
            case "square": return gameInfoViewWidth * 0.036;
            case "portrait": return gameInfoViewWidth * 0.045;
            default: return gameInfoViewWidth * 0.027;
        }
    }

    readonly property real gameInfoViewDescriptionWidthFactor: {
        switch (profile) {
            case "wide": return 0.90;
            case "standard": return 1.00;
            case "square": return 1.00;
            case "portrait": return 1.00;
            default: return 0.90;
        }
    }

    readonly property real systemLogoWidth: {
        switch (profile) {
            case "wide": return viewportWidth * 0.35;
            case "standard": return viewportWidth * 0.42;
            case "square": return viewportWidth * 0.50;
            case "portrait": return viewportWidth * 0.55;
            default: return viewportWidth * 0.35;
        }
    }

    readonly property real systemLogoHeight: {
        switch (profile) {
            case "wide": return viewportHeight * 0.15;
            case "standard": return viewportHeight * 0.17;
            case "square": return viewportHeight * 0.22;
            case "portrait": return viewportHeight * 0.22;
            default: return viewportHeight * 0.15;
        }
    }

    readonly property real systemLogoTopMargin: viewportHeight * 0.05

    readonly property real logoContainerWidth: viewportWidth * 0.40
    readonly property real logoContainerHeight: viewportHeight * 0.30

    readonly property real logoContainerTopMargin: {
        switch (profile) {
            case "wide": return px(10);
            case "standard": return viewportHeight * 0.05;
            case "square": return viewportHeight * 0.05;
            case "portrait": return viewportHeight * 0.05;
            default: return px(10);
        }
    }

    readonly property real logoContainerRightMargin: viewportWidth * 0.03

    readonly property real backgroundBlurRadius: {
        var base = viewportHeight * 0.074;
        switch (profile) {
            case "wide": return base;
            case "standard": return base * 1.15;
            case "square": return base * 1.10;
            case "portrait": return base * 1.00;
            default: return base;
        }
    }

    readonly property real gradientCenterX: px(9)
    readonly property real gradientCenterY: viewportHeight
    readonly property real backgroundGradientHeight: viewportHeight * 0.25

    readonly property real gameCardLoadingSpinnerSize: {
        switch (profile) {
            case "wide": return 50;
            case "standard": return 50;
            case "square": return 50;
            case "portrait": return 50;
            default: return 50;
        }
    }

    readonly property real gameCardFallbackFontFraction: 0.06
    readonly property real gameCardLogoOverlayFraction: 0.70

    readonly property real gameCardBlurRadiusActive: 0
    readonly property real gameCardBlurRadiusIdle: 40
    readonly property real gameCardBlurRadiusFinished: 10

    readonly property real gameCardButtonRadius: {
        switch (profile) {
            case "wide": return 20;
            case "standard": return 20;
            case "square": return 20;
            case "portrait": return 20;
            default: return 20;
        }
    }

    readonly property real gameCardButtonHeightFraction: 0.20
    readonly property real gameCardPlayButtonWidthFraction: 0.50
    readonly property real gameCardSideButtonWidthFraction: 0.15
    readonly property real gameCardSideButtonMarginFraction: 0.02
    readonly property real gameCardPlayButtonBottomMarginFraction: 0.05
    readonly property real gameCardPlayButtonTextFraction: 0.40

    readonly property real gameCardPlayTimeWidthFraction: 0.35
    readonly property real gameCardPlayTimeHeightFraction: 0.15
    readonly property real gameCardPlayTimeTopMarginFraction: 0.05
    readonly property real gameCardPlayTimeRightMarginFraction: 0.03
    readonly property real gameCardPlayTimeRadiusFactor: 0.20
    readonly property real gameCardPlayTimeRowSpacingFraction: 0.03
    readonly property real gameCardPlayTimeIconSizeFactor: 0.70
    readonly property real gameCardPlayTimeFontSizeFactor: 0.50

    readonly property real screensaverScreenshotScale: 1.20
    readonly property real screensaverScreenshotOversize: 1.05

    readonly property real screensaverPanelLeftMargin: viewportWidth * 0.015

    readonly property real screensaverPanelBottomMargin: {
        switch (profile) {
            case "wide": return viewportHeight * 0.055;
            case "standard": return viewportHeight * 0.055;
            case "square": return viewportHeight * 0.055;
            case "portrait": return viewportHeight * 0.055;
            default: return viewportHeight * 0.055;
        }
    }

    readonly property real screensaverPanelWidth: {
        switch (profile) {
            case "wide": return viewportWidth * 0.86;
            case "standard": return viewportWidth * 0.84;
            case "square": return viewportWidth * 0.90;
            case "portrait": return viewportWidth * 0.78;
            default: return viewportWidth * 0.80;
        }
    }

    readonly property real screensaverMetadataPillRadius: {
        switch (profile) {
            case "wide": return 18;
            case "standard": return 16;
            case "square": return 16;
            case "portrait": return 16;
            default: return 18;
        }
    }

    readonly property real screensaverMetadataPillPaddingH: {
        switch (profile) {
            case "wide": return 18;
            case "standard": return 16;
            case "square": return 14;
            case "portrait": return 14;
            default: return 18;
        }
    }

    readonly property real screensaverMetadataPillPaddingV: {
        switch (profile) {
            case "wide": return 8;
            case "standard": return 8;
            case "square": return 7;
            case "portrait": return 7;
            default: return 8;
        }
    }

    readonly property real screensaverLogoWidthFraction: {
        switch (profile) {
            case "wide": return 0.90;
            case "standard": return 0.90;
            case "square": return 0.90;
            case "portrait": return 0.90;
            default: return 0.90;
        }
    }

    readonly property real screensaverLogoMaxHeightFraction: {
        switch (profile) {
            case "wide": return 0.14;
            case "standard": return 0.16;
            case "square": return 0.18;
            case "portrait": return 0.18;
            default: return 0.14;
        }
    }

    readonly property real screensaverLogoBottomMargin: {
        switch (profile) {
            case "wide": return 18;
            case "standard": return 20;
            case "square": return 22;
            case "portrait": return 22;
            default: return 18;
        }
    }

    readonly property real screensaverMetadataFontSize: {
        switch (profile) {
            case "wide": return 22;
            case "standard": return 16;
            case "square": return 16;
            case "portrait": return 26;
            default: return 22;
        }
    }

    readonly property real screensaverMetadataRowSpacing: {
        switch (profile) {
            case "wide": return 8;
            case "standard": return 8;
            case "square": return 8;
            case "portrait": return 10;
            default: return 8;
        }
    }

    readonly property real updateCardWidth: {
        switch (profile) {
            case "wide": return viewportWidth * 0.34;
            case "standard": return viewportWidth * 0.46;
            case "square": return viewportWidth * 0.62;
            case "portrait": return viewportWidth * 0.86;
            default: return viewportWidth * 0.34;
        }
    }

    readonly property real updateCardMinWidth: px(340)
    readonly property real updateCardTopMargin: px(22)
    readonly property real updateCardPadding: px(22)
    readonly property real updateCardRadius: px(16)
    readonly property real updateCardBorderWidth: Math.max(1, px(2))
    readonly property real updateCardSpacing: px(12)

    readonly property real updateCardTitleFontSize: {
        switch (profile) {
            case "wide": return px(24);
            case "standard": return px(26);
            case "square": return px(32);
            case "portrait": return px(36);
            default: return px(24);
        }
    }

    readonly property real updateCardBodyFontSize: {
        switch (profile) {
            case "wide": return px(18);
            case "standard": return px(19);
            case "square": return px(24);
            case "portrait": return px(28);
            default: return px(18);
        }
    }

    readonly property real updateCardNotesFontSize: {
        switch (profile) {
            case "wide": return px(15);
            case "standard": return px(16);
            case "square": return px(20);
            case "portrait": return px(23);
            default: return px(15);
        }
    }

    readonly property real updateCardButtonHeight: {
        switch (profile) {
            case "wide": return px(42);
            case "standard": return px(46);
            case "square": return px(56);
            case "portrait": return px(62);
            default: return px(42);
        }
    }

    readonly property real updateCardButtonFontSize: {
        switch (profile) {
            case "wide": return px(15);
            case "standard": return px(16);
            case "square": return px(19);
            case "portrait": return px(21);
            default: return px(15);
        }
    }

    readonly property real updateCardButtonSpacing: px(10)
    readonly property real updateCardButtonMinWidth: px(110)

    readonly property int updateCardSlideDuration: {
        switch (profile) {
            case "portrait": return 420;
            default: return 380;
        }
    }

    readonly property real updateCardNotesMaxHeight: viewportHeight * 0.30
}
