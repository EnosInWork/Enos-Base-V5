ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('biere', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('biere', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_biere'))
end)

---Boissons Jobs

---Boissons Bars (unicorn, bahamas)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_vodka'))
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
	TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_rhum'))
end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkTequila', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_mojito'))
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkTequila', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_martini'))
end)

ESX.RegisterUsableItem('whiskycoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_whiskycoca'))
end)