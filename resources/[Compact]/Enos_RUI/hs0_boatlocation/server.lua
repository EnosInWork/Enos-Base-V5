ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_boatlocation:boat')
AddEventHandler('hs0_boatlocation:boat', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~bateau ~s~!")

end)

