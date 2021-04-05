local HasAlreadyEnteredMarker = false
local LastPad, LastAction, LastPadData, CurrentAction, CurrentActionData, CurrentActionMsg

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_teleportpads:hasEnteredMarker')
AddEventHandler('esx_teleportpads:hasEnteredMarker', function(currentPad, padData)
	CurrentAction = 'pad.' .. string.lower(currentPad)
	CurrentActionMsg = padData.Text
	CurrentActionData = { padData = padData }
end)

RegisterNetEvent('esx_teleportpads:hasExitedMarker')
AddEventHandler('esx_teleportpads:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()

	CurrentAction = nil
end)

-- Draw marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local canSleep = true

		for pad, padData in ipairs(Config.Pads) do
			if GetDistanceBetweenCoords(coords, padData.Marker, true) < Config.DrawDistance then
				DrawMarker(padData.MarkerSettings.type, padData.Marker, 0.0, 0.0, 0.0, 0, 0.0, 0.0, padData.MarkerSettings.x, padData.MarkerSettings.y, padData.MarkerSettings.z, padData.MarkerSettings.r, padData.MarkerSettings.g, padData.MarkerSettings.b, padData.MarkerSettings.a, false, true, 2, false, false, false, false)
				canSleep = false
			end
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local coords, isInMarker, currentPad, currentAction, currentPadData = GetEntityCoords(playerPed), false, nil, nil, nil

		for pad, padData in ipairs(Config.Pads) do
			if GetDistanceBetweenCoords(coords, padData.Marker, true) < padData.MarkerSettings.x then
				isInMarker, currentPad, currentAction, currentPadData = true, pad, 'pad.' .. string.lower(pad), padData
			end
		end

		local hasExited = false

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPad ~= currentPad or LastAction ~= currentAction)) then
			if (LastPad ~= nil and LastAction ~= nil) and (LastPad ~= currentPad or LastAction ~= currentAction) then
				TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
				
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastPad, LastAction, LastPadData = currentPad, currentAction, currentPadData

			TriggerEvent('esx_teleportpads:hasEnteredMarker', currentPad, currentPadData)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false

			TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
		end

		if not HasAlreadyEnteredMarker then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				ESX.Game.Teleport(PlayerPedId(), CurrentActionData.padData.TeleportPoint.coords, function()
					SetEntityHeading(PlayerPedId(), CurrentActionData.padData.TeleportPoint.h)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)
