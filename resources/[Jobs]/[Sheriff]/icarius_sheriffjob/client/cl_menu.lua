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

local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
blip = nil
local sheriffDog = false
local PlayerData = {}
closestDistance, closestEntity = -1, nil
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false
local attente = 0
local currentTask = {}

local function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

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


loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RMenu.Add('sheriff', 'main', RageUI.CreateMenu("SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'inter', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'info', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'doc', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'renfort', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'voiture', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'chien', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'cam', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))
RMenu.Add('sheriff', 'megaphone', RageUI.CreateSubMenu(RMenu:Get('sheriff', 'main'), "SHERIFF", "Intéraction"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('sheriff', 'main'), true, true, true, function()

            RageUI.Checkbox("Prendre/Quitter son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                if Selected then

                    service = Checked


                    if Checked then
                        onservice = true
						RageUI.Popup({
							message = "Vous avez pris votre service !"})

                        
                    else
                        onservice = false
						RageUI.Popup({
							message = "Vous avez quitter votre service !"})

                    end
                end
            end)

			if onservice then

				RageUI.ButtonWithStyle("Infos SHERIFF", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'info'))
				
				RageUI.ButtonWithStyle("Intéractions sur personne", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'inter'))

				RageUI.ButtonWithStyle("Intéractions sur véhicules", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'voiture'))

				RageUI.ButtonWithStyle("Demande de renfort", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'renfort'))

				if IsPedInAnyVehicle(PlayerPedId(), false) then
				RageUI.ButtonWithStyle("Mégaphone", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'megaphone'))
				else
				RageUI.ButtonWithStyle('Mégaphone', description, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
						if (Selected) then
							end 
						end)
					end

				RageUI.ButtonWithStyle("Poser/Prendre Radar",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()       
						TriggerEvent('sheriff:sheriff_radar')
					end
				end)

				RageUI.ButtonWithStyle("Menu Chien", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'chien'))

				if ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then
				RageUI.ButtonWithStyle("Menu Caméra", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('sheriff', 'cam'))
				else
					RageUI.ButtonWithStyle('Menu Caméra', description, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
						if (Selected) then
							end 
						end)
					end
				end


    end, function()
	end)

		RageUI.IsVisible(RMenu:Get('sheriff', 'inter'), true, true, true, function()

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			RageUI.ButtonWithStyle("Donner une Amende",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
				if Selected then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then
					RageUI.CloseAll()        
					OpenBillingMenu() 
					else
					ESX.ShowNotification('Personne autour')
					end
				end
			end)

			RageUI.ButtonWithStyle("Prendre Carte d'identité", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then 
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then  
                	RageUI.CloseAll()
                	OpenIdentityCardMenu(closestPlayer)
				else
					ESX.ShowNotification('Personne autour')
					end
            	end
            end)

            RageUI.ButtonWithStyle("Fouiller", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then  
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then
					RageUI.CloseAll()
                    OpenBodySearchMenu(closestPlayer)
                    ExecuteCommand("me La personne fouille")
					else
						ESX.ShowNotification('Personne autour')
					end
                end
            end)    

        RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
				local target, distance = ESX.Game.GetClosestPlayer()
				playerheading = GetEntityHeading(GetPlayerPed(-1))
				playerlocation = GetEntityForwardVector(PlayerPedId())
				playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local target_id = GetPlayerServerId(target)
				if distance <= 2.0 then 
                TriggerServerEvent('esx_sheriffjob:handcuff', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification('Personne autour')
				end
            end
        end)

            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then 
                TriggerServerEvent('esx_sheriffjob:drag', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification('Personne autour')
				end
            end
        end)

            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then 
                TriggerServerEvent('esx_sheriffjob:putInVehicle', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification('Personne autour')
				end
                end
            end)

            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if distance <= 2.0 then 
                TriggerServerEvent('esx_sheriffjob:OutVehicle', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification('Personne autour')
				end
            end
        end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('sheriff', 'info'), true, true, true, function()

		RageUI.ButtonWithStyle("Prise de service",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'prise'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Fin de service",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'fin'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Pause de service",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'pause'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Standby",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'standby'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Control en cours",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'control'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Refus d'obtempérer",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'refus'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Crime en cours",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'crime'
				TriggerServerEvent('sheriff:PriseEtFinservice', info)
			end
		end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('sheriff', 'cam'), true, true, true, function()

		RageUI.ButtonWithStyle("Caméra 1", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 25) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 2", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 26) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 3", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 27) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 4", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 1) 
			end
		end)


		RageUI.ButtonWithStyle("Caméra 5", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 2) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 6", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 3) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 7", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 4) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 8", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 5) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 9", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 6) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 10", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 7) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 11", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 8) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 12", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 9) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 13", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 10) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 14", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 11) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 15", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 12) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 16", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 13) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 17", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 14) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 18", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 15) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 19", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 16) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 20", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 17) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 21", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 18) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 22", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 19) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 23", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 20) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 24", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 21) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 25", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 22) 
			end
		end)

		RageUI.ButtonWithStyle("Caméra 26", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerEvent('cctv:camera', 23) 
			end
		end)

	end, function()
	end)


	RageUI.IsVisible(RMenu:Get('sheriff', 'megaphone'), true, true, true, function()

		RageUI.ButtonWithStyle("Arrêter vous immédiatement !", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_the_f_car", 0.6) 
			end
		end)

		RageUI.ButtonWithStyle("Conducteur, STOP votre véhicule", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle-2", 0.6)
			end
		end)
		
		RageUI.ButtonWithStyle("Stop, les mains en l'air", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "dont_make_me", 0.6)
			end
		end)

		RageUI.ButtonWithStyle("Stop, plus un geste ! ou on vous tue", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_dont_move", 0.6)
			end
		end)

		RageUI.ButtonWithStyle("Reste ici et ne bouge plus !", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stay_right_there", 0.6)
			end
		end)

		RageUI.ButtonWithStyle("Disperssez vous de suite ! ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then   
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "disperse_now", 0.6)
			end
		end)

			end, function()
			end)

	RageUI.IsVisible(RMenu:Get('sheriff', 'renfort'), true, true, true, function()

		RageUI.ButtonWithStyle("Petite demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local raison = 'petit'
				local elements  = {}
				local playerPed = PlayerPedId()
				local coords  = GetEntityCoords(playerPed)
				local name = GetPlayerName(PlayerId())
			TriggerServerEvent('renfort', coords, raison)
		end
	end)

	RageUI.ButtonWithStyle("Moyenne demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
		if Selected then
			local raison = 'importante'
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords  = GetEntityCoords(playerPed)
			local name = GetPlayerName(PlayerId())
		TriggerServerEvent('renfort', coords, raison)
	end
end)

RageUI.ButtonWithStyle("Grosse demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
	if Selected then
		local raison = 'omgad'
		local elements  = {}
		local playerPed = PlayerPedId()
		local coords  = GetEntityCoords(playerPed)
		local name = GetPlayerName(PlayerId())
	TriggerServerEvent('renfort', coords, raison)
end
end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('sheriff', 'voiture'), true, true, true, function()
		local coords  = GetEntityCoords(PlayerPedId())
		local vehicle = ESX.Game.GetVehicleInDirection()

		RageUI.ButtonWithStyle("Rechercher une plaque",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then 
				LookupVehicle()
				RageUI.CloseAll()
			end
			end)

			RageUI.ButtonWithStyle("Mettre en fourrière", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then

					TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

					currentTask.busy = true
					currentTask.task = ESX.SetTimeout(10000, function()
						ClearPedTasks(playerPed)
						ESX.Game.DeleteVehicle(vehicle)
						ESX.ShowNotification("~o~Mise en fourrière effectuée")
						currentTask.busy = false
						Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
					end)

					-- keep track of that vehicle!
					Citizen.CreateThread(function()
						while currentTask.busy do
							Citizen.Wait(1000)

							vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
							if not DoesEntityExist(vehicle) and currentTask.busy then
								ESX.ShowNotification("~r~Le véhicule a bougé!")
								ESX.ClearTimeout(currentTask.task)
								ClearPedTasks(playerPed)
								currentTask.busy = false
								break
							end
						end
					end)
				end
			end)
	
	end, function()
	end)

	RageUI.IsVisible(RMenu:Get('sheriff', 'chien'), true, true, true, function()

			RageUI.ButtonWithStyle("Sortir/Rentrer le chien",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
				if Selected then
					if not DoesEntityExist(sheriffDog) then
                        RequestModel(351016938)
                        while not HasModelLoaded(351016938) do Wait(0) end
                        sheriffDog = CreatePed(4, 351016938, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                        SetEntityAsMissionEntity(sheriffDog, true, true)
                        ESX.ShowNotification('~g~Chien Spawn')
                    else
                        ESX.ShowNotification('~r~Chien Rentrer')
                        DeleteEntity(sheriffDog)
                    end
				end
			end)

			RageUI.ButtonWithStyle("Assis",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
				if Selected then
					if DoesEntityExist(sheriffDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(sheriffDog), true) <= 5.0 then
                            if IsEntityPlayingAnim(sheriffDog, "creatures@husky@amb@world_dog_sitting@base", "base", 3) then
                                ClearPedTasks(sheriffDog)
                            else
                                loadDict('rcmnigel1c')
                                TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                Wait(2000)
                                loadDict("creatures@husky@amb@world_dog_sitting@base")
                                TaskPlayAnim(sheriffDog, "creatures@husky@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                            end
                        else
                            ESX.ShowNotification('dog_too_far')
                        end
                    else
                        ESX.ShowNotification('no_dog')
                    end
				end
			end)

		RageUI.ButtonWithStyle("Cherche de drogue",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				if DoesEntityExist(sheriffDog) then
					if not IsPedDeadOrDying(sheriffDog) then
						if GetDistanceBetweenCoords(GetEntityCoords(sheriffDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
							local player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 then
								if distance <= 3.0 then
									local playerPed = GetPlayerPed(player)
									if not IsPedInAnyVehicle(playerPed, true) then
										TriggerServerEvent('esx_sheriffdog:hasClosestDrugs', GetPlayerServerId(player))
									end
								end
							end
						end
					else
						ESX.ShowNotification('Votre chien est mort')
					end
				else
					ESX.ShowNotification('Vous n\'avez pas de chien')
				end
			end
		end)

		RageUI.ButtonWithStyle("Dire d'attaquer",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				if DoesEntityExist(sheriffDog) then
					if not IsPedDeadOrDying(sheriffDog) then
						if GetDistanceBetweenCoords(GetEntityCoords(sheriffDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
							local player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 then
								if distance <= 3.0 then
									local playerPed = GetPlayerPed(player)
									if not IsPedInCombat(sheriffDog, playerPed) then
										if not IsPedInAnyVehicle(playerPed, true) then
											TaskCombatPed(sheriffDog, playerPed, 0, 16)
										end
									else
										ClearPedTasksImmediately(sheriffDog)
									end
								end
							end
						end
					else
						ESX.ShowNotification('Votre chien est mort')
					end
				else
					ESX.ShowNotification('Vous n\'avez pas de chien')
			end
		end
	end)

    end, function()
	end)

	Citizen.Wait(0)
	end
end)

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_sheriffjob:getOtherPlayerData', function(data)
		local elements = {
			{label = 'name', data.name}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = 'sex', data.sex})
			table.insert(elements, {label = 'dob', data.dob})
			table.insert(elements, {label = 'height', data.height})
		end

		if data.drunk then
			table.insert(elements, {label = 'bac', data.drunk})
		end

		if data.licenses then
			table.insert(elements, {label = 'license_label'})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = 'citizen_interaction',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBillingMenu()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Amende"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_sheriff', ('sheriff'), amount)
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

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_sheriffjob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			css      = 'sheriff',
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_sheriffjob:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'top-left',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('openf6')
AddEventHandler('openf6', function()
	RageUI.Visible(RMenu:Get('sheriff', 'main'), not RageUI.Visible(RMenu:Get('sheriff', 'main')))
end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)
	if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'importante' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'omgad' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	Wait(80 * 1000)
	RemoveBlip(blipId)
end)

RegisterNetEvent('sheriff:InfoService')
AddEventHandler('sheriff:InfoService', function(service, nom)
	if service == 'prise' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Prise de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-8\n~w~Information: ~g~Prise de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Fin de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-10\n~w~Information: ~g~Fin de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'pause' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Pause de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-6\n~w~Information: ~g~Pause de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'standby' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Mise en standby', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-12\n~w~Information: ~g~Standby, en attente de dispatch.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Control routier', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-48\n~w~Information: ~g~Control routier en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Refus d\'obtemperer', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Refus d\'obtemperer / Delit de fuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'crime' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('SHERIFF INFORMATIONS', '~b~Crime en cours', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-31\n~w~Information: ~g~Crime en cours / poursuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

-------------------------- Intéraction 

RegisterNetEvent('esx_sheriffjob:handcuff')
AddEventHandler('esx_sheriffjob:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(100)
        end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      DisplayRadar(false)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
	  DisplayRadar(true)

    end

  end)
end)

RegisterNetEvent('esx_sheriffjob:drag')
AddEventHandler('esx_sheriffjob:drag', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_sheriffjob:putInVehicle')
AddEventHandler('esx_sheriffjob:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_sheriffjob:OutVehicle')
AddEventHandler('esx_sheriffjob:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

----------------------------------------------- Fouiller

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_sheriffjob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = 'argent sale ', ESX.Math.Round(data.accounts[i].money),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = 'Armes'})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = ESX.GetWeaponLabel(data.weapons[i].name)..' avec '..data.weapons[i].ammo.. ' Munitions',
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = 'Items'})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = data.inventory[i].count..' x'..data.inventory[i].label,
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = 'fouille',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_sheriffjob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end


Citizen.CreateThread(function()
    local sheriffmap = AddBlipForCoord(439.14, -982.3, 30.69)
    SetBlipSprite(sheriffmap, 60)
    SetBlipColour(sheriffmap, 38)
    SetBlipScale(sheriffmap, 0.99)
    SetBlipAsShortRange(sheriffmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("~b~Commissariat~s~ | sheriff")
    EndTextCommandSetBlipName(sheriffmap)
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
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' then 
	--    RegisterNetEvent('esx_sheriffjob:onDuty')
		if IsControlJustReleased(0 ,167) then
			RageUI.Visible(RMenu:Get('sheriff', 'main'), not RageUI.Visible(RMenu:Get('sheriff', 'main')))
		end
	end
	end
end)
