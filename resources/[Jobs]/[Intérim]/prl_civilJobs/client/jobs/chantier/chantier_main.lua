

local sync = false
local WorkerChillPos = {}
local workzone = {}
local WorkerWorkingPos = {}
local Heading
local pedHash
AuTravailleChantier = nil
local ArgentMin
local ArgentMax

RegisterNetEvent("RED_JOBS:ChantierAntiDump")
AddEventHandler("RED_JOBS:ChantierAntiDump", function(_config, _workzone, _WorkerChillPos, _WorkerWorkingPos)
    Heading = _config.Heading
    pedHash = _config.pedHash
    AuTravailleChantier = _config.AuTravailleChantier
    ArgentMin = _config.ArgentMin
    ArgentMax = _config.ArgentMax


    workzone = _workzone
    WorkerChillPos = _WorkerChillPos
    WorkerWorkingPos = _WorkerWorkingPos
    sync = true
end)




Citizen.CreateThread(function()
    while not sync do Wait(100) end
    LoadModel(pedHash)
    local ped = CreatePed(2, GetHashKey(pedHash), zone.Chantier, Heading, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, 1, 1)
    SetBlockingOfNonTemporaryEvents(ped, 1)


    for _,v in pairs(WorkerChillPos) do
        local ped = CreatePed(2, GetHashKey(pedHash), v.pos, v.Heading, 0, 0)
        DecorSetInt(ped, "Yay", 5431)
        FreezeEntityPosition(ped, 1)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
        SetEntityInvincible(ped, true)
        SetEntityAsMissionEntity(ped, 1, 1)
        SetBlockingOfNonTemporaryEvents(ped, 1)
    end

    for _,v in pairs(WorkerWorkingPos) do
        local ped = CreatePed(2, GetHashKey(pedHash), v.pos, v.Heading, 0, 0)
        DecorSetInt(ped, "Yay", 5431)
        FreezeEntityPosition(ped, 1)
        TaskStartScenarioInPlace(ped, v.scenario, 0, true)
        SetEntityInvincible(ped, true)
        SetEntityAsMissionEntity(ped, 1, 1)
        SetBlockingOfNonTemporaryEvents(ped, 1)
    end
end)






function StartTravailleChantier()
    while not sync do Wait(100) end
    while AuTravailleChantier do
        RageUI.Popup({
            message = "Un travaille t'a été attribué, dirige toi sur place !",
        })
        Wait(1)
        local random = math.random(1,#workzone)
        local count = 1
        for k,v in pairs(workzone) do
            count = count + 1
            if count == random and AuTravailleChantier then
                local EnAction = false
                local pPed = GetPlayerPed(-1)
                local pCoords = GetEntityCoords(pPed)
                local dstToMarker = GetDistanceBetweenCoords(v.pos, pCoords, true)
                local blip = AddBlipForCoord(v.pos)
                SetBlipSprite(blip, 402)
                SetBlipColour(blip, 5)
                SetBlipScale(blip, 0.65)
                while not EnAction and AuTravailleChantier do
                    Citizen.Wait(1)
                    pCoords = GetEntityCoords(pPed)
                    dstToMarker = GetDistanceBetweenCoords(v.pos, pCoords, true)
                    DrawMarker(32, v.pos.x, v.pos.y, v.pos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.Chantier, true)
                    if distance <= 3.0 then
                        HelpMsg("Appuyer sur ~b~E~w~ pour parler avec la personne.")
                        if IsControlJustPressed(1, 51) and distance <= 3.0 then
                            RageUI.Visible(RMenu:Get('Chantier', 'main'), not RageUI.Visible(RMenu:Get('Chantier', 'main')))
                            AuTravailleChantier = false
                            CreateCamera()
                        end
                    end
                    if dstToMarker <= 3.0 and AuTravailleChantier then
                        HelpMsg("Appuyer sur ~b~E~w~ pour travailler")
                        if IsControlJustPressed(1, 51) and dstToMarker <= 3.0 then
                            RemoveBlip(blip)
                            EnAction = true
                            SetEntityCoords(pPed, v.pos, 0.0, 0.0, 0.0, 0)
                            SetEntityHeading(pPed, v.Heading)
                            TaskStartScenarioInPlace(pPed, v.scenario, 0, true)
                            exports["rs_prog"]:AfficherProgressbar(10.0)
                            Wait(10000)
                            exports["rs_prog"]:CacherProgressbar() 
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            local money = math.random(ArgentMin, ArgentMax)
                            TriggerServerEvent("ori_jobs:pay", money)
                            RageUI.Popup({
                                message = "Bien ! Tu à été payé ~g~"..money.."$ ~w~pour ton travaille, continue comme ça !",
                            })
                            --TriggerEvent("XNL_NET:AddPlayerXP", math.random(50,100))
                            break
                        end
                    end
                end
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
            end
        end
    end
end


Citizen.CreateThread(function()
    TriggerServerEvent("RED_JOBS:ChantierAntiDump")
end)