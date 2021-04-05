ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rcoke')
AddEventHandler('rcoke', function()
    local item = "coke"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tcoke')
AddEventHandler('tcoke', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local coke = xPlayer.getInventoryItem('coke').count
    local coke_pooch = xPlayer.getInventoryItem('coke_pooch').count

    if coke_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de coke .. Vas les vendre')
    elseif coke < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de coke pour traiter')
    else
        xPlayer.removeInventoryItem('coke', 5)
        xPlayer.addInventoryItem('coke_pooch', 1)    
    end
end)

RegisterNetEvent('rmeth')
AddEventHandler('rmeth', function()
    local item = "meth"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tmeth')
AddEventHandler('tmeth', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local meth = xPlayer.getInventoryItem('meth').count
    local meth_pooch = xPlayer.getInventoryItem('meth_pooch').count

    if meth_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de meth .. Vas les vendre')
    elseif meth < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de meth pour traiter')
    else
        xPlayer.removeInventoryItem('meth', 5)
        xPlayer.addInventoryItem('meth_pooch', 1)    
    end
end)

RegisterNetEvent('ropium')
AddEventHandler('ropium', function()
    local item = "opium"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('topium')
AddEventHandler('topium', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local opium = xPlayer.getInventoryItem('opium').count
    local opium_pooch = xPlayer.getInventoryItem('opium_pooch').count

    if opium_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets d\'opium .. Vas les vendre')
    elseif opium < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'opium pour traiter')
    else
        xPlayer.removeInventoryItem('opium', 5)
        xPlayer.addInventoryItem('opium_pooch', 1)    
    end
end)

RegisterNetEvent('rweed')
AddEventHandler('rweed', function()
    local item = "weed"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tweed')
AddEventHandler('tweed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local weed = xPlayer.getInventoryItem('weed').count
    local weed_pooch = xPlayer.getInventoryItem('weed_pooch').count

    if weed_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de weed .. Vas les vendre')
    elseif weed < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de weed pour traiter')
    else
        xPlayer.removeInventoryItem('weed', 5)
        xPlayer.addInventoryItem('weed_pooch', 1)    
    end
end)

RegisterNetEvent('recstasy')
AddEventHandler('recstasy', function()
    local item = "ecstasy"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tecstasy')
AddEventHandler('tecstasy', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ecstasy = xPlayer.getInventoryItem('ecstasy').count
    local ecstasy_pooch = xPlayer.getInventoryItem('ecstasy_pooch').count

    if ecstasy_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets d\'ecstasy .. Vas les vendre')
    elseif ecstasy < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ecstasy pour traiter')
    else
        xPlayer.removeInventoryItem('ecstasy', 5)
        xPlayer.addInventoryItem('ecstasy_pooch', 1)    
    end
end)

RegisterNetEvent('rlsd')
AddEventHandler('rlsd', function()
    local item = "lsd"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tlsd')
AddEventHandler('tlsd', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local lsd = xPlayer.getInventoryItem('lsd').count
    local lsd_pooch = xPlayer.getInventoryItem('lsd_pooch').count

    if lsd_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de LSD .. Vas les vendre')
    elseif lsd < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de LSD pour traiter')
    else
        xPlayer.removeInventoryItem('lsd', 5)
        xPlayer.addInventoryItem('lsd_pooch', 1)    
    end
end)

-------------------------------------------------------- Vente

RegisterServerEvent('sellweedpooch')
AddEventHandler('sellweedpooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local weedpooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "weed_pooch" then
			weedpooch = item.count
		end
	end
    
    if weedpooch > 0 then
        xPlayer.removeInventoryItem('weed_pooch', 1)
        xPlayer.addAccountMoney('black_money', 25)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)

RegisterServerEvent('sellmethpooch')
AddEventHandler('sellmethpooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local methpooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "meth_pooch" then
			methpooch = item.count
		end
	end
    
    if methpooch > 0 then
        xPlayer.removeInventoryItem('meth_pooch', 1)
        xPlayer.addAccountMoney('black_money', 30)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)

RegisterServerEvent('sellcokepooch')
AddEventHandler('sellcokepooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local cokepooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "coke_pooch" then
			cokepooch = item.count
		end
	end
    
    if cokepooch > 0 then
        xPlayer.removeInventoryItem('coke_pooch', 1)
        xPlayer.addAccountMoney('black_money', 38)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)

RegisterServerEvent('sellopiumpooch')
AddEventHandler('sellopiumpooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local opiumpooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "opium_pooch" then
			opiumpooch = item.count
		end
	end
    
    if opiumpooch > 0 then
        xPlayer.removeInventoryItem('opium_pooch', 1)
        xPlayer.addAccountMoney('black_money', 40)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)

RegisterServerEvent('selllsdpooch')
AddEventHandler('selllsdpooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local lsdpooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "lsd_pooch" then
			lsdpooch = item.count
		end
	end
    
    if lsdpooch > 0 then
        xPlayer.removeInventoryItem('lsd_pooch', 1)
        xPlayer.addAccountMoney('black_money', 45)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)


RegisterServerEvent('sellecstasypooch')
AddEventHandler('sellecstasypooch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ecstasypooch = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ecstasy_pooch" then
			ecstasypooch = item.count
		end
	end
    
    if ecstasypooch > 0 then
        xPlayer.removeInventoryItem('ecstasy_pooch', 1)
        xPlayer.addAccountMoney('black_money', 50)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Dégage d\'ici si ta rien. Boloss')
    end
end)

