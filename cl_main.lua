-- ## FUNCTIONS ## --
function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #players, 1 do
        local tgt = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance, playerid, tgt1
end

-- ## EVENTS ## --
RegisterNetEvent('prison:client:addtime', function(playerId)
    local closestPlayer, closestDistance, playerid = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        if playerid ~= GetPlayerServerId(GetPlayerIndex()) then
            print('worked')
        end
    end
end)

TriggerEvent('chat:addSuggestion', '/jail:addtime', 'Add time to someone\'s sentence', {
    { name="id", help="Server ID" }
})