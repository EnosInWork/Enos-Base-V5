ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('reward')
AddEventHandler('reward', function(reward)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addMoney(reward)
    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez gagnez "..reward.."$")
end)