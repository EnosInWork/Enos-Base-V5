ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ammu', 'alerte ammu', true, true)

TriggerEvent('esx_society:registerSociety', 'ammu', 'ammu', 'society_ammu', 'society_ammu', 'society_ammu', {type = 'public'})

RegisterServerEvent('prendreitems')
AddEventHandler('prendreitems', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
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


RegisterNetEvent('stockitem')
AddEventHandler('stockitem', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "objet déposé "..count.." "..inventoryItem.label.."")
        else
            TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
        end
    end)
end)


ESX.RegisterServerCallback('inventairejoueur', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('prendreitem', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('prendre:armurerie')
AddEventHandler('prendre:armurerie', function(arme, prix)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local price = prix
local xMoney = xPlayer.getMoney()

if xMoney >= price then
xPlayer.removeMoney(price)
xPlayer.addWeapon(arme, 42)
TriggerClientEvent('esx:showNotification', source, "Vous avez reçu votre arme pour ~g~"..price.."$")
else
TriggerClientEvent('esx:showNotification', source, "Il vous manque ~r~"..price.."$")
end
end)

-----

RegisterServerEvent('ammuouvert')
AddEventHandler('ammuouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Informations', 'L\'Ammu-Nation est ouvert', 'CHAR_AMMUNATION', 2)
	end
end)

RegisterServerEvent('ammuferme')
AddEventHandler('ammuferme', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Informations', 'L\'Ammu-Nation est fermé', 'CHAR_AMMUNATION', 2)
	end
end)

RegisterServerEvent('ammurecrute')
AddEventHandler('ammurecrute', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Recrutement', 'L\'Ammu-Nation recrute ! Presentez vous à l\'acceuil du batiment', 'CHAR_AMMUNATION', 8)
	end
end)