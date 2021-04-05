local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker = true, false, false
ESX = nil


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLenght)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLenght)
	blockinput = true
    while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do
        DisableAllControlActions(0)
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		return GetOnscreenKeyboardResult()
	else
		return nil
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		Config.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('esx_property:sendProperties')
AddEventHandler('esx_property:sendProperties', function(properties)
	Config.Properties = properties
	CreateBlips()

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

function CreateBlips()
	for i=1, #Config.Properties, 1 do
		local property = Config.Properties[i]

		if property.entering then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 350)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 0.70)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function GetProperties()
	return Config.Properties
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #Config.Properties, 1 do
		local property2 = Config.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].gateway == property.name then
			table.insert(properties, Config.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name ~= name then
			Config.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('esx_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('esx_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #Config.Properties, 1 do
			Config.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
	end

	if owned then
		OwnedProperties[name] = true
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 357)
		SetBlipAsShortRange(Blips[enteringName], true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('property'))
		EndTextCommandSetBlipName(Blips[enteringName])
	else
		OwnedProperties[name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 369)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[enteringName])
		end
	end
end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] == true
end

function OpenPropertyMenu(property)
	RMenu.Add('aSortir', 'menu', RageUI.CreateMenu("Propriété", " "))
	RMenu:Get('aSortir', 'menu').Closed = function()
		aSortir = false
	end  
    if not aSortir then 
        aSortir = true
		RageUI.Visible(RMenu:Get('aSortir', 'menu'), true)

		Citizen.CreateThread(function()
			while aSortir do
				RageUI.IsVisible(RMenu:Get("aSortir",'menu'),true,true,true,function()
					local elements = {}


					if PropertyIsOwned(property) then
					RageUI.ButtonWithStyle("Entrer dans sa propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
						if (Selected) then
							TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
						end
					end)

					if not Config.EnablePlayerManagement then
					RageUI.ButtonWithStyle("Revendre sa propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
						if (Selected) then
							TriggerServerEvent('esx_property:removeOwnedProperty', property.name)
						end
					end)
				end
				else
					if not Config.EnablePlayerManagement then					
						RageUI.ButtonWithStyle("Acheter la propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
						if (Selected) then
							TriggerServerEvent('esx_property:buyProperty', property.name)
						end
					end)
				end
					RageUI.ButtonWithStyle("Visiter la propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
						if (Selected) then
							TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
						end
					end)
				end
				end, function()    
				end, 1)
				Wait(1)
			end
		Wait(0)
		aPropertyMenu = false
		end)
	end
end



function OpenGatewayMenu(property)
	if Config.EnablePlayerManagement then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway', {
			title    = property.name,
			align    = 'top-left',
			elements = {
				{label = _U('owned_properties'),    value = 'owned_properties'},
				{label = _U('available_properties'), value = 'available_properties'}
		}}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end)
	end
end

