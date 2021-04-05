ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RMenu.Add('garagekart', 'main', RageUI.CreateMenu("Garage", "Garage Mécano"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garagekart', 'main'), true, true, true, function() 

            RageUI.ButtonWithStyle("Ranger le véhicule", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 5 then
                DeleteEntity(veh)
                RageUI.CloseAll()
            end 
        end
    end) 

    for k,v in pairs(Config.garagevoiture) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(1)  
            spawnuniCarrz(v.modele)
            RageUI.CloseAll()
            end
        end)
    end
            
                end, function()
                end)

            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garagevoiture.position.x, Config.pos.garagevoiture.position.y, Config.pos.garagevoiture.position.z)
                if dist3 <= 15.0 then
                    DrawMarker(20, -998.38, -3494.32, 13.23+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'karting' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'karting' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garagekart', 'main'), not RageUI.Visible(RMenu:Get('garagekart', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCarrz(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.spawn.spawnvoiture.position.x, Config.spawn.spawnvoiture.position.y, Config.spawn.spawnvoiture.position.z, Config.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Meca"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)
    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
    ESX.Game.SetVehicleProperties(vehicle, props)
  end


Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_autoshop_02", -236.76, -1341.24, 29.9, 358.91, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
end)