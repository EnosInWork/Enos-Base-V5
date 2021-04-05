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

---------------

RMenu.Add('karting', 'main', RageUI.CreateMenu("Karting", "Intéraction"))
RMenu.Add('karting', 'annonce', RageUI.CreateSubMenu(RMenu:Get('karting', 'main'), "Karting", "Intéraction"))

Citizen.CreateThread(function()
    while true do
		RageUI.IsVisible(RMenu:Get('karting', 'main'), true, true, true, function()

			RageUI.ButtonWithStyle("Annonces",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('karting', 'annonce'))

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

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('karting', 'annonce'), true, true, true, function()
			
		RageUI.ButtonWithStyle("Ouvert",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceKartOuvert')
			end
		end)

		RageUI.ButtonWithStyle("Fermer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('AnnonceKartFermer')
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'karting' then 
        --    RegisterNetEvent('esx_kartingjob:onDuty')
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('karting', 'main'), not RageUI.Visible(RMenu:Get('karting', 'main')))
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
				  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_karting', ('karting'), amount)
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

	local kartmap = AddBlipForCoord(-1032.93, -3469.1, 20.8)
	
		SetBlipSprite(kartmap, 147)
		SetBlipColour(kartmap, 1)
		SetBlipScale(kartmap, 0.80)
		SetBlipAsShortRange(kartmap, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Karting")
		EndTextCommandSetBlipName(kartmap)
	end)	  

------------------------------------------------------------------------------------------- Coffre =

---------------- FONCTIONS ------------------

RMenu.Add('tahlesfou', 'coffre', RageUI.CreateMenu("Kart", "Coffre"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('tahlesfou', 'coffre'), true, true, true, function()

				RageUI.ButtonWithStyle("Prendre Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenGetStockskartingMenu()
						RageUI.CloseAll()
					end
				end)
				
				RageUI.ButtonWithStyle("Déposer Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
					if Selected then
						OpenPutStockskartingMenu()
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
    {x = -1028.26, y = -3475.71, z = 14.33}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'karting' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
			DrawMarker(20, -1028.26, -3475.71, 13.33+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au coffre")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('tahlesfou', 'coffre'), not RageUI.Visible(RMenu:Get('tahlesfou', 'coffre')))
                end
            end
        end
    end
    end
end)

function OpenGetStockskartingMenu()
	ESX.TriggerServerCallback('karting:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'karting',
			title    = 'karting stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'karting',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('karting:prendreitems', itemName, count)

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

function OpenPutStockskartingMenu()
	ESX.TriggerServerCallback('karting:inventairejoueur', function(inventory)
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
            css      = 'karting',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'karting',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('karting:stockitem', itemName, count)

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

	ESX.TriggerServerCallback('karting:getArmoryWeapons', function(weapons)
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

			ESX.TriggerServerCallback('karting:removeArmoryWeapon', function()
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

		ESX.TriggerServerCallback('karting:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

	end, function(data, menu)
		menu.close()
	end)
end