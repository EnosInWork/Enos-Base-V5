ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'biker', 'alerte concess moto', true, true)

TriggerEvent('esx_society:registerSociety', 'biker', 'Concessionnaire', 'society_biker', 'society_biker', 'society_biker', {type = 'public'})


ESX.RegisterServerCallback('bike_concess:recuperercategorievehicule', function(source, cb)
    local catevehi = {}

    MySQL.Async.fetchAll('SELECT * FROM biker_categories', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(catevehi, {
                name = result[i].name,
                label = result[i].label
            })
        end

        cb(catevehi)
    end)
end)

ESX.RegisterServerCallback('bike_concess:recupererlistevehicule', function(source, cb, categorievehi)
    local catevehi = categorievehi
    local listevehi = {}

    MySQL.Async.fetchAll('SELECT * FROM biker WHERE category = @category', {
        ['@category'] = catevehi
    }, function(result)
        for i = 1, #result, 1 do
            table.insert(listevehi, {
                name = result[i].name,
                model = result[i].model,
                price = result[i].price
            })
        end

        cb(listevehi)
    end)
end)

ESX.RegisterServerCallback('bike_concess:verifierplaquedispo', function (source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)

RegisterServerEvent('bike_concess:vendrevoiturejoueur')
AddEventHandler('bike_concess:vendrevoiturejoueur', function (playerId, vehicleProps, prix)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_biker', function (account)
            account.removeMoney(prix)
    end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function (rowsChanged)
    TriggerClientEvent('esx:showNotification', xPlayer, "Tu as reçu la voiture ~g~"..nom.."~s~ immatriculé ~g~"..plaque.." pour ~g~" ..prix.. "$")
    end)
end)

RegisterServerEvent('shopbike:vehicule')
AddEventHandler('shopbike:vehicule', function(vehicleProps, prix)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_concess', function (account)
        account.removeMoney(prix)
end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
        TriggerClientEvent('esx:showNotification', xPlayer, "Tu as reçu la voiture ~g~"..nom.."~s~ immatriculé ~g~"..plaque.." pour ~g~" ..prix.. "$")
    end)
end)


ESX.RegisterServerCallback('bike_concess:verifsousconcess', function(source, cb, prixvoiture)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_biker', function (account)
        if account.money >= prixvoiture then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('OpenM:Ads')
AddEventHandler('OpenM:Ads', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concess Moto', '~b~Annonce', 'Le Concess moto est désormais ~g~Ouvert~s~ !', 'CHAR_CARSITE', 8)
	end
end)

RegisterServerEvent('CloseM:Ads')
AddEventHandler('CloseM:Ads', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concess Moto', '~b~Annonce', 'Le Concess moto est désormais ~r~Fermer~s~ !', 'CHAR_CARSITE', 8)
	end
end)

RegisterCommand('moto', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "biker" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concess-Moto', '~b~Annonce', ''..msg..'', 'CHAR_CARSITE', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'est pas concessionnaire moto pour faire cette commande', 'CHAR_CARSITE', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'est pas concessionnaire moto pour faire cette commande', 'CHAR_CARSITE', 0)
end
end, false)