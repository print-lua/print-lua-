local DOORS_PLACE_IDS = {
    [6516141723] = true,
    [6839171747] = true
}

if DOORS_PLACE_IDS[game.PlaceId] then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/doors.luau"))()
else
    warn("[Loader] Incorrect game. This script is intended for DOORS PS 67.")
end
