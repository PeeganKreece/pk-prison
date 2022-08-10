local inprison = false
local menu_open
local animation
local spawned
local current_veh
local sentence = 0

local function OutfitStripes(ped)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x9925C067, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x485EE834, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x18729F39, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3107499B, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3C1A74CD, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3F1F01E5, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3F7F3587, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x49C89D9B, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x4A73515C, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x514ADCEA, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x5FC29285, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x79D7DF96, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x7A96FACA, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x877A2CF7, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x9B2C8B89, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xA6D134C6, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xE06D30CE, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xAF14310B, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x72E6EF74, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xEABE0032, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xECC8B25A, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xF8016BCA, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x777EC6EF, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x91CE9B20, true, true, true)
    Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x7505EF42, true, true, true)
    if IsPedMale(ped) then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x5BA76CCF, true, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0xB8A78F00, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xA2926F9B, true, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x216612F0, true, true, true)
    else
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x6AB27695, true, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x75BC0CF5, true, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x14683CDF, true, true, true)
    end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
		Citizen.InvokeNative(0xADA9255D, 6);
	DisplayText(str, x, y)
end

local prisontalkprompt
local PrisonTalkPromptGroup = GetRandomIntInRange(0, 0xffffff)
function PrisonTalkSessionPrompt()
    prisontalkprompt = PromptRegisterBegin()
    PromptSetControlAction(prisontalkprompt, 0x760A9C6F)
    PromptSetText(prisontalkprompt, CreateVarString(10, 'LITERAL_STRING', 'Interact'))
    PromptSetEnabled(prisontalkprompt, true)
    PromptSetVisible(prisontalkprompt, true)
    PromptSetHoldMode(prisontalkprompt, true)
    PromptSetGroup(prisontalkprompt, PrisonTalkPromptGroup)
    PromptRegisterEnd(prisontalkprompt)
end

local boattalkprompt
local BoatTalkPromptGroup = GetRandomIntInRange(0, 0xffffff)
function BoatTalkSessionPrompt()
    boattalkprompt = PromptRegisterBegin()
    PromptSetControlAction(boattalkprompt, 0x760A9C6F)
    PromptSetText(boattalkprompt, CreateVarString(10, 'LITERAL_STRING', 'Interact'))
    PromptSetEnabled(boattalkprompt, true)
    PromptSetVisible(boattalkprompt, true)
    PromptSetHoldMode(boattalkprompt, true)
    PromptSetGroup(boattalkprompt, BoatTalkPromptGroup)
    PromptRegisterEnd(boattalkprompt)
end

local prisonpickprompt
local PrisonPickPromptGroup = GetRandomIntInRange(0, 0xffffff)
function PrisonPickSessionPrompt()
    prisonpickprompt = PromptRegisterBegin()
    PromptSetControlAction(prisonpickprompt, 0x760A9C6F)
    PromptSetText(prisonpickprompt, CreateVarString(10, 'LITERAL_STRING', 'Pick'))
    PromptSetEnabled(prisonpickprompt, true)
    PromptSetVisible(prisonpickprompt, true)
    PromptSetStandardMode(prisonpickprompt, true)
    PromptSetGroup(prisonpickprompt, PrisonPickPromptGroup)
    PromptRegisterEnd(prisonpickprompt)
end

local function PrisonTimeLoop(toggle)
    local ped = PlayerPedId()
    local passed = false
    inprison = toggle
    CreateThread(function()
        while inprison do
            Wait(1500)
            local sleep = 1
            local perimeter = #(GetEntityCoords(ped) - Config.Perimeter)
            local perimeter2 = #(GetEntityCoords(ped) - Config.Perimeter2)
            local perimeter3 = #(GetEntityCoords(ped) - Config.Perimeter3)
            local perimeter4 = #(GetEntityCoords(ped) - Config.Perimeter4)
            if passed then
                if perimeter < 170.0 or perimeter2 < 180.0 or perimeter3 < 150.0 or perimeter4 < 30.0 then
                    SetTimeout(1500, function()
                        OutfitStripes(ped)
                    end)
                else
                    SisikaTravelAnimation(true)
                end
            else
                if perimeter < 170.0 or perimeter2 < 180.0 or perimeter3 < 150.0 or perimeter4 < 30.0 then
                    passed = true
                end
            end
            Wait(sleep)
        end
    end)
