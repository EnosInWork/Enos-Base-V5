ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_heliclocation:helico')
AddEventHandler('hs0_heliclocation:helico', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~hélicoptère ~s~!")

end)

