

local sync = false
local WorkerChillPos = {}
local workzone = {}
local WorkerWorkingPos = {}
local Heading
local pedHash
AuTravaillebucheron = nil
local ArgentMin
local ArgentMax


local WorkerChillPos = {
    ped1 = {
        pos = vector3(-557.8373, 5362.547, 69.21445),
        Heading = 11.653322219849,
    },
    ped2 = {
        pos = vector3(-556.9439, 5364.371, 69.24194),
        Heading = 156.03028869629,
    },
    
}

Citizen.CreateThread(function()
    LoadModel("s_m_y_construct_01")
    local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), zone.bucheron, 289.134, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, 1, 1)
    SetBlockingOfNonTemporaryEvents(ped, 1)

 
    for _,v in pairs(WorkerChillPos) do
        local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), v.pos, v.Heading, 0, 0)
        DecorSetInt(ped, "Yay", 5431)
        FreezeEntityPosition(ped, 1)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
        SetEntityInvincible(ped, true)
        SetEntityAsMissionEntity(ped, 1, 1)
        SetBlockingOfNonTemporaryEvents(ped, 1)
    end

end)




local object = {
    "prop_tree_pine_02",
    "prop_tree_pine_01",
}


local zoneZoche = vector3(-521.8883, 5489.108, 69.89445)


function StartTravaillebucheron()
    self = object
    RequestAnimDict("missfinale_c2mcs_1")
    AuTravaillebucheron = true
    Citizen.CreateThread(function()
        while AuTravaillebucheron do
            EnAction = false
            local zoneRandom = vector3(zoneZoche.x+math.random(-15.0, 15.0), zoneZoche.y+math.random(-15.0, 15.0), zoneZoche.z)
            local random = math.random(1, #object)
            local model = GetHashKey(object[random])
            RequestModel(model)
            while not HasModelLoaded(model) do print("Chargement model") Wait(100) end
            roche = CreateObject(model, zoneRandom, 1, 0, 0)
            blip = AddBlipForEntity(roche)
           
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(roche), true)
            SetBlipSprite(blip, 652)
            SetBlipColour(blip, 5)
            SetBlipScale(blip, 0.65)
            PlaceObjectOnGroundProperly(roche)
            local pos = GetEntityCoords(roche)
            SetEntityCoords(roche, pos.x, pos.y, pos.z-0.5, 0.0, 0.0, 0.0, 0)
            FreezeEntityPosition(roche, 1)
            local coords = GetEntityCoords(roche)
            while not EnAction and AuTravaillebucheron do
                Citizen.Wait(1)
                RageUI.Text({message = "Dirigez-vous vers le point GPS pour abattre un arbre"})
                dstToMarker = GetDistanceBetweenCoords(zoneRandom, pCoords, true)
                DrawMarker(1, coords.x, coords.y, coords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 100.0, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(roche), false)
                if dst <= 3.0 and AuTravaillebucheron then
                    HelpMsg("~b~E~w~ pour travailler")
                    if IsControlJustPressed(1, 51) and dst <= 3.0 then
                        RemoveBlip(blip)
                        EnAction = true
                        pickaxe = CreateObject(GetHashKey("prop_ld_fireaxe"), 0, 0, 0, true, true, true) 
                        AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.11, 0.0, -0.02, 420.0, 40.00, 140.0, true, true, false, true, 1, true)
                        TaskTurnPedToFaceEntity(PlayerPedId(), roche, 2000)
                        Wait(2000)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, 0)
                        exports["rs_prog"]:AfficherProgressbar(10.0)
                        Wait(10000)
                        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        exports["rs_prog"]:CacherProgressbar() 
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
                        RemoveObj(NetworkGetNetworkIdFromEntity(roche))
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        -- etape 2
                        TaskPlayAnim(GetPlayerPed(-1), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                        log = CreateObject(GetHashKey("prop_tree_log_02"), 0, 0, 0, true, true, true) 
                        AttachEntityToEntity(log, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 10706), 0.24, 0.08, 0.55, 70.0, -100.0, -80.0, true, true, false, true, 1, true)

                        logBlip = AddBlipForCoord(vector3(-532.3521, 5372.843, 70.44632))
                        SetBlipSprite(logBlip, 649)
                        SetBlipColour(logBlip, 5)
                        SetBlipScale(logBlip, 0.65)

                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), vector3(-532.3521, 5372.843, 70.44632), false)
                        while dst > 3.0 do
                            if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) then
                                TaskPlayAnim(GetPlayerPed(-1), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                            end
                            Citizen.Wait(1)
                            DrawMarker(1, -532.3521, 5372.843, 70.44632, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 100.0, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                            dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), vector3(-532.3521, 5372.843, 70.44632), false)
                            DisableControlAction(0, 21, true) -- Sprint
                            DisableControlAction(0, 22, true) -- Jump
                            DisableControlAction(0, 23, true) 
                            DisableControlAction(0, 24, true) -- Click droit
                            DisableControlAction(0, 25, true) -- Click gauche 
                            DisableControlAction(0, 166, true) -- F5
                            RageUI.Text({message = "Dirigez-vous vers le point GPS pour déposer l'arbre couper"})
                        end
                        DetachEntity(log, 1, true)
                        DeleteEntity(log)
                        DeleteObject(log)
                        RemoveBlip(logBlip)
                        RemoveObj(NetworkGetNetworkIdFromEntity(log))
                        ClearPedTasksImmediately(GetPlayerPed(-1))


                        local money = math.random(2, 50)
                        TriggerServerEvent("ori_jobs:pay", money)
                        RageUI.Popup({
                            message = "Bien ! Tu à été payé ~g~"..money.."$ ~w~pour ton travaille, continue comme ça !",
                        })
                        --TriggerEvent("XNL_NET:AddPlayerXP", math.random(130,150))
                        break
                    end
                end
            end
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
            RemoveObj(NetworkGetNetworkIdFromEntity(roche)) 
            RemoveBlip(blip)
        end
        DetachEntity(pickaxe, 1, true)
        DeleteEntity(pickaxe)
        RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
        RemoveObj(NetworkGetNetworkIdFromEntity(roche))
        RemoveBlip(blip) 
    end)
end

function endwork()
    DetachEntity(pickaxe, 1, true)
    DeleteEntity(pickaxe)
    RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
    RemoveObj(NetworkGetNetworkIdFromEntity(roche))
    RemoveBlip(blip) 
end

function RemoveObj(id)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and IsEntityAttached(entity) do 
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            DetachEntity(entity, 0, 0)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end

    end)
end



--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(1)
--        if IsControlJustPressed(1, 38) then
--            log = CreateObject(GetHashKey("prop_tree_log_02"), 0, 0, 0, true, true, true) 
--            AttachEntityToEntity(log, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 10706), 0.24, 0.08, 0.55, 70.0, -100.0, -80.0, true, true, false, true, 1, true)
--        end
--    end
--end)