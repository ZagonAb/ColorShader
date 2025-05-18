
function getFilterFunctions() {
    return {
        "All Games": function(game) { return true; },
        "Favorites": function(game) { return game && game.favorite; },
        "Last Played": function(game) { return game && game.lastPlayed && game.lastPlayed.getTime() > 0; }
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

    // Convertir el modelo a array para poder ordenarlo
    var gamesArray = [];
    for (var i = 0; i < games.count; i++) {
        gamesArray.push(games.get(i));
    }

    // Filtrar primero
    var filteredGames = gamesArray.filter(filterFunc);

    // Luego ordenar según el filtro
    switch(filterName) {
        case "Last Played":
            filteredGames.sort(function(a, b) {
                return b.lastPlayed - a.lastPlayed; // Más reciente primero
            });
            break;
        case "Favorites":
            // Los favoritos ya están al principio por cómo funciona filter
            break;
        default:
            // Orden por defecto (por título)
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

    // Verificar si la colección tiene juegos favoritos o jugados recientemente
    for (var i = 0; i < collection.games.count; i++) {
        var game = collection.games.get(i);
        if (!hasFavorites && game.favorite) {
            hasFavorites = true;
        }
        if (!hasLastPlayed && game.lastPlayed && game.lastPlayed.getTime() > 0) {
            hasLastPlayed = true;
        }
        // Si ya encontramos ambos, no necesitamos seguir buscando
        if (hasFavorites && hasLastPlayed) break;
    }

    if (hasFavorites) filters.push("Favorites");
    if (hasLastPlayed) filters.push("Last Played");

    return filters;
}

function getNextFilter(currentFilter, availableFilters) {
    if (availableFilters.length === 0) return "All Games";
    var currentIndex = availableFilters.indexOf(currentFilter);
    var nextIndex = (currentIndex + 1) % availableFilters.length;
    return availableFilters[nextIndex];
}
