ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterServerEvent('haciadmin:addpermis')
AddEventHandler('haciadmin:addpermis', function(permis)
	local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
        ['@type'] = permis,
        ['@owner'] = xPlayer.identifier
    })
end)

RegisterServerEvent('autoecole:buypermis')
AddEventHandler('autoecole:buypermis', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.removeMoney(100)
end)