function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties', {
		title    = property.name .. ' - ' .. _U('owned_properties'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local elements = {
			{label = _U('enter'), value = 'enter'}
		}

		if not Config.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions', {
			title    = data.current.label,
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
				ESX.UI.Menu.CloseAll()
			elseif data2.current.value == 'leave' then
				TriggerServerEvent('esx_property:removeOwnedProperty', data.current.value)
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label .. ' $' .. ESX.Math.GroupDigits(gatewayProperties[i].price),
				value = gatewayProperties[i].name,
				price = gatewayProperties[i].price
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties', {
		title    = property.name .. ' - ' .. _U('available_properties'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions', {
			title    = property.label .. ' - ' .. _U('available_properties'),
			align    = 'top-left',
			elements = {
				{label = _U('buy'), value = 'buy'},
				{label = _U('rent'), value = 'rent'},
				{label = _U('visit'), value = 'visit'}
		}}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'buy' then
				TriggerServerEvent('esx_property:buyProperty', data.current.value)
			elseif data2.current.value == 'rent' then
				TriggerServerEvent('esx_property:rentProperty', data.current.value)
			elseif data2.current.value == 'visit' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

local index = {
    dish = 1;
	dishh = 1;
    dishhh = 1;    
    dishhhh = 1;
    employer = 1;
    panel = {
        percentage = 0.5
    },
}

h4ci_vetement = {
	liste = {},
	tenue = {}
}

function OpenRoomMenu(property, owner)
	RMenu.Add('aProperty', 'menu', RageUI.CreateMenu("Gestion Propriété", " "))
	RMenu.Add('aProperty', 'listetenu', RageUI.CreateSubMenu(RMenu:Get('aProperty', 'menu'), "Garde-Robe", " "))
	RMenu.Add('aProperty', 'optiontenu', RageUI.CreateSubMenu(RMenu:Get('aProperty', 'listetenu'), "Vos Tenues", " "))
	RMenu.Add('aProperty', 'mettre', RageUI.CreateSubMenu(RMenu:Get('aProperty', 'menu'), "Déposer Objet(s)", " "))
	RMenu.Add('aProperty', 'enlever', RageUI.CreateSubMenu(RMenu:Get('aProperty', 'menu'), "Retirer Objet(s)", " "))
	RMenu:Get('aProperty', 'menu').Closed = function()
		aProperty = false
	end  
    if not aProperty then 
        aProperty = true
		RageUI.Visible(RMenu:Get('aProperty', 'menu'), true)

		Citizen.CreateThread(function()
			while aProperty do
				RageUI.IsVisible(RMenu:Get("aProperty",'menu'),true,true,true,function()
					local plyData = ESX.GetPlayerData()
					RageUI.ButtonWithStyle("Inviter un joueur", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)

						if (Selected) then
							TriggerEvent('instance:invite', 'property', GetPlayerServerId(data2.current.value), {property = property.name, owner = owner})
						end
					end)
                    RageUI.ButtonWithStyle("Garde-Robe", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered,Active,Selected)
                    end, RMenu:Get('aProperty', 'listetenu'))





					RageUI.ButtonWithStyle("Déposer un objet"  , nil, {RightLabel = "~b~Déposer~s~ →→"}, true, function(Hovered, Active, Selected)
						if Selected then
							invItems = {}
							ESX.TriggerServerCallback('property:getPlayerInventory', function(inventory)
								for i=1, #inventory.items, 1 do
									local item = inventory.items[i]
									--local weightitem = item.weight
									--local weight = weightitem * item.weight
									if item.count > 0 then
										table.insert(invItems, {label = '[~r~' .. item.count ..'~w~] | '.. item.label..''  , type = 'item_standard', value = item.name})
									end
								end                                  
							end)
						end
					end,RMenu:Get('aProperty', 'mettre'))
		
					RageUI.ButtonWithStyle("Retirer un objet"  , nil, {RightLabel = "~b~Retirer~s~ →→"}, true, function(Hovered, Active, Selected)
						if Selected then
							Items = {}
							Itemss = {}
							Itemsss = {}
							ESX.TriggerServerCallback('property:getStockItems', function(inventory)
								for i=1, #inventory.items, 1 do
			
									local item = inventory.items[i]
			
									if item.count > 0 then
										table.insert(Items, {label = '[~r~' .. item.count ..'~w~] | '.. item.label..''  , type = 'item_standard', value = item.name})
									end
								end
								for i=1, #inventory.weapons, 1 do
									local weapon = inventory.weapons[i]				
									table.insert(Itemsss, { label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type  = 'item_weapon', value = weapon.name, index = i })
								end
							end)
						end
					end,RMenu:Get('aProperty', 'enlever'))
					
				end, function()
				end)
			
				RageUI.IsVisible(RMenu:Get('aProperty', 'mettre'), true, true, true, function()
					RageUI.Separator("↓ ~y~Inventaire ~s~↓")					
					for k,v in pairs(invItems) do
						RageUI.ButtonWithStyle(v.label  , nil, {RightLabel = count}, true, function(Hovered, Active, Selected)
							if Selected then
		
								local itemName = v.value
								local result = tonumber(KeyboardInput("Quantité:", "", "", 6))
								if not result then
									ESX.ShowNotification('Quantité invalide')							
								else
									TriggerServerEvent('property:putStockItems',v.type , itemName, result)
									RageUI.GoBack()
								end
							end
						end)
					end
				end, function()
				end)
				RageUI.IsVisible(RMenu:Get('aProperty', 'enlever'), true, true, true, function()
					RageUI.Separator("↓ ~g~Contenu du coffre~s~ ↓")
					for k,v in pairs(Items) do
						RageUI.ButtonWithStyle(v.label  , nil, {RightLabel = count}, true, function(Hovered, Active, Selected)
							if Selected then
								local itemName = v.value
								local result = tonumber(KeyboardInput("Quantité:", "", "", 6))
								if not result then
									ESX.ShowNotification('Quantité invalide')							
								else
									TriggerServerEvent('property:getStockItem',v.type , itemName, result)
									RageUI.GoBack()
								end
							end
						end)
					end

				end, function()    
				end, 1)
				
					RageUI.IsVisible(RMenu:Get('aProperty', 'listetenu'), true, true, true, function() 

						ESX.TriggerServerCallback('h4ci_vetement:affichertenu', function(tenue)
							h4ci_vetement.liste = tenue
						end)
						for i = 1, #h4ci_vetement.liste, 1 do
						RageUI.ButtonWithStyle(h4ci_vetement.liste[i].nom, nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then 
						tenuchoisi = h4ci_vetement.liste[i]
						end
						end, RMenu:Get('aProperty', 'optiontenu'))
						end

					end, function()    
					end, 1)

					RageUI.IsVisible(RMenu:Get('aProperty', 'optiontenu'), true, true, true, function() 
						RageUI.ButtonWithStyle("Nom de la tenue : "..tenuchoisi.nom, nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						end
						end)
						RageUI.ButtonWithStyle("Mettre la tenue", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerEvent('skinchanger:loadClothes', skin, json.decode(tenuchoisi.contenu))
									TriggerEvent('skinchanger:getSkin', function(skin)
									TriggerServerEvent('esx_skin:save', skin)
									TriggerEvent("FeedM:showAdvancedNotification", "aServer", "~r~Notification", "Tenue changé avec succès !", "CHAR_STRETCH", Interval, Type)
								end)
							end)
						end
						end)
						RageUI.ButtonWithStyle("Changer le nom de la tenue", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							local nouveaunom = KeyboardInput("Choisir un nom pour la tenue : ", "", 15)
							TriggerServerEvent('h4ci_vetement:renommertenu', nouveaunom, tenuchoisi.id)
							RageUI.GoBack()
							ESX.TriggerServerCallback('h4ci_vetement:affichertenu', function(tenue)
								h4ci_vetement.liste = tenue
							end)
						end
						end)

						RageUI.ButtonWithStyle("Supprimer la tenue", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
							if (Selected) then   
								TriggerServerEvent('h4ci_vetement:supprimertenu', tenuchoisi.id)
								RageUI.GoBack()
								ESX.TriggerServerCallback('h4ci_vetement:affichertenu', function(tenue)
									h4ci_vetement.liste = tenue
								end)
							end
							end)

				end, function()    
				end, 1)
				Wait(1)
			end
		Wait(0)
		aProperty = false
		end)
	end
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('playerSpawned', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('esx_property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])
				
							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(0)
							end
						end

						TriggerEvent('instance:create', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)

AddEventHandler('esx_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('esx_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('esx_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('esx_property:setPropertyOwned')
AddEventHandler('esx_property:setPropertyOwned', function(name, owned)
	SetPropertyOwned(name, owned)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('esx_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		if property.isSingle then
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = _U('press_to_exit')
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep = false, true
		local currentProperty, currentPart

		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]

			-- Entering
			if property.entering and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, property.entering.x, property.entering.y, property.entering.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and hasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('esx_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_property:hasExitedMarker', LastProperty, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
				elseif CurrentAction == 'gateway_menu' then
					if Config.EnablePlayerManagement then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
