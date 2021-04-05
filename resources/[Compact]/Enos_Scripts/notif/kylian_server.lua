ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', ''..name..'', ''..msg..'', 'CHAR_STRETCH', 0)
        end
    end
end, false)

RegisterCommand('ano', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Anonyme', 'Anonyme', ''..msg..'', 'CHAR_ARTHUR', 0)
        end
    end
end, false)


RegisterCommand('lspd', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "police" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LSPD', '~b~Annonce LSPD', ''..msg..'', 'CHAR_ABIGAIL', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~policier pour faire cette commande', 'CHAR_ABIGAIL', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~policier pour faire cette commande', 'CHAR_ABIGAIL', 0)
    end
 end, false)
 
RegisterCommand('mecano', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "mechanic" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'mecano', '~b~Annonce mecano', ''..msg..'', 'CHAR_LS_CUSTOMS', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~mecano pour faire cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~mecano pour faire cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
 end, false)
 
 RegisterCommand('concess', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "cardealer" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'concessionnaire', '~b~Annonce concessionnaire', ''..msg..'', 'CHAR_CARSITE', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~concessionnaire pour faire cette commande', 'CHAR_CARSITE', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~concessionnaire pour faire cette commande', 'CHAR_CARSITE', 0)
    end
 end, false)
 
RegisterCommand('unicorn', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "unicorn" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', '~b~Annonce Unicorn', ''..msg..'', 'CHAR_TANISHA', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~unicorn pour faire cette commande', 'CHAR_TANISHA', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~unicorn pour faire cette commande', 'CHAR_TANISHA', 0)
    end
 end, false)
 
RegisterCommand('bahamas', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "bahama_mamas" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bahamas', '~b~Annonce Bahamas', ''..msg..'', 'CHAR_STRIPPER_PEACH', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~bahamas pour faire cette commande', 'CHAR_STRIPPER_PEACH', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~bahamas pour faire cette commande', 'CHAR_STRIPPER_PEACH', 0)
    end
 end, false)
 
RegisterCommand('taxi', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "taxi" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', '~b~Annonce Taxi', ''..msg..'', 'CHAR_TAXI', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~taxi pour faire cette commande', 'CHAR_TAXI', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~taxi pour faire cette commande', 'CHAR_TAXI', 0)
    end
 end, false)
 
RegisterCommand('vigne', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "vigne" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vignerons', '~b~Annonce Vignerons', ''..msg..'', 'CHAR_CHEF', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~vignerons pour faire cette commande', 'CHAR_CHEF', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~vignerons pour faire cette commande', 'CHAR_CHEF', 0)
    end
 end, false)
 
    RegisterCommand('ems', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "ambulance" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Annonce EMS', ''..msg..'', 'CHAR_WENDY', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~EMS pour faire cette commande', 'CHAR_WENDY', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~EMS pour faire cette commande', 'CHAR_WENDY', 0)
    end
 end, false)
 
 RegisterCommand('gouv', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "gouvernor" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Gouverneur', '~b~Annonce Gouverneur', ''..msg..'', 'CHAR_ANDREAS', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Gouverneur pour faire cette commande', 'CHAR_ANDREAS', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Gouverneur pour faire cette commande', 'CHAR_ANDREAS', 0)
    end
 end, false)
 
 
 
 
    
    
    
    
