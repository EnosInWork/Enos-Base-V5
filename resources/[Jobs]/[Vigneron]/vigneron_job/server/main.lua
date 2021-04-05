ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}
local PlayersSelling  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'vigne', 'vigne', true, true)

TriggerEvent('esx_society:registerSociety', 'vigne', 'vigne', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'private'})

local function Harvest(source)

		if PlayersHarvesting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('raisin').count

			if GazBottleQuantity >= 150 then
				TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
			else
				SetTimeout(1800, function()
				xPlayer.addInventoryItem('raisin', 1)
				Harvest(source)
				end)
			end
		end

end

RegisterServerEvent('esx_vignejob:startHarvest')
AddEventHandler('esx_vignejob:startHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~raisin~s~...')
	Harvest(source)
end)




RegisterServerEvent('esx_vignejob:stopCraft')
AddEventHandler('esx_vignejob:stopCraft', function()
	local _source = source
	PlayersCrafting[_source] = false
	PlayersCrafting2[_source] = false
	PlayersCrafting3[_source] = false
	-- Harvest
	PlayersHarvesting[_source] = false
	PlayersHarvesting2[_source] = false
	PlayersHarvesting3[_source] = false
end)


local function Harvest2(source)
	SetTimeout(4000, function()

		if PlayersHarvesting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
			else
				xPlayer.addInventoryItem('fixtool', 1)
				Harvest2(source)
			end
		end

	end)
end

RegisterServerEvent('esx_vignejob:startHarvest2')
AddEventHandler('esx_vignejob:startHarvest2', function()
	local _source = source
	PlayersHarvesting2[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Récupération d\'~b~outils réparation~s~...')
	Harvest2(_source)
end)


local function Harvest3(source)
	SetTimeout(4000, function()

		if PlayersHarvesting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count
			if CaroToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
			else
				xPlayer.addInventoryItem('carotool', 1)
				Harvest3(source)
			end
		end

	end)
end

RegisterServerEvent('esx_vignejob:startHarvest3')
AddEventHandler('esx_vignejob:startHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Récupération d\'~b~outils carosserie~s~...')
	Harvest3(_source)
end)


local function Craft(source)
	SetTimeout(4000, function()

		if PlayersCrafting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('raisin').count
			local GazBottleQuantity = xPlayer.getInventoryItem('vin').count

			if GazBottleQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de bouteille de gaz')
			else
				xPlayer.removeInventoryItem('raisin', 1)
				xPlayer.addInventoryItem('vine', 1)
				xPlayer.addInventoryItem('grand_cru', 1)
				Craft(source)
			end
		end

	end)
end

RegisterServerEvent('esx_vignejob:startCraft')
AddEventHandler('esx_vignejob:startCraft', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Assemblage de ~b~Grand cru~s~...')
	Craft(_source)
end)



local function Craft2(source)
	SetTimeout(4000, function()

		if PlayersCrafting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('raisin').count

			if FixToolQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'outils réparation')
			else
				xPlayer.removeInventoryItem('raisin', 1)
				xPlayer.addInventoryItem('vine', 1)
				Craft2(source)
			end
		end

	end)
end

RegisterServerEvent('esx_vignejob:startCraft2')
AddEventHandler('esx_vignejob:startCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Création de ~b~Vin~s~...')
	Craft2(_source)
end)


local function Craft3(source)

		if PlayersCrafting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('raisin').count

			if CaroToolQuantity <= 1 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de raisin')
			else
				SetTimeout(1800, function()
				xPlayer.removeInventoryItem('raisin', 1)
				xPlayer.addInventoryItem('jus_raisin', 1)
				Craft3(source)
				end)
			end
		end
end

RegisterServerEvent('esx_vignejob:startCraft3')
AddEventHandler('esx_vignejob:startCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Traitement de ~b~raisin~s~...')
	Craft3(_source)
end)


----------------vente

local function Sell(source)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
			if xPlayer.getInventoryItem('jus_raisin').count <= 0 then
				vgn = 0
			else
				vgn = 1
			end

			if vgn == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('jus_raisin').count <= 0 and argent == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_vgn_sale'))
				vgn = 0
				return
				elseif vgn == 1 then
					SetTimeout(1100, function()
						local money = math.random(30,40)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
			end
		end
	end

RegisterServerEvent('esx_vigne:startSell')
AddEventHandler('esx_vigne:startSell', function(zone)

	local _source = source
	
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)

end)

RegisterServerEvent('esx_vigne:stopSell')
AddEventHandler('esx_vigne:stopSell', function()

	local _source = source
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true

end)
RegisterServerEvent('esx_vignejob:getStockItem')
AddEventHandler('esx_vignejob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

--ESX.RegisterServerCallback('esx_vignejob:getStockItems', function(source, cb)
--	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
--		cb(inventory.items)
--	end)
--end)


RegisterServerEvent('esx_vignejob:putStockItems')
AddEventHandler('esx_vignejob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)


--ESX.RegisterServerCallback('esx_vignejob:getPlayerInventory', function(source, cb)

--	local xPlayer    = ESX.GetPlayerFromId(source)
--	local items      = xPlayer.inventory
  
--	cb({
--	  items      = items
--	})
  
 -- end)




RegisterServerEvent('AnnoncebnOuvert')
AddEventHandler('AnnoncebnOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigne', '~p~Vigneron', '~o~Les vigne sont ouvert ! Venez achetez votre vin et jus de raisin !', 'CHAR_SAEEDA', 8)
	end
end)

RegisterServerEvent('AnnoncebnFermer')
AddEventHandler('AnnoncebnFermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigne', '~p~Annonce Vigneron', '~o~Les vignes ferme pour le moment !', 'CHAR_SAEEDA', 8)
	end
end)