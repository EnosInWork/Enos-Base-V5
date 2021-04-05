ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('blowtorch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('blowtorch')

    xPlayer.removeInventoryItem('blowtorch', 1)
    TriggerClientEvent('esx_blowtorch:startblowtorch', source)
end)

