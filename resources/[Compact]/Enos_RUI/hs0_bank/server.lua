ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("hs0_bank:deposer")
AddEventHandler("hs0_bank:deposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez deposé ~g~"..total.."$~s~ à la banque !", 'CHAR_BANK_FLEECA', 10)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end) 

RegisterServerEvent("hs0_bank:retirer")
AddEventHandler("hs0_bank:retirer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getBank()
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez retiré ~g~"..total.."$~s~ de la banque !", 'CHAR_BANK_FLEECA', 10)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end) 

RegisterServerEvent("hs0_bank:solde") 
AddEventHandler("hs0_bank:solde", function(action, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerMoney = xPlayer.getBank()

    TriggerClientEvent("hs0_bank:solderefresh", source, playerMoney)
end)