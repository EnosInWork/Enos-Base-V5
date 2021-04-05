ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("boutique:getpoints")
AddEventHandler("boutique:getpoints", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
	local _source = source
    if id_system_l_o_s == "steam" then
    license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
    license = ESX.GetIdentifierFromId(source)
    end
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = license
	}, function(data)
		local poi = data[1].fivecoin
		TriggerClientEvent('boutique:retupoints', _source, poi)
	end)
end
end)

RegisterCommand("givedonate", function(source, args, raw)
    local id    = args[1]
    local point = args[2]
    local xPlayer = ESX.GetPlayerFromId(id)
    if id_system_l_o_s == "steam" then
        license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(id)
    end
    if source == 0 then 
        TriggerClientEvent('esx:showAdvancedNotification', id, 'Boutique', '', 'Vous avez reçu vos :\n'..point..' '..moneypoints, "", 3)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
            ['@identifier'] = license
        }, function(data)
            local poi = data[1].fivecoin
            npoint = poi + point
    
            MySQL.Async.execute('UPDATE `users` SET `fivecoin`=@point  WHERE identifier=@identifier', {
                ['@identifier'] = license,
                ['@point'] = npoint 
            }, function(rowsChange)
            end)
        end)
    else
        print("Tu ne peut pas faire cette commande ici")
    end
end, false)


RegisterServerEvent('shop:vehiculeboutique')
AddEventHandler('shop:vehiculeboutique', function(vehicleProps, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
    end)
end
end)

RegisterServerEvent('boutique:deltniop')
AddEventHandler('boutique:deltniop', function(point)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
	local _source = source
    if id_system_l_o_s == "steam" then
        license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(source)
    end
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = license
	}, function(data)
        local poi = data[1].fivecoin
        npoint = poi -point

        MySQL.Async.execute('UPDATE `users` SET `fivecoin`=@point  WHERE identifier=@identifier', {
            ['@identifier'] = license,
            ['@point'] = npoint 
        }, function(rowsChange)
        end)
    end)
end
end)


RegisterServerEvent('give:money')
AddEventHandler('give:money', function(w)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
	local _source = source
    xPlayer.addMoney(w)
end
end)

-------------------------------- Armes

ESX.RegisterServerCallback('RedMenu:BuyItem', function(source, cb, item)
    local xPlayer  = ESX.GetPlayerFromId(source)

    --BAT
    if item == "bat" then
       MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].fivecoin >= 250 then
                local newpoint = result[1].fivecoin - 250
                  MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                xPlayer.addWeapon("WEAPON_BAT", 250)
                PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "couteau" then
       MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].fivecoin >= 250 then
                local newpoint = result[1].fivecoin - 250
                MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.getIdentifier() .."'", {}, function() end) 
                xPlayer.addWeapon("WEAPON_KNIFE", 250)  
                PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "hachet" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 250 then
                 local newpoint = result[1].fivecoin - 250
                 MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.getIdentifier() .."'", {}, function() end) 
                 xPlayer.addWeapon("weapon_battleaxe", 250)  
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

     if item == "hachpierre" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 250 then
                 local newpoint = result[1].fivecoin - 250
                 MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.getIdentifier() .."'", {}, function() end) 
                 xPlayer.addWeapon("weapon_stone_hatchet", 250)  
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

    if item == "pistol" then
       MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].fivecoin >= 600 then
                local newpoint = result[1].fivecoin - 600
                  MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                xPlayer.addWeapon("weapon_pistol", 250)
                PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "snspistol" then
       MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].fivecoin >= 500 then
                local newpoint = result[1].fivecoin - 500
                  MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                xPlayer.addWeapon("weapon_snspistol", 250)
                PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "pistolcayo" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 1000 then
                 local newpoint = result[1].fivecoin - 1000
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_gadgetpistol", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

    if item == "vintage" then
       MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].fivecoin >= 1000 then
                local newpoint = result[1].fivecoin - 1000
                  MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                xPlayer.addWeapon("weapon_vintagepistol", 250)
                PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "revomk2" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 1500 then
                 local newpoint = result[1].fivecoin - 1500
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_revolver_mk2", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end
     
    if item == "msmg" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 2000 then
                 local newpoint = result[1].fivecoin - 2000
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_minismg", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end
          
    if item == "msmgmk2" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 2000 then
                 local newpoint = result[1].fivecoin - 2000
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_smg_mk2", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

     if item == "pm" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 2000 then
                 local newpoint = result[1].fivecoin - 2000
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_microsmg", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

     if item == "ak47" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 2500 then
                 local newpoint = result[1].fivecoin - 2500
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_assaultrifle", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

     if item == "sniper" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
             if result[1].fivecoin >= 3000 then
                 local newpoint = result[1].fivecoin - 3000
                   MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
                 xPlayer.addWeapon("weapon_sniperrifle", 250)
                 PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "Five-Boutique", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                 cb(true)         
             else
                 cb(false)
             end
         end)    
     end

------------------------------------------------------------------ Début VéHICULES 

if item == "rmodbugatti" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodbolide" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodcharger69" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodf12tdf" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodf40" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodgt63" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodgtr50" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodjeep" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodm5e34" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodmk7" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodskyline34" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end

 if item == "rmodzl1" then
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
         if result[1].fivecoin >= 1000 then
             local newpoint = result[1].fivecoin - 1000
               MySQL.Async.execute("UPDATE `users` SET `fivecoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
             PerformHttpRequest('https://discord.com/api/webhooks/804717273582796831/0cJZoMgaBHiBeG61auYPfW1vS40OKHphvmri27VY5j4mJ9vlKOw-F_xlhUaK36IVJv25', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
             cb(true)         
         else
             cb(false)
         end
     end)    
 end
end)


----- Fin véhicules