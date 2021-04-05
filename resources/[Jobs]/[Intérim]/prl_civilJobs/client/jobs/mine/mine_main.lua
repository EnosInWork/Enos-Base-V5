

local sync = false
local WorkerChillPos = {}
local workzone = {}
local WorkerWorkingPos = {}
local Heading
local pedHash
AuTravaillemine = nil
local ArgentMin
local ArgentMax


local WorkerChillPos = {
    ped1 = {
        pos = vector3(2577.666, 2728.977, 41.81851),
        Heading = 354.7380065918,
    },
    ped2 = {
        pos = vector3(2575.421, 2721.184, 41.81066),
        Heading = 126.40444946289,
    },
    ped3 = {
        pos = vector3(2572.699, 2720.55, 41.84818),
        Heading = 255.41934204102,
    },
    ped4 = {
        pos = vector3(2577.479, 2730.421, 41.81313),
        Heading = 182.9189453125,
    },
    
}

Citizen.CreateThread(function()
    LoadModel("s_m_y_construct_01")
    local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), zone.mine, 117.68974304199, 0, 0)
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
    "csx_rvrbldr_meda_",
    "csx_rvrbldr_medb_",
    "csx_rvrbldr_medc_",
    "csx_rvrbldr_medd_",
    "csx_rvrbldr_mede_",
    "csx_rvrbldr_smla_",
    "csx_rvrbldr_smlb_",
    "csx_rvrbldr_smlc_",
    "csx_rvrbldr_smld_",
    "csx_rvrbldr_smle_",
}


local zoneZoche = vector3(2953.148, 2787.656, 41.49157)


function StartTravaillemine()
    self = object
    RequestAnimDict("melee@large_wpn@streamed_core")
    AuTravaillemine = true
    Citizen.CreateThread(function()
        while AuTravaillemine do
            EnAction = false
            local zoneRandom = vector3(zoneZoche.x+math.random(-15.0, 15.0), zoneZoche.y+math.random(-15.0, 15.0), zoneZoche.z)
            local random = math.random(1, #object)
            local model = GetHashKey(object[random])
            RequestModel(model)
            while not HasModelLoaded(model) do print("Chargement model") Wait(100) end
            roche = CreateObject(model, zoneRandom, 1, 0, 0)
            blip = AddBlipForEntity(roche)
           
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(roche), true)
            SetBlipSprite(blip, 618)
            SetBlipColour(blip, 5)
            SetBlipScale(blip, 0.65)
            PlaceObjectOnGroundProperly(roche)
            local pos = GetEntityCoords(roche)
            SetEntityCoords(roche, pos.x, pos.y, pos.z-0.5, 0.0, 0.0, 0.0, 0)
            FreezeEntityPosition(roche, 1)
            while not EnAction and AuTravaillemine do
                Citizen.Wait(1)
                dstToMarker = GetDistanceBetweenCoords(zoneRandom, pCoords, true)
                DrawMarker(32, zoneRandom.x, zoneRandom.y, zoneRandom.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(roche), true)
                if dst <= 3.0 and AuTravaillemine then
                    HelpMsg("Appuyer sur ~b~E~w~ pour travailler")
                    if IsControlJustPressed(1, 51) and dst <= 3.0 then
                        RemoveBlip(blip)
                        EnAction = true
                        TaskPlayAnim(GetPlayerPed(-1), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 1, 0, 0, 0, 0)
                        pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                        AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                        exports["rs_prog"]:AfficherProgressbar(20.0)
                        Wait(20000)
                        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        exports["rs_prog"]:CacherProgressbar() 
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
                        RemoveObj(NetworkGetNetworkIdFromEntity(roche))
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        local money = math.random(2, 8)
                        TriggerServerEvent("ori_jobs:pay", money)
                        RageUI.Popup({
                            message = "Bien ! Tu à été payé ~g~"..money.."$ ~w~pour ton travaille, continue comme ça !",
                        })
                        --TriggerEvent("XNL_NET:AddPlayerXP", math.random(75,150))
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