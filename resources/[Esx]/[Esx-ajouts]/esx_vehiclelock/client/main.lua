ESX               = nil
local playerCars = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Menu Mes clés --
RegisterNetEvent('ddx_menu:key')
AddEventHandler('ddx_menu:key', function()
ESX.TriggerServerCallback('ddx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then
				if 	mykey[i].NB == 1 then
						table.insert(elements, {label = 'Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
					elseif mykey[i].NB == 2 then
						table.insert(elements, {label = '[DOUBLE] Véhicule : '.. ' [' .. mykey[i].plate .. ']', value = nil})
					end
				end
			end

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{
		title = 'Mes clés',
		css = 'vehicle',
		align = 'right',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb

        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{
				title = 'Que voulez faire ?',
				align = 'right',
				elements = {
						{label = 'Changer de propriétaire', value = 'donnerkey'}, -- Donné les clés
						{label = 'Prêter ses clés', value = 'preterkey'}, -- Donné les clés
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
 					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed, true)
 					local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71)
 					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

       				 if data3.current.value == 'donnerkey' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('ddx_vehiclelock:donnerkey', GetPlayerServerId(player), data2.current.value)
       					  TriggerServerEvent('ddx_vehiclelock:deletekey', data2.current.value)
       					  -- print("avant changement owner")
       					  TriggerServerEvent('ddx_givecarkeys:frommenu')
       					  -- print("après changement owner")
       					end
      				 end
      				 if data3.current.value == 'preterkey' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('ddx_vehiclelock:preterkey', GetPlayerServerId(player), data2.current.value)
       					end
      				 end
       			 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb

        		 end
   			 )
        end
        end,

        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)

-- Menu Mes clés --
RegisterNetEvent('ddx_menu:key')
AddEventHandler('ddx_menu:key', function()
ESX.TriggerServerCallback('ddx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then
				if 	mykey[i].NB == 1 then
						table.insert(elements, {label = 'Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
					elseif mykey[i].NB == 2 then
						table.insert(elements, {label = '[DOUBLE] Véhicule : '.. ' [' .. mykey[i].plate .. ']', value = nil})
					end
				end
			end

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{
		title = 'Mes clés',
		css = 'vehicle',
		align = 'right',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb

        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{
				title = 'Que voulez vous faire ?',
				align = 'right',
				elements = {
						{label = 'Prêter', value = data2.current.value}, -- Donné les clés
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()

       				 if data3.current.value ~= nil then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('ddx_vehiclelock:givekey', GetPlayerServerId(player), data2.current.value)
       					end
      				 end
       			 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb

        		 end
   			 )
        end
        end,

        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)

AddEventHandler('ddx_vehiclelock:hasEnteredMarker', function(zone)

	CurrentAction     = 'Serrurier'
	CurrentActionMsg  = 'Serrurier'
	CurrentActionData = {zone = zone}

end)

AddEventHandler('ddx_vehiclelock:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

end)


function OpenCloseVehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed, true)

	local vehicle = nil

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71)
	end

	ESX.TriggerServerCallback('ddx_vehiclelock:mykey', function(gotkey)

		if gotkey then
			local locked = GetVehicleDoorLockStatus(vehicle)
			if locked == 1 or locked == 0 then -- if unlocked
				SetVehicleDoorsLocked(vehicle, 2)
				PlayVehicleDoorCloseSound(vehicle, 1)
				ESX.ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
			elseif locked == 2 then -- if locked
				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
				ESX.ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
			end
		else
			ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule.")
		end
	end, GetVehicleNumberPlateText(vehicle))
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0,303) then -- Touche K
			OpenCloseVehicle()
		end
	end
end)

-----------------------------Car Dealer --------------------------------

RegisterNetEvent('ddx_menu:keycardealer')
AddEventHandler('ddx_menu:keycardealer', function()
ESX.TriggerServerCallback('ddx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then
				if 	mykey[i].NB == 3 then
						table.insert(elements, {label = '[PRO] Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
					end
				end
			end

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{
		title = 'Clé Pro',
		css = 'vehicle',
		align = 'right',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb

        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{
				title = 'Voulez vous ?',
				align = 'left',
				elements = {{label = 'Donner', value = data2.current.value}, -- Donné un double
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()

       				 if data3.current.value ~= nil then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('ddx_vehiclelock:givekeycardealer', GetPlayerServerId(player), data2.current.value)
       					  TriggerServerEvent('ddx_vehiclelock:deletekeycardealer', GetPlayerServerId(player), data2.current.value)
       					end
      				 end
       			 end,

       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb

        		 end
   			 )
        end
        end,
        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)


-- Menu Serrurier --
function OpenSerrurierMenu()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'GetKey',
	{
		title = 'Que voulez vous faire ?',
		css = 'vehicle',
		align = 'left',
		elements = {
			{label = ('Enregistrer une nouvelle clé'),              value = 'registerkey'},
	}
	  },
        function(data, menu) --Submit Cb

        if data.current.value == 'registerkey' then
					ESX.TriggerServerCallback('ddx_vehiclelock:getVehiclesnokey', function(Vehicles2)
						local elements = {}

						if Vehicles2 == nil then
							table.insert(elements, {label = 'Aucun véhicule sans clés ', value = nil})
						else
							for i=1, #Vehicles2, 1 do
								model = Vehicles2[i].model
								modelname = GetDisplayNameFromVehicleModel(model)
								Vehicles2[i].model = GetLabelText(modelname)
							end

							for i=1, #Vehicles2, 1 do
								table.insert(elements, {label = Vehicles2[i].model .. ' [' .. Vehicles2[i].plate .. ']', value = Vehicles2[i].plate})
							end

							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'backey',
							{
							title    = '50$ pour une nouvelle paire de clés',
							align    = 'left',
							elements = elements
							},
							function(data2, menu2)
									menu2.close()
									TriggerServerEvent('ddx_vehiclelock:registerkey', data2.current.value, 'no')
							end,
							function(data2, menu2)
								menu2.close()
							end
							)
						end
					end)
			end
        end,
        function(data, menu) --Cancel Cb
                menu.close()
        end,
        function(data, menu) --Change Cb
        end
      )
end

-- Create Blips
Citizen.CreateThread(function()
		local blip = AddBlipForCoord(Config.Zones.place.Pos.x, Config.Zones.place.Pos.y, Config.Zones.place.Pos.z)
		SetBlipSprite (blip, 134)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Serrurier')
		EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('ddx_vehiclelock:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('ddx_vehiclelock:hasExitedMarker', LastZone)
			end

		end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString('Appuyer sur ~INPUT_CONTEXT~ pour enregistrer des clés.')
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0, 38) then -- Touche E

        if CurrentAction == 'Serrurier' then
          OpenSerrurierMenu(CurrentActionData.zone)
        end

        CurrentAction = nil

      end

    end
  end
end)


Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 303) then -- When you press "U"
             if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
                TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				StopAnimTask = true
              else
                TriggerEvent("chatMessage", "", { 200, 200, 90 }, "Vous devez être sorti d'un véhicule pour l'utiliser les clés !") -- Shows this message when you are not in a vehicle in the chat
				
             end
        end
    end
end)

RegisterNetEvent('NB:car')
AddEventHandler('NB:car', function()
	OpenCloseVehicle()
end)