end

local function LowerTimeLoop(toggle)
    inprison = toggle
    TriggerEvent('prison:client:gettime')
    CreateThread(function()
        while inprison do
            Wait(60000)
            TriggerServerEvent('prison:server:addtime', -1)
            SetTimeout(350, function()
                TriggerEvent('prison:client:gettime')
            end)
        end
    end)
end

function SisikaTravelAnimation(quick)
    if animation then return end
    local ped = PlayerPedId()
    if quick then
        animation = true
        DoScreenFadeOut(3000)
        Wait(4000)
        SetEntityVisible(ped, false)
        SetEntityCoords(ped, Config.PrisonTeleport)
        SetEntityHeading(ped, Config.PrisonTeleportHeading)
        SetEntityVisible(ped, true)
        DoScreenFadeIn(3000)
        animation = false
    else
        animation = true
        ExecuteCommand('hud')
        DoScreenFadeOut(3000)
        FreezeEntityPosition(ped, true)
        Wait(3000)
        Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'Sisika Penitentiary', 'Length of Sentence: '..sentence..' Months', 'You can do work to lessen your sentence.')
        Wait(4000)
        SetEntityVisible(ped, false)
        SetEntityCoords(ped, Config.PrisonTeleport)
        SetEntityHeading(ped, Config.PrisonTeleportHeading)
        OutfitStripes(ped)
        ShutdownLoadingScreen()
        Wait(8500)
        SetEntityVisible(ped, true)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(3000)
        PrisonTimeLoop(true)
        LowerTimeLoop(true)
        PrisonNPCInteraction()
        ExecuteCommand('hud')
        animation = false
    end
end

