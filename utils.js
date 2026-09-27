function getColor(system) {
    return colorMapping[system] || colorMapping["default"] || "#000000";
}

function getSystemMetadata(shortName) {
    for (var i = 0; i < gameSystems.length; i++) {
        if (gameSystems[i].shortName === shortName) {
            return gameSystems[i];
        }
    }
    return null;
}

function formatGameDescription(description) {
    if (!description || description.trim() === "") {
        return "No description available, use game scraper to get proper information...";
    }
    return description;
}

function formatGameDeveloper(developer) {
    if (!developer || developer.trim() === "") {
        return "Unknown";
    }
    return developer;
}

function getPlayersContent(players) {
    if (players > 1) {
        const displayCount = Math.min(players, 4);
        const showEllipsis = players > 4;

        return {
            count: displayCount,
            source: "assets/icons/players.png",
            showEllipsis: showEllipsis,
            totalPlayers: players
        };
    }
    return null;
}

function getReleaseYearText(year) {
    if (year === 0 || !year) {
        return "Unknown";
    }
    return year.toString();
}

function formatGameGenre(genre) {
    if (!genre || genre.trim() === "") {
        return "Unknown";
    }

    const firstGenre = genre.split(/[\/,\-]/)[0].trim();
    const maxLength = 20;
    return firstGenre.length <= maxLength
    ? firstGenre
    : firstGenre.substring(0, maxLength - 3) + "...";
}

function displayRating(rating) {
    const fullStars = Math.floor(rating * 5);
    const hasHalfStar = (rating * 5) % 1 !== 0;

    let ratingDisplay = "";
    for (let i = 0; i < fullStars; i++) {
        ratingDisplay += "assets/icons/star1.png ";
    }
    if (hasHalfStar) {
        ratingDisplay += "assets/icons/star05.png ";
    }
    for (let i = 0; i < 5 - fullStars - (hasHalfStar ? 1 : 0); i++) {
        ratingDisplay += "assets/icons/star0.png ";
    }

    return ratingDisplay.trim();
}

function getBatteryIcon(batteryPercent, isCharging) {
    if (isNaN(batteryPercent) || isCharging) {
        return "assets/icons/charging.png";
    } else {
        const percent = batteryPercent * 100;
        if (percent <= 20) {
            return "assets/icons/10.png";
        } else if (percent <= 40) {
            return "assets/icons/25.png";
        } else if (percent <= 60) {
            return "assets/icons/50.png";
        } else if (percent <= 80) {
            return "assets/icons/75.png";
        } else if (percent <= 90) {
            return "assets/icons/90.png";
        } else {
            return "assets/icons/95.png";
        }
    }
}

function getRandomScreenshots(collections) {
    var screenshots = [];
    for (var i = 0; i < collections.count; i++) {
        var games = collections.get(i).games;
        for (var j = 0; j < games.count; j++) {
            var game = games.get(j);
            if (game.assets.screenshot) {
                screenshots.push(game.assets.screenshot);
            }
        }
    }
    return screenshots.sort(() => Math.random() - 0.5);
}

function getGameFromScreenshot(collections, screenshot) {
    for (var i = 0; i < collections.count; i++) {
        var games = collections.get(i).games;
        for (var j = 0; j < games.count; j++) {
            var game = games.get(j);
            if (game.assets.screenshot === screenshot) {
                return game;
            }
        }
    }
    return null;
}

function updateTextWidth() {
    var plainText = systemInfoText.text.replace(/<[^>]*>/g, '');
    var approximateWidth = plainText.length * (systemInfoText.font.pixelSize * 0.65);
    collectionInfo.textWidth = approximateWidth;
}

function formatLastPlayedDate(lastPlayed) {
    if (!lastPlayed || lastPlayed.getTime() === 0) {
        return "Never played";
    }

    var now = new Date();
    var diff = now - lastPlayed;
    var diffDays = Math.floor(diff / (1000 * 60 * 60 * 24));

    if (diffDays === 0) {
        return "Today";
    } else if (diffDays === 1) {
        return "Yesterday";
    } else if (diffDays < 7) {
        return diffDays + " days ago";
    } else if (diffDays < 30) {
        var weeks = Math.floor(diffDays / 7);
        return weeks + (weeks === 1 ? " week ago" : " weeks ago");
    } else {
        var day = lastPlayed.getDate();
        var month = lastPlayed.getMonth() + 1;
        var year = lastPlayed.getFullYear();
        return day + "/" + month + "/" + year;
    }
}

function formatPlayTime(playTimeSeconds) {
    if (!playTimeSeconds || playTimeSeconds < 60) {
        return null;
    }

    var hours = Math.floor(playTimeSeconds / 3600);
    var minutes = Math.floor((playTimeSeconds % 3600) / 60);

    if (hours > 0) {
        return ("00" + hours).slice(-2) + ":" + ("00" + minutes).slice(-2) + "h";
    } else {
        return ("00" + minutes).slice(-2) + "m";
    }
}

function shouldShowPlayTime(playTimeSeconds) {
    return playTimeSeconds && playTimeSeconds >= 60;
}

function getRandomGames(collections) {
    var games = [];
    for (var i = 0; i < collections.count; i++) {
        var gamesList = collections.get(i).games;
        for (var j = 0; j < gamesList.count; j++) {
            var game = gamesList.get(j);
            if (game.assets && (game.assets.background || game.assets.screenshot)) {
                games.push(game);
            }
        }
    }
    return games.sort(function() { return Math.random() - 0.5; });
}

function pad2(n) {
    return (n < 10 ? "0" : "") + n;
}

function formatPlayTimeLong(seconds) {
    if (!seconds || seconds < 0) return "00:00:00";
    if (seconds < 60) {
        var h = Math.floor(seconds / 3600);
        var m = Math.floor((seconds % 3600) / 60);
        var s = Math.floor(seconds % 60);
        return pad2(h) + ":" + pad2(m) + ":" + pad2(s);
    }
    if (seconds < 3600) {
        var m = Math.floor(seconds / 60);
        return m + (m === 1 ? " minute" : " minutes");
    }
    var hours = seconds / 3600;
    var rounded = hours.toFixed(1);
    if (rounded.slice(-2) === ".0") rounded = rounded.slice(0, -2);
    return rounded + (rounded === "1" ? " hour" : " hours");
}

function formatLastPlayedShort(date) {
    if (!date || isNaN(date.getTime()) || date.getTime() === 0) return "Never";
    var d = date.getDate();
    var m = date.getMonth() + 1;
    var y = date.getFullYear() % 100;
    return d + "/" + m + "/" + y;
}

function getRatingStars(rating) {
    var r = Math.round((rating || 0) * 5);
    var s = "";
    for (var i = 0; i < 5; i++) {
        s += (i < r) ? "★" : "☆";
    }
    return s;
}
