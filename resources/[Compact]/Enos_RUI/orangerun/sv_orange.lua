ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('recoOrange')
AddEventHandler('recoOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local orange = xPlayer.getInventoryItem('orange').count

    if orange > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter d\'Oranges!')
    elseif orange < 50 then
        xPlayer.addInventoryItem('orange', 3)
    end
end)

RegisterNetEvent('schOrange')
AddEventHandler('schOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local orange = xPlayer.getInventoryItem('orange').count
    local schorange = xPlayer.getInventoryItem('schorange').count

    if schorange > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets d\'Oranges .. Vas les vendre')
    elseif orange < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'Oranges pour la vente')
    else
        xPlayer.removeInventoryItem('orange', 3)
        xPlayer.addInventoryItem('schorange', 1)    
    end
    end)

RegisterNetEvent('vendreOrange')
AddEventHandler('vendreOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local schorange = xPlayer.getInventoryItem('schorange').count

    if schorange > 0 then
        TriggerClientEvent('esx:showNotification', source, 'Bravo ! Vous avez vendu un Sachet d\'Oranges pour ~w~(~g~30$)')
    xPlayer.removeInventoryItem('schorange', 1)
    xPlayer.addMoney(30)
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Merci d\'avoir vendu et récolter les Oranges !')
    end
end)