ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


---------------- FONCTIONS ------------------

RMenu.Add('enos', 'coffre', RageUI.CreateMenu("SHERIFF", "Coffre"))
Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('enos', 'coffre'), true, true, true, function()

			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'officer' then 

            RageUI.ButtonWithStyle("Prendre Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    OpenGetStocksSHERIFFMenu()
					RageUI.CloseAll()
                end
			end)
		end
			
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'officer' then 

            RageUI.ButtonWithStyle("Déposer Objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
				if Selected then
					OpenPutStocksSHERIFFMenu()
					RageUI.CloseAll()
                end
			end)
		end
			
		--	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'sergeant' then 
			RageUI.ButtonWithStyle("Prendre Arme(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
				if Selected then
					OpenGetWeaponMenu()
					RageUI.CloseAll()
				end
			end)
		--	end
			
		--	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'sergeant' then 
			RageUI.ButtonWithStyle("Déposer Arme(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
				if Selected then
					OpenPutWeaponMenu()
					RageUI.CloseAll()
				end
			end)
		--end


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = 469.9, y = -989.31, z = 24.92}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            DrawMarker(2, 469.9, -989.31, 24.92, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au coffre")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('enos', 'coffre'), not RageUI.Visible(RMenu:Get('enos', 'coffre')))
                end
            end
        end
    end
    end
end)

function OpenGetStocksSHERIFFMenu()
	ESX.TriggerServerCallback('esx_sheriffjob:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'sheriff',
			title    = 'sheriff stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'sheriff',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_sheriffjob:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksSHERIFFMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksSHERIFFMenu()
	ESX.TriggerServerCallback('esx_sheriffjob:inventairejoueur', function(inventory)
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
            css      = 'sheriff',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'sheriff',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_sheriffjob:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksSHERIFFMenu()
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

	ESX.TriggerServerCallback('esx_sheriffjob:getArmoryWeapons', function(weapons)
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
			title    = _U('get_weapon_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('esx_sheriffjob:removeArmoryWeapon', function()
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
		title    = _U('put_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('esx_sheriffjob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

	end, function(data, menu)
		menu.close()
	end)
end
