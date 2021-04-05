ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('kevlar', function (source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('kevlar', 1)

    TriggerClientEvent('cosasvariadas:kevlar', source)

end)