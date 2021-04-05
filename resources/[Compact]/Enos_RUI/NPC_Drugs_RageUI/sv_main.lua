ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)




-- Prix vente weed NPC
local WeedMin = 10
local WeedMax = 20


-- Vente weed
RegisterServerEvent("NPCVente:Weed")
AddEventHandler("NPCVente:Weed", function(num)
    local xPlayer = ESX.GetPlayerFromId(source)
    local nombre = xPlayer.getInventoryItem("weed_pooch")
    local count = 1
    if nombre.count >= num then
        local PrixWeed = math.random(WeedMin,WeedMax)
        local PrixWeedFinal = num * PrixWeed
        xPlayer.removeInventoryItem("weed_pooch", num)
        xPlayer.addMoney(PrixWeedFinal)
        TriggerClientEvent("NPCVente:Notification", source, "Activité illégal", "~g~Vente de weed", "Ouais je t'en prends ~g~"..num.."~w~\nArgent obtenu: ~g~"..PrixWeedFinal, "CHAR_LESTER", 8)
    else
        TriggerClientEvent("NPCVente:Notification", source, "Activité illégal", "~g~Vente de weed", "Ouai cimer je t'en prends ... Attends mais t'essaye de me vendre quoi la ? Ta rien frère ? Casse toi !", "CHAR_LESTER", 8)
    end
end)



-- Prix vente coke NPC
local cokeMin = 20
local cokeMax = 30


-- Vente coke
RegisterServerEvent("NPCVente:coke")
AddEventHandler("NPCVente:coke", function(num)
    local xPlayer = ESX.GetPlayerFromId(source)
    local nombre = xPlayer.getInventoryItem("coke_pooch")
    local count = 1
    if nombre.count >= num then
        local Prixcoke = math.random(cokeMin,cokeMax)
        local PrixcokeFinal = num * Prixcoke
        xPlayer.removeInventoryItem("coke_pooch", num)
        xPlayer.addMoney(PrixcokeFinal)
        TriggerClientEvent("NPCVente:Notification", source, "Activité illégal", "~g~Vente de coke", "Ouais je t'en prends ~g~"..num.."~w~\nArgent obtenu: ~g~"..PrixcokeFinal, "CHAR_LESTER", 8)
    else
        TriggerClientEvent("NPCVente:Notification", source, "Activité illégal", "~g~Vente de coke", "Ouai cimer je t'en prends ... Attends mais t'essaye de me vendre quoi la ? Ta rien frère ? Casse toi !", "CHAR_LESTER", 8)
    end
end)



-- Appel LSPD 



RegisterServerEvent("NPCVente:AppelLSPD")
AddEventHandler("NPCVente:AppelLSPD", function(coords)
    local xPlayers	= ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('NPCVente:AffichageAppel', xPlayers[i], coords)
        end
    end
end)