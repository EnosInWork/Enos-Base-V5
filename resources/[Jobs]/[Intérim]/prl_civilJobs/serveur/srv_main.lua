ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent("ori_jobs:pay")
AddEventHandler("ori_jobs:pay", function(money)
    if money < 1000 then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(money)
    else
        print("RUBY-SYNC | SYNCHRONISATION PERDU AVEC LE SERVEUR DU A UNE TENTATIVE DE TRICHE - MERCI DE RETIRER TOUT LOGICIEL DE TRICHE DE VOTRE JEU AVEC DE VENIR SUR LE SERVEUR")
    end
end)

RegisterNetEvent('BuyAbatteur')
AddEventHandler('BuyAbatteur', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.setJob("slaughterer", 0)
        TriggerClientEvent('esx:showNotification', source, "~b~Félicitation~w~ ! Vous êtes embauché chez les ~b~Abatteurs~w~ en tant que ~g~Intérimaire.")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('BuyCouturier')
AddEventHandler('BuyCouturier', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.setJob("tailor", 0)
        TriggerClientEvent('esx:showNotification', source, "~b~Félicitation~w~ ! Vous êtes embauché chez les ~b~Couturiers~w~ en tant que ~g~Intérimaire.")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('BuyPecheur')
AddEventHandler('BuyPecheur', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.setJob("fisherman", 0)
        TriggerClientEvent('esx:showNotification', source, "~b~Félicitation~w~ ! Vous êtes embauché chez les ~b~Pêcheurs~w~ en tant que ~g~Intérimaire.")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('BuyRaffineur')
AddEventHandler('BuyRaffineur', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.setJob("fueler", 0)
        TriggerClientEvent('esx:showNotification', source, "~b~Félicitation~w~ ! Vous êtes embauché chez les ~b~Raffineurs~w~ en tant que ~g~Intérimaire.")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('BuyChomeur')
AddEventHandler('BuyChomeur', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.setJob("unemployed", 0)
        TriggerClientEvent('esx:showNotification', source, "Vous êtes un ~r~chômeur")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)