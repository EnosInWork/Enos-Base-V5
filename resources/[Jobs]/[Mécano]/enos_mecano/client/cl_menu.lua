local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false



local attente = 0

  ESX = nil

  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsIn( ped, false )

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
    if ESX.IsPlayerLoaded() then



		ESX.PlayerData = ESX.GetPlayerData()



    end

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob = false
	NPCTargetTowable  = nil
	NPCTargetTowableZone = nil
	NPCHasSpawnedTowable = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
	end
end

---------------

RMenu.Add('mechanic', 'main', RageUI.CreateMenu("Mécano", "Intéraction"))
RMenu.Add('mechanic', 'annonce', RageUI.CreateSubMenu(RMenu:Get('mechanic', 'main'), "Mécano", "Intéraction"))

Citizen.CreateThread(function()
    while true do
		RageUI.IsVisible(RMenu:Get('mechanic', 'main'), true, true, true, function()

			RageUI.ButtonWithStyle("Annonces",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('mechanic', 'annonce'))

			RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
				if Selected then
                    RageUI.CloseAll()        
                    OpenBillingMenu()
				end
			end)			

		RageUI.ButtonWithStyle("Réparer le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle   = ESX.Game.GetVehicleInDirection()
				local coords    = GetEntityCoords(playerPed)
	
				if IsPedSittingInAnyVehicle(playerPed) then
					ESX.ShowNotification(_U('inside_vehicle'))
					return
				end
	
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(20000)
	
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						SetVehicleEngineOn(vehicle, true, true)
						ClearPedTasksImmediately(playerPed)
	
						ESX.ShowNotification(_U('vehicle_repaired'))
						isBusy = false
					end)
				else
					ESX.ShowNotification(_U('no_vehicle_nearby'))
				end
			end
		end)

		RageUI.ButtonWithStyle("Nettoyer le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle   = ESX.Game.GetVehicleInDirection()
				local coords    = GetEntityCoords(playerPed)
	
				if IsPedSittingInAnyVehicle(playerPed) then
					ESX.ShowNotification(_U('inside_vehicle'))
					return
				end
	
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(10000)
	
						SetVehicleDirtLevel(vehicle, 0)
						ClearPedTasksImmediately(playerPed)
	
						ESX.ShowNotification(_U('vehicle_cleaned'))
						isBusy = false
					end)
				else
					ESX.ShowNotification(_U('no_vehicle_nearby'))
				end

			end
		end)

		RageUI.ButtonWithStyle("Crocheter le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)
	
				if IsPedSittingInAnyVehicle(playerPed) then
					ESX.ShowNotification(_U('inside_vehicle'))
					return
				end
	
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(10000)
	
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						ClearPedTasksImmediately(playerPed)
	
						ESX.ShowNotification(_U('vehicle_unlocked'))
						isBusy = false
					end)
				else
					ESX.ShowNotification(_U('no_vehicle_nearby'))
				end
			end
		end)

		RageUI.ButtonWithStyle("Placer le véhicule sur la remorque",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, true)
	
				local towmodel = GetHashKey('flatbed')
				local isVehicleTow = IsVehicleModel(vehicle, towmodel)
	
				if isVehicleTow then
					local targetVehicle = ESX.Game.GetVehicleInDirection()
	
					if CurrentlyTowedVehicle == nil then
						if targetVehicle ~= 0 then
							if not IsPedInAnyVehicle(playerPed, true) then
								if vehicle ~= targetVehicle then
									AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									CurrentlyTowedVehicle = targetVehicle
									ESX.ShowNotification(_U('vehicle_success_attached'))
	
									if NPCOnJob then
										if NPCTargetTowable == targetVehicle then
											ESX.ShowNotification(_U('please_drop_off'))
											Config.Zones.VehicleDelivery.Type = 1
	
											if Blips['NPCTargetTowableZone'] then
												RemoveBlip(Blips['NPCTargetTowableZone'])
												Blips['NPCTargetTowableZone'] = nil
											end
	
											Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
											SetBlipRoute(Blips['NPCDelivery'], true)
										end
									end
								else
									ESX.ShowNotification(_U('cant_attach_own_tt'))
								end
							end
						else
							ESX.ShowNotification(_U('no_veh_att'))
						end
					else
						AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						DetachEntity(CurrentlyTowedVehicle, true, true)
	
						if NPCOnJob then
							if NPCTargetDeleterZone then
	
								if CurrentlyTowedVehicle == NPCTargetTowable then
									ESX.Game.DeleteVehicle(NPCTargetTowable)
									TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
									StopNPCJob()
									NPCTargetDeleterZone = false
								else
									ESX.ShowNotification(_U('not_right_veh'))
								end
	
							else
								ESX.ShowNotification(_U('not_right_place'))
							end
						end
	
						CurrentlyTowedVehicle = nil
						ESX.ShowNotification(_U('veh_det_succ'))
					end
				else
					ESX.ShowNotification(_U('imp_flatbed'))
				end
			end
		end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('mechanic', 'annonce'), true, true, true, function()
			
		RageUI.ButtonWithStyle("Ouvert",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceMOuvert')
			end
		end)

		RageUI.ButtonWithStyle("Fermer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceMFermer')
			end
		end)

		RageUI.ButtonWithStyle("Pause",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceMPause')
			end
		end)

		RageUI.ButtonWithStyle("Déplacement disponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceMDDispo')
			end
		end)

		RageUI.ButtonWithStyle("Déplacement indisponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceMIndispo')
			end
		end)

    end, function()
	end)


