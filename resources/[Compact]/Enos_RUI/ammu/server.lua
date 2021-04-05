ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('weaponshops:giveWeapon')
AddEventHandler('weaponshops:giveWeapon', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= (item.Price) then
        if not xPlayer.hasWeapon(item.Value) or item.Value == "WEAPON_BALL" then
        xPlayer.addWeapon(item.Value, 20)
        xPlayer.removeMoney(item.Price)
        else
            TriggerClientEvent('esx:showNotification', source, '~r~Vous avez déjà cette arme sur vous')
        end

    else
		TriggerClientEvent('esx:showNotification', source, 'Vous ne pouvez pas acheter ~g~1x ' .. item.Label .. '~s~' .. ' il vous manque ' .. '~r~' .. item.Price - playerMoney .. '$')
    end
end)

RegisterNetEvent('item:acheter')
AddEventHandler('item:acheter', function(item, prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= prix then
		xPlayer.addInventoryItem(item, 1)
		xPlayer.removeMoney(prix)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")
	end
end)


