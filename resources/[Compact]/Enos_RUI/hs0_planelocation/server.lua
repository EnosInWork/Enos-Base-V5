ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_planelocation:plane')
AddEventHandler('hs0_planelocation:plane', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~avion ~s~!")

end)

