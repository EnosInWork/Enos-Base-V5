ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buy:buy')
AddEventHandler('buy:buy', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 500
    xPlayer.removeMoney(price)
end)