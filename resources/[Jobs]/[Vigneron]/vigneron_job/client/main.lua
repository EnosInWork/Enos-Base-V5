local HasAlreadyEnteredMarker, LastVigne, LastPart, LastPartNum
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local isDead, isBusy = false, false
local PlayerData,  JobBlips = {}, {}
local publicBlip = false
ESX = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

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


function OpenVigneActionsMenu()
	local elements = {
		{label = _U('deposit_stock'),  value = 'put_stock'},
		{label = _U('withdraw_stock'), value = 'get_stock'}
	}


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vigne_actions', {
		title    = _U('vigne'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'vigne_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end






function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_vignejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('vigne_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_vignejob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_vignejob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_vignejob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_vignejob:onHijack')
AddEventHandler('esx_vignejob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_vignejob:onCarokit')
AddEventHandler('esx_vignejob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_vignejob:onFixkit')
AddEventHandler('esx_vignejob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
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


AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)



-- Marker



-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local letSleep, isInMarker, hasExited = true, false, false
			local currentVigne, currentPart, currentPartNum

			for VigneNum,Vigne in pairs(Config.Zones) do
				-- Vestiaires
				for k,v in ipairs(Config.Zones.Cloakroom) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Cloakroombn', k
						end
					end
				end
				-- Stockage
				for k,v in ipairs(Config.Zones.Actions) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Actions', k
						end
					end
				end
				-- Actions Patron
				if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
					for k,v in ipairs(Config.Zones.Boss) do
						local distance = #(playerCoords - v)
	
						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
	
							if distance < Config.Marker.x then
								isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Boss', k
							end
						end
					end
				end				
				-- Vestiaires
				for k,v in ipairs(Config.Zones.Garage) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Garage', k
						end
					end
				end
				-- Craft
				for k,v in ipairs(Config.Zones.Harv) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Harv', k
						end
					end
				end

				for k,v in ipairs(Config.Zones.Craft) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Craft', k
						end
					end
				end
				

			--vente

			for k,v in ipairs(Config.Zones.Sell) do
				local distance = #(playerCoords - v)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false

					if distance < Config.Marker.x then
						isInMarker, currentVigne, currentPart, currentPartNum = true, VigneNum, 'Sell', k
					end
				end
			end
			
		end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastVigne ~= currentVigne or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastVigne ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastVigne ~= currentVigne or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('lsVigne:hasExitedMarker', LastVigne, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastVigne, LastPart, LastPartNum = true, currentVigne, currentPart, currentPartNum

				TriggerEvent('lsVigne:hasEnteredMarker', currentVigne, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('lsVigne:hasExitedMarker', LastVigne, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('lsVigne:hasEnteredMarker', function(Vigne, part, partNum)
	if part == 'Cloakroombn' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder au vestiaires'
		CurrentActionData = {}
	elseif part == 'Actions' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder aux Actions'
		CurrentActionData = {}
	elseif part == 'Boss' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder à l\'ordinateur'
		CurrentActionData = {}
	elseif part == 'Harv' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~r~Récolter.'
		CurrentActionData = {}
	elseif part == 'Craft' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~r~Traiter.'
		CurrentActionData = {}
	elseif part == 'Sell' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~r~Vendre.'
		CurrentActionData = {}
	elseif part == 'Garage' then
		CurrentAction = part
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour acceder au Garage'
		CurrentActionData = {}
	end
end)

AddEventHandler('lsVigne:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)





-- Key Controls



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'Cloakroombn' then
					TriggerEvent('Cloakroombn')
				elseif CurrentAction == 'Boss' then
					TriggerEvent('esx_society:openBossMenu', 'vigne', function(data, menu)
						menu.close()
					end)
				elseif CurrentAction == 'Actions' then
					OpenVigneActionsMenu()
				elseif CurrentAction == 'Garage' then
					TriggerEvent('vigne_garage')
				elseif CurrentAction == 'Harv' then
					TriggerEvent('vigne_harvest')
				elseif CurrentAction == 'Craft' then
					TriggerEvent('craft')
				elseif CurrentAction == 'Sell' then
					TriggerEvent('vigne_sell')
				end

				CurrentAction = nil
			end

		elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' and not isDead then
			if IsControlJustReleased(0, 167) then
				TriggerEvent('vigne_menu')
			end
		else
			Citizen.Wait(500)
		end
	end
end)

----------------------------------

Citizen.CreateThread(function()

    local vignemap = AddBlipForCoord(-1900.32, 2060.89, 20.8)

    SetBlipSprite(vignemap, 85)
    SetBlipColour(vignemap, 7)
    SetBlipScale(vignemap, 0.90)
    SetBlipAsShortRange(vignemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Vigneron")
    EndTextCommandSetBlipName(vignemap)

	local recvign = AddBlipForCoord(-1803.69, 2214.42, 91.43)

    SetBlipSprite(recvign, 480)
    SetBlipColour(recvign, 7)
    SetBlipScale(recvign, 0.80)
    SetBlipAsShortRange(recvign, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Circuit Vigne")
    EndTextCommandSetBlipName(recvign)

	local tvigne = AddBlipForCoord(-51.86, 1911.27, 195.36)

    SetBlipSprite(tvigne, 480)
    SetBlipColour(tvigne, 7)
    SetBlipScale(tvigne, 0.80)
    SetBlipAsShortRange(tvigne, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Circuit Vigne")
    EndTextCommandSetBlipName(tvigne)

	local svigne = AddBlipForCoord(359.38, -1109.02, 29.41)

    SetBlipSprite(svigne, 480)
    SetBlipColour(svigne, 7)
    SetBlipScale(svigne, 0.80)
    SetBlipAsShortRange(svigne, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Circuit Vigne")
    EndTextCommandSetBlipName(svigne)

end)

