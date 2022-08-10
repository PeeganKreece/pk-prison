local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)


local function GetPlayer(source)
    local src = source
    if type(src) == 'number' then
        return src
    else
        return src
    end
end

local function ResetWorkTimer(k)
    local timer = math.random(900*1000, 1800*1000)
    if k then
        SetTimeout(timer, function()
            TriggerClientEvent('prison:client:setplant', -1, k, false)
        end)
    end
end

RegisterCommand('jail:addtime', function(source, args)
    local src = source
    local Player = tonumber(GetPlayer(src))
    local playerId = tonumber(args[1])
    local OtherPlayer = tonumber(GetPlayer(playerId))
    local distance = #(GetEntityCoords(GetPlayerPed(Player)) - GetEntityCoords(GetPlayerPed(OtherPlayer)))
    if distance < 5.0 then
    if Player == OtherPlayer then return end
        TriggerEvent('redemrp:getPlayerFromId', src, function(user)
            local job = user.getJob()
            for k, v in pairs(Config.Law) do
                if job == v then
                    TriggerClientEvent('prison:client:addtime', OtherPlayer, args[2], tostring(args[3]))
                end
            end
        end)
    end
end)

RegisterCommand('jail:checktime', function(source, args)
    local src = source
    local Player = tonumber(GetPlayer(src))
    local playerId = tonumber(args[1])
    local OtherPlayer = tonumber(GetPlayer(playerId))
    if Player == OtherPlayer then return end
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local job = user.getJob()
        for k, v in pairs(Config.Law) do
            if job == v then
                TriggerClientEvent('prison:client:checktime', OtherPlayer, false, Player)
            end
        end
    end)
end)

RegisterCommand('jail:release', function(source, args)
    local src = source
    local Player = tonumber(GetPlayer(src))
    local playerId = tonumber(args[1])
    local OtherPlayer = tonumber(GetPlayer(playerId))
    local distance = #(GetEntityCoords(GetPlayerPed(Player)) - GetEntityCoords(GetPlayerPed(OtherPlayer)))
    if distance < 5.0 then
        if Player == OtherPlayer then return end
        TriggerEvent('redemrp:getPlayerFromId', src, function(user)
            local job = user.getJob()
            for k, v in pairs(Config.Law) do
                if job == v then
                    TriggerEvent('prison:server:settime', OtherPlayer, 0)
                    TriggerClientEvent('prison:client:release', OtherPlayer, args[2])
                end
            end
        end)
    end
end)

RegisterServerEvent('prison:server:addcotton')
AddEventHandler('prison:server:addcotton', function()
    local src = source
    local ItemData = data.getItem(src, 'cotton')
    local amount = math.random(1, 2)
    ItemData.AddItem(amount)
    TriggerClientEvent("pNotify:SendNotification", src, {
        text = "<img src='nui://redemrp_inventory/html/items/cotton.png' height='40' width='40' style='float:left; margin-bottom:10px; margin-left:20px;' />You Got: Cotton<br>+"..amount,
        type = "success",
        timeout = math.random(2000, 3000),
        layout = "centerRight",
        queue = "right"
    })
end)

RegisterServerEvent('prison:server:sellcotton')
AddEventHandler('prison:server:sellcotton', function(amount)
    local src = source
    local ItemData = data.getItem(src, 'cotton')
    ItemData.RemoveItem(tonumber(amount))
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        user.addMoney(tonumber(amount))
    end)
end)

RegisterNetEvent('prison:server:addtime', function(time) -- Ran by jailee not the police officer
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local result = exports.oxmysql:fetchSync('SELECT time_jail FROM jail WHERE steam_id = ? AND char_id = ?', {identifier, charid})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                local call = v.time_jail + time
                exports.oxmysql:execute('UPDATE jail SET time_jail = ? WHERE steam_id = ? AND char_id = ?', {call, identifier, charid})
            end
        else
            exports.oxmysql:insert('INSERT INTO jail (steam_id, char_id, time_jail) VALUES (?, ? ,?);', {identifier, charid, time})
        end
    end)
end)

RegisterNetEvent('prison:server:settime', function(source, time) -- Ran by jailee not the police officer
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local result = exports.oxmysql:fetchSync('SELECT time_jail FROM jail WHERE steam_id = ? AND char_id = ?', {identifier, charid})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                local call = time
                exports.oxmysql:execute('UPDATE jail SET time_jail = ? WHERE steam_id = ? AND char_id = ?', {call, identifier, charid})
            end
        else
            exports.oxmysql:insert('INSERT INTO jail (steam_id, char_id, time_jail) VALUES (?, ? ,?);', {identifier, charid, time})
        end
    end)
end)

RegisterNetEvent('prison:server:setplant', function(k)
    ResetWorkTimer(k)
    TriggerClientEvent('prison:client:setplant', -1, k, true)
end)

RegisterNetEvent('prison:server:fallback', function()
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local result = exports.oxmysql:fetchSync('SELECT * FROM jail WHERE steam_id = ? AND char_id = ?', {identifier, charid})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                if tonumber(v.time_jail) >= 0 then
                    TriggerClientEvent('prison:client:startprison', src)
                end
            end
        end
    end)
end)

RegisterNetEvent('prison:server:gettime', function(command, player)
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local result = exports.oxmysql:fetchSync('SELECT * FROM jail WHERE steam_id = ? AND char_id = ?', {identifier, charid})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                if command then
                    TriggerClientEvent('prison:client:checktime', player, true, _, v.time_jail)
                else
                    TriggerClientEvent('prison:client:gettime', src, true, v.time_jail)
                end
            end
        end
    end)
end)