ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('RubyMenu:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
	cb(group)
end)

RegisterServerEvent("Administration:GiveCash")
AddEventHandler("Administration:GiveCash", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addMoney((total))

    local item = '~g~$ en liquide.'
    local message = '~g~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

RegisterServerEvent("Administration:GiveBanque")
AddEventHandler("Administration:GiveBanque", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addAccountMoney('bank', total)

    local item = '~b~$ en banque.'
    local message = '~b~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

RegisterServerEvent("Administration:GiveND")
AddEventHandler("Administration:GiveND", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addAccountMoney('black_money', total)

    local item = '~r~$ d\'argent sale.'
    local message = '~r~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message..total..item)
end)

RegisterNetEvent("hAdmin:Message")
AddEventHandler("hAdmin:Message", function(id, type)
	TriggerClientEvent("hAdmin:envoyer", id, type)
end)