local function PickAnimation()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    RequestAnimDict("mech_pickup@plant@yarrow")
    while not HasAnimDictLoaded("mech_pickup@plant@yarrow") do
        Wait(100)
    end
    TaskPlayAnim(ped, "mech_pickup@plant@yarrow", "enter_lf", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    Wait(800)
    TaskPlayAnim(ped, "mech_pickup@plant@yarrow", "base", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    Wait(3000)
    FreezeEntityPosition(ped, false)
end

local function StartPrisonWork(working)
    TriggerEvent("pNotify:SendNotification", {
        text = "You are now able to work in prison.",
        type = "success",
        timeout = math.random(2000, 3000),
        layout = "centerRight",
        queue = "right"
    })
    while working and inprison do
        local sleep = 150
        for k,_ in pairs(Config.WorkPick) do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(pos - Config.WorkPick[k][1].xyz)
            if dist < 1.0 then
                sleep = 1
                if not Config.WorkPick[k].picked then
                    local PrisonPickGroupName = CreateVarString(10, 'LITERAL_STRING', 'Cotton')
                    PromptSetActiveGroupThisFrame(PrisonPickPromptGroup, PrisonPickGroupName)
                    if IsControlJustPressed(0, 0x760A9C6F) then
                        TriggerServerEvent('prison:server:setplant', k)
                        Config.WorkPick[k].picked = true
                        PickAnimation()
                        SetTimeout(3500, function()
                            TriggerServerEvent('prison:server:addcotton')
                        end)
                    end
                end
            end
        end
        Wait(sleep)
    end
end

local function SpawnPrisonBoat(coords)
    local model = GetHashKey('boatsteam02x')
    if(current_veh)then
        DeleteEntity(current_veh)
        current_veh = nil
    end
    RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
    TriggerServerEvent("wrp_scripts:WaitNewBoat", true)
    Wait(550)
    current_veh = CreateVehicle(model, coords, coords.w, 1, 1)
    while not DoesEntityExist(current_veh) do
        Wait(0)
    end
    TriggerServerEvent("wrp_scripts:AddWhitelistedBoat", NetworkGetNetworkIdFromEntity(current_veh))
    Wait(550)
    TriggerServerEvent("wrp_scripts:WaitNewBoat", false)
end

local function DeletePrisonBoat()
    if(current_veh)then
        DeleteEntity(current_veh)
        current_veh = nil
    end
end

local function SellCotton()
    local itemData = exports['redemrp_inventory']:GetItem('cotton')
    if itemData.ItemAmount ~= 0 then
        TriggerServerEvent('prison:server:sellcotton', itemData.ItemAmount)
    end
end

local function OpenFoodShop()
    TriggerServerEvent("rdr_shops:RequireAccess", 'sisikashop')
end

local function LeavePrison(teleport)
    print(teleport)
    if inprison then
        if teleport == 'true' then
            local ped = PlayerPedId()
            local coords = Config.PrisonTeleportExit
            inprison = false
            ExecuteCommand('hud')
            PrisonTimeLoop(false)
            LowerTimeLoop(false)
            DoScreenFadeOut(3000)
            FreezeEntityPosition(ped, true)
            Wait(3000)
            Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'Freedom')
            Wait(4000)
            SetEntityVisible(ped, false)
            SetEntityCoords(ped, coords)
            SetEntityHeading(ped, coords.w)
            ShutdownLoadingScreen()
            Wait(8500)
            SetEntityVisible(ped, true)
            FreezeEntityPosition(ped, false)
            DoScreenFadeIn(3000)
            ExecuteCommand('hud')
        else
            inprison = false
            PrisonTimeLoop(false)
            LowerTimeLoop(false)
        end
    end
end

local function PrisonNPC()
    TriggerEvent('wrp-dialog:RegisterDialog', 'MainPrisonNPC', {
        ['coords'] = vector3(Config.MainNPC.x, Config.MainNPC.y, Config.MainNPC.z),
        ['dialog'] = {
            ['PedName'] = 'Officer Joe',
            ['PedText'] = "How's it going, can I help you?",
            ['ModelsToSearch'] = {`s_m_m_skpguard_01`},
            ["1"] = {
                label = "I want to do some work.",
                type = 'finish',
                value = "work"
            },
            ["2"] = {
                label = "I want to turn in my cotton.",
                type = 'finish',
                value = "cotton"
            },
            ["3"] = {
                label = "I want to buy some food.",
                type = 'finish',
                value = "food"
            },
            ["4"] = {
                label = "I want to check my sentence.",
                type = 'action',
                subdialog = {
                    ['PedName'] = 'Officer Joe',
                    ['PedText'] = "You have "..sentence.." months left.",
                    ["1"] = {
                        label = "Nevermind.",
                        type = 'back'
                    }
                }
            },
            ["5"] = {
                label = "See you later.",
                type = 'close'
            }
        },
        onTriggered = function(value)
            if value == "work" then
                StartPrisonWork(true)
                menu_open = false
            elseif value == "cotton" then
                SellCotton()
                menu_open = false
            elseif value == "food" then
                OpenFoodShop()
                menu_open = false
            end
        end,
        onClose = function()
            menu_open = false
        end
    })
end

local function PrisonLeaveNPC()
    TriggerEvent('wrp-dialog:RegisterDialog', 'MainPrisonNPC', {
        ['coords'] = vector3(Config.MainNPC.x, Config.MainNPC.y, Config.MainNPC.z),
        ['dialog'] = {
            ['PedName'] = 'Officer Joe',
            ['PedText'] = "How's it going, can I help you?",
            ['ModelsToSearch'] = {`s_m_m_skpguard_01`},
            ["1"] = {
                label = "I want to do some work.",
                type = 'finish',
                value = "work"
            },
            ["2"] = {
                label = "I want to turn in my cotton.",
                type = 'finish',
                value = "cotton"
            },
            ["3"] = {
                label = "I want to buy some food.",
                type = 'finish',
                value = "food"
            },
            ["4"] = {
                label = "I want to check my sentence.",
                type = 'action',
                subdialog = {
                    ['PedName'] = 'Officer Joe',
                    ['PedText'] = "You have "..sentence.." months left",
                    ["1"] = {
                        label = 'I would like to leave now.',
                        type = 'finish',
                        value = "leave"
                    },
                    ["2"] = {
                        label = "Nevermind.",
                        type = 'back'
                    }
                }
            },
            ["5"] = {
                label = "See you later.",
                type = 'close'
            }
        },
        onTriggered = function(value)
            if value == "work" then
                StartPrisonWork(true)
                menu_open = false
            elseif value == "cotton" then
                SellCotton()
                menu_open = false
            elseif value == "food" then
                OpenFoodShop()
                menu_open = false
            elseif value == "leave" then
                LeavePrison(true)
                menu_open = false
            end
        end,
        onClose = function()
            menu_open = false
        end
    })
end

local function BoatNPC()
    TriggerEvent('wrp-dialog:RegisterDialog', 'BoatNPC', {
        ['coords'] = vector3(Config.BoatNPC.x, Config.BoatNPC.y, Config.BoatNPC.z),
        ['dialog'] = {
            ['PedName'] = 'Officer North',
            ['PedText'] = "How's it going, can I help you?",
            ['ModelsToSearch'] = {`s_m_m_skpguard_01`},
            ["1"] = {
                label = "I need a prison boat.",
                type = 'finish',
                value = "spawn"
            },
            ["3"] = {
                label = "I want to get rid of my boat.",
                type = 'finish',
                value = "delete"
            },
            ["5"] = {
                label = "See you later.",
                type = 'close'
            }
        },
        onTriggered = function(value)
            if value == "spawn" then
                SpawnPrisonBoat(Config.BoatSpawn)
                menu_open = false
            elseif value == "delete" then
                DeletePrisonBoat()
                menu_open = false
            end
        end,
        onClose = function()
            menu_open = false
        end
    })
end

local function PrisonBoatNPC()
    TriggerEvent('wrp-dialog:RegisterDialog', 'PrisonBoatNPC', {
        ['coords'] = vector3(Config.PrisonBoatNPC.x, Config.PrisonBoatNPC.y, Config.PrisonBoatNPC.z),
        ['dialog'] = {
            ['PedName'] = 'Officer North',
            ['PedText'] = "How's it going, can I help you?",
            ['ModelsToSearch'] = {`s_m_m_skpguard_01`},
            ["1"] = {
                label = "I need a prison boat.",
                type = 'finish',
                value = "spawn"
            },
            ["3"] = {
                label = "I want to get rid of my boat.",
                type = 'finish',
                value = "delete"
            },
            ["5"] = {
                label = "See you later.",
                type = 'close'
            }
        },
        onTriggered = function(value)
            if value == "spawn" then
                SpawnPrisonBoat(Config.PrisonBoatSpawn)
                menu_open = false
            elseif value == "delete" then
                DeletePrisonBoat()
                menu_open = false
            end
        end,
        onClose = function()
            menu_open = false
        end
    })
end

function PrisonNPCInteraction()
    CreateThread(function()
        while inprison do
            local sleep = 150
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local pedcoords = vector3(Config.MainNPC.x, Config.MainNPC.y, Config.MainNPC.z)
            local dist = #(pedcoords - coords)
            if (dist < 1.7) then
                sleep = 1
                local PrisonTalkGroupName = CreateVarString(10, 'LITERAL_STRING', 'Sisika Guard')
                PromptSetActiveGroupThisFrame(PrisonTalkPromptGroup, PrisonTalkGroupName)
                if PromptHasHoldModeCompleted(prisontalkprompt) then
                    Wait(350)
                    if not menu_open then
                        menu_open = true
                    end
                    if sentence <= 0 then
                        PrisonLeaveNPC()
                    else
                        PrisonNPC()
                    end
                    TriggerEvent('wrp_dialogue:OpenDialogByKey', 'MainPrisonNPC')
                end
            end
            Wait(sleep)
        end
    end)
end

local function StartCheckLoop()
    CreateThread(function()
        Wait(15000)
        while true do
            local sleep = 1500
            if not inprison then
                TriggerEvent('prison:client:gettime')
                TriggerServerEvent('prison:server:fallback')
            end
            Wait(sleep)
        end
    end)
end

CreateThread(function()
    while true do
        local sleep = 150
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local pedcoords = vector3(Config.BoatNPC.x, Config.BoatNPC.y, Config.BoatNPC.z)
        local dist = #(pedcoords - coords)
        if (dist < 1.7) then
            sleep = 1
            local BoatTalkGroupName = CreateVarString(10, 'LITERAL_STRING', 'Sisika Guard')
            PromptSetActiveGroupThisFrame(BoatTalkPromptGroup, BoatTalkGroupName)
            if PromptHasHoldModeCompleted(boattalkprompt) then
                Wait(350)
                if not menu_open then
                    menu_open = true
                end
                BoatNPC()
                TriggerEvent('wrp_dialogue:OpenDialogByKey', 'BoatNPC')
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 150
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local pedcoords = vector3(Config.PrisonBoatNPC.x, Config.PrisonBoatNPC.y, Config.PrisonBoatNPC.z)
        local dist = #(pedcoords - coords)
        if (dist < 1.7) then
            sleep = 1
            local BoatTalkGroupName = CreateVarString(10, 'LITERAL_STRING', 'Sisika Guard')
            PromptSetActiveGroupThisFrame(BoatTalkPromptGroup, BoatTalkGroupName)
            if PromptHasHoldModeCompleted(boattalkprompt) then
                Wait(350)
                if not menu_open then
                    menu_open = true
                end
                PrisonBoatNPC()
                TriggerEvent('wrp_dialogue:OpenDialogByKey', 'PrisonBoatNPC')
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    PrisonPickSessionPrompt()
    PrisonTalkSessionPrompt()
    BoatTalkSessionPrompt()
    while true do
        local sleep = 15
        exports['wrp_utils']:AddPed({
            coords = vector3(Config.MainNPC.x, Config.MainNPC.y, Config.MainNPC.z),
            heading = Config.MainNPC.w,
            model = `s_m_m_skpguard_01`,
            key = 'MainPrisonNPC',
        })
        exports['wrp_utils']:AddPed({
            coords = vector3(Config.BoatNPC.x, Config.BoatNPC.y, Config.BoatNPC.z),
            heading = Config.BoatNPC.w,
            model = `s_m_m_skpguard_01`,
            key = 'BoatNPC',
        })
        exports['wrp_utils']:AddPed({
            coords = vector3(Config.PrisonBoatNPC.x, Config.PrisonBoatNPC.y, Config.PrisonBoatNPC.z),
            heading = Config.PrisonBoatNPC.w,
            model = `s_m_m_skpguard_01`,
            key = 'PrisonBoatNPC',
        })
        Wait(sleep)
    end
end)

AddEventHandler('playerSpawned', function()
    if spawned then return end
    spawned = true
    Wait(1500)
    TriggerEvent('prison:client:gettime')
    TriggerServerEvent('prison:server:fallback')
    StartCheckLoop()
end)

RegisterNetEvent('prison:client:gettime', function(returning, time)
    if returning then
        sentence = tonumber(time)
    else
        TriggerServerEvent('prison:server:gettime')
    end
end)

RegisterNetEvent('prison:client:setplant', function(k, toggle)
    Config.WorkPick[k].picked = toggle
end)

RegisterNetEvent('prison:client:addtime', function(time, toggle) -- Ran by jailee not the police officer
    if toggle == 'true' then
        TriggerServerEvent('prison:server:addtime', time)
        SetTimeout(150, function()
            TriggerEvent('prison:client:gettime')
        end)
        SisikaTravelAnimation(false)
    else
        TriggerServerEvent('prison:server:addtime', time)
        SetTimeout(150, function()
            TriggerEvent('prison:client:gettime')
        end)
        OutfitStripes(PlayerPedId())
        PrisonTimeLoop(true)
        LowerTimeLoop(true)
        PrisonNPCInteraction()
    end
end)

RegisterNetEvent('prison:client:checktime', function(returning, player, time)
    if returning then
        TriggerEvent("pNotify:SendNotification", {
            text = "This person has "..time.." months left.",
            type = "success",
            timeout = 6000,
            layout = "centerRight",
            queue = "right"
        })
    else
        TriggerServerEvent('prison:server:gettime', true, player)
    end
end)

RegisterNetEvent('prison:client:release', function(teleport)
    LeavePrison(teleport)
end)

RegisterNetEvent('prison:client:startprison', function()
    SisikaTravelAnimation(false)
end)

TriggerEvent('chat:addSuggestion', '/jail:addtime', 'Add time to someone\'s sentence', {
    { name="id", help="Server ID" },
    { name="sentence", help="Sentence in minutes" },
    { name="teleport", help="Whether or not to teleport prisoner {true/false}" }
})

TriggerEvent('chat:addSuggestion', '/jail:checktime', 'Check someone\'s sentence', {
    { name="id", help="Server ID" }
})

TriggerEvent('chat:addSuggestion', '/jail:release', 'Release someone from prison', {
    { name="id", help="Server ID" },
    { name="teleport", help="Whether or not to teleport prisoner {true/false}" }
})

