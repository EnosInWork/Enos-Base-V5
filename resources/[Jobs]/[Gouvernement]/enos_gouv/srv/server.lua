ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'gouv', 'alerte gouv', true, true)

TriggerEvent('esx_society:registerSociety', 'gouv', 'Police', 'society_gouv', 'society_gouv', 'society_gouv', {type = 'public'})

RegisterNetEvent('egouv_gouv:equipementbase')
AddEventHandler('egouv_gouv:equipementbase', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local price = 500
local xMoney = xPlayer.getMoney()
local identifier
	local steam
	local playerId = source
	local PcName = GetPlayerName(playerId)
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			steam = string.sub(v, 7)
			break
		end
	end

if xMoney >= price then
xPlayer.removeMoney(price)
xPlayer.addWeapon('WEAPON_NIGHTSTICK', 42)
xPlayer.addWeapon('WEAPON_STUNGUN', 42)
xPlayer.addWeapon('WEAPON_FLASHLIGHT', 42)
TriggerClientEvent('esx:showNotification', source, "Vous avez reçu votre ~b~équipement de base ! ~r~-"..price.."$")
TriggerEvent('Ise_Logs', 3447003, "gouv Armurerie", "Nom : "..PcName..".\nLicense : license:"..identifier.."\nSteam : steam:"..steam.."\nA acheté l'équipement de base.")
else
TriggerClientEvent('esx:showNotification', source, "C'est la hess, il vous manque ~r~"..price.."$, ~w~aller gratter à vos supérieurs.")
end
end)

RegisterNetEvent('egouv_gouv:armurerie')
AddEventHandler('egouv_gouv:armurerie', function(arme, prix)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local price = prix
local xMoney = xPlayer.getMoney()

if xMoney >= price then
xPlayer.removeMoney(price)
xPlayer.addWeapon(arme, 42)
TriggerClientEvent('esx:showNotification', source, "Vous avez reçu votre ~b~"..arme.." ! ~r~-"..price.."$")
else
TriggerClientEvent('esx:showNotification', source, "C'est la hess, il vous manque ~r~"..price.."$, ~w~aller gratter à vos supérieurs.")
end
end)


RegisterServerEvent('egouv_gouv:prendreitems')
AddEventHandler('egouv_gouv:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouv', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('egouv_gouv:stockitem')
AddEventHandler('egouv_gouv:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouv', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('egouv_gouv:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('egouv_gouv:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouv', function(inventory)
		cb(inventory.items)
	end)
end)

------------------------------------------------ Intéraction


RegisterServerEvent('esx_gouv:handcuff')
AddEventHandler('esx_gouv:handcuff', function(target)
  TriggerClientEvent('esx_gouv:handcuff', target)
end)

RegisterServerEvent('esx_gouv:drag')
AddEventHandler('esx_gouv:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_gouv:drag', target, _source)
end)

RegisterServerEvent('esx_gouv:putInVehicle')
AddEventHandler('esx_gouv:putInVehicle', function(target)
  TriggerClientEvent('esx_gouv:putInVehicle', target)
end)

RegisterServerEvent('esx_gouv:OutVehicle')
AddEventHandler('esx_gouv:OutVehicle', function(target)
    TriggerClientEvent('esx_gouv:OutVehicle', target)
end)

-------------------------------- Fouiller

RegisterNetEvent('esx_gouv:confiscatePlayerItem')
AddEventHandler('esx_gouv:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				sourceXPlayer.showNotification(_U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			else
				sourceXPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)

		-- does the target player have enough money?
		if targetAccount.money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
			targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end

		-- does the target player have weapon?
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName, amount)
			sourceXPlayer.addWeapon   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
			targetXPlayer.showNotification(_U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end
	end
end)

ESX.RegisterServerCallback('esx_gouv:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification('being_searched')
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		
			cb(data)
		
	end
end)