ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('cshop:acheter')
AddEventHandler('cshop:acheter', function(item, prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= prix then
		xPlayer.addWeapon(item, 42)
		xPlayer.removeMoney(prix)
	else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
	end
end)

RegisterServerEvent('cshop:acheteritem')
AddEventHandler('cshop:acheteritem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
        if playerMoney >= (item.Price * count) then
    xPlayer.addInventoryItem(item.Value, count)
    xPlayer.removeMoney(item.Price * count)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~g~" ..count..  " "  ..item.Label.. "~s~ pour ~g~" ..item.Price * count .. "$")
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)