Citizen.Wait(0)
end
end)


    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
		end
    end)


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 
        --    RegisterNetEvent('esx_mechanicjob:onDuty')
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('mechanic', 'main'), not RageUI.Visible(RMenu:Get('mechanic', 'main')))
            end
        end
        end
    end)



	function OpenBillingMenu()
		ESX.UI.Menu.Open(
		  'dialog', GetCurrentResourceName(), 'billing',
		  {
			title = "Facture"
		  },

		  function(data, menu)

			local amount = tonumber(data.value)
			local player, distance = ESX.Game.GetClosestPlayer()

	  
			if player ~= -1 and distance <= 3.0 then

	  

			  menu.close()



			  if amount == nil then
				  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
			  else
				  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ('mechanic'), amount)
				  Citizen.Wait(100)
				  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
			  end

			else
			  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
			end

	  

		  end,
		  function(data, menu)
			  menu.close()
		  end
		)
	  end

-----------------------------------------------------------------------------------------------------------------

	  Citizen.CreateThread(function()

		local mecamap = AddBlipForCoord(-205.79, -1307.08, 20.8)
	
		SetBlipSprite(mecamap, 402)
		SetBlipColour(mecamap, 5)
		SetBlipScale(mecamap, 1.20)
		SetBlipAsShortRange(mecamap, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Benny's")
		EndTextCommandSetBlipName(mecamap)
	end)

-------------------------------------------------------------------------------------------

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)


------------------------ Coffre
    

RMenu.Add('CHAH', 'coffre', RageUI.CreateMenu("Mécano", "Coffre"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('CHAH', 'coffre'), true, true, true, function()

				RageUI.ButtonWithStyle("Prendre Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenGetStocksMecaMenu()
						RageUI.CloseAll()
					end
				end)
				
				RageUI.ButtonWithStyle("Déposer Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenPutStocksMecaMenu()
						RageUI.CloseAll()
					end
				end)
				
				RageUI.ButtonWithStyle("Prendre Arme(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenGetWeaponMenu()
						RageUI.CloseAll()
					end
				end)
				
				RageUI.ButtonWithStyle("Déposer Arme(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenPutWeaponMenu()
						RageUI.CloseAll()
					end
				end)

        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = -196.03, y = -1338.48, z = 34.9}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
			DrawMarker(20, -196.03, -1338.48, 33.9+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 250, 0, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au coffre")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('CHAH', 'coffre'), not RageUI.Visible(RMenu:Get('CHAH', 'coffre')))
                end
            end
        end
    end
    end
end)

function OpenGetStocksMecaMenu()
	ESX.TriggerServerCallback('Meca:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'Mecano',
			title    = 'Meca stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'Mecano',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('Meca:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksLSPDMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMecaMenu()
	ESX.TriggerServerCallback('Meca:inventairejoueur', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'Mecano',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'Mecano',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('Meca:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksLSPDMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end


function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('Meca:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		{
			title    = 'Coffre-Armurerie',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('Meca:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	{
		title    = 'Coffre-Armurerie',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('Meca:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

	end, function(data, menu)
		menu.close()
	end)
end