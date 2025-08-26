function getFilterFunctions() {
    return {
        "All Games": function(game) { return true; },
        "Favorites": function(game) {
            return game && game.favorite === true;
        },
        "Last played": function(game) {
            return game && game.lastPlayed && game.lastPlayed.getTime() > 0;
        }
    };
}

function hasGamesWithFilter(collection, filterName) {
    if (filterName === "All Games") return true;

    var filterFunc = getFilterFunctions()[filterName];
    if (!filterFunc) return false;

    for (var i = 0; i < collection.games.count; i++) {
        if (filterFunc(collection.games.get(i))) {
            return true;
        }
    }
    return false;
}

function getSortedGames(games, filterName) {
    var filterFunc = getFilterFunctions()[filterName];
    if (!filterFunc) filterFunc = getFilterFunctions()["All Games"];
    var gamesArray = [];
    for (var i = 0; i < games.count; i++) {
        gamesArray.push(games.get(i));
    }

    var filteredGames = gamesArray.filter(filterFunc);
    switch(filterName) {
        case "Last played":
            filteredGames.sort(function(a, b) {
                return b.lastPlayed - a.lastPlayed;
            });
            break;
        case "Favorites":
            break;
        default:
            filteredGames.sort(function(a, b) {
                return a.title.localeCompare(b.title);
            });
    }

    return filteredGames;
}

function getNextFilterName(currentFilter) {
    var filters = Object.keys(getFilterFunctions());
    var currentIndex = filters.indexOf(currentFilter);
    var nextIndex = (currentIndex + 1) % filters.length;
    return filters[nextIndex];
}

function getAvailableFilters(collection) {
    var filters = ["All Games"];
    var hasFavorites = false;
    var hasLastPlayed = false;

    for (var i = 0; i < collection.games.count && (!hasFavorites || !hasLastPlayed); i++) {
        var game = collection.games.get(i);
        if (!hasFavorites && game.favorite) {
            hasFavorites = true;
        }
        if (!hasLastPlayed && game.lastPlayed && game.lastPlayed.getTime() > 0) {
            hasLastPlayed = true;
        }
    }

    if (hasFavorites) filters.push("Favorites");
    if (hasLastPlayed) filters.push("Last played");
    return filters;
}

function getNextFilter(currentFilter, availableFilters) {
    if (availableFilters.length === 0) return "All Games";
    var currentIndex = availableFilters.indexOf(currentFilter);
    var nextIndex = (currentIndex + 1) % availableFilters.length;
    return availableFilters[nextIndex];
}
