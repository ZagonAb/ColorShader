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
        return "Unknown developer";
    }
    return developer;
}

function getPlayersContent(players) {
    if (players > 1) {
        return {
            count: players,
            source: "assets/icons/players.png"
        };
    }
    return null;
}

function getReleaseYearText(year) {
    if (year === 0 || !year) {
        return "Unknown release year";
    }
    return year.toString();
}

function formatGameGenre(genre) {
    if (!genre || genre.trim() === "") {
        return "Unknown genre";
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

// Añade al final de utils.js
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
        return lastPlayed.toLocaleDateString();
    }
}



