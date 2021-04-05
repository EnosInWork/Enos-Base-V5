ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--/me
RegisterCommand('me', function(source, args)
    local text = "* " .. Languages[Config.language].prefix .. table.concat(args, " ") .. " *"
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)

--Annonce
TriggerEvent('es:addGroupCommand', 'annonce', "admin", function(source, args, user)
	TriggerClientEvent('announce', -1, "~r~Annonce", table.concat(args, " "), 5)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Annoncer un message à l'entiereté du serveur", params = {{name = "announcement", help = "Message de l'annonce"}}})

--Plaquage
RegisterServerEvent('esx_kekke_tackle:tryTackle')
AddEventHandler('esx_kekke_tackle:tryTackle', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_kekke_tackle:getTackled', targetPlayer.source, source)
	TriggerClientEvent('esx_kekke_tackle:playTackle', source)
end)