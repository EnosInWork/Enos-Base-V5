ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('Livre:buyLivre')
AddEventHandler('Livre:buyLivre', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', 50)
end)


RegisterNetEvent('Pc:buyPc')
AddEventHandler('Pc:buyPc', function() 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', 2000)
end)

RegisterNetEvent('Tele:buyTele')
AddEventHandler('Tele:buyTele', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', 5000)
end)

RegisterNetEvent('Telescope:buyTelescope')
AddEventHandler('Telescope:buyTelescope', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', 700)
end)

RegisterNetEvent('Vase:buyVase')
AddEventHandler('Vase:buyVase', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', 200)
end)