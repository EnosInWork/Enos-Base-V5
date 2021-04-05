ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

ConfShopp = {}

ConfShopp.Shop = {
    Posdeouf = {
        {x = 373.875,   y = 325.896,  z = 103.566},
		{x = 2557.458,  y = 382.282,  z = 108.622},
		{x = -3038.939, y = 585.954,  z = 7.908},
		{x = -3241.927, y = 1001.462, z = 12.830},
		{x = 547.431,   y = 2671.710, z = 42.156},
		{x = 1961.464,  y = 3740.672, z = 32.343},
		{x = 2678.916,  y = 3280.671, z = 55.241},
        {x = 1729.216,  y = 6414.131, z = 35.037},
        {x = 1135.808,  y = -982.281,  z = 46.415},
		{x = -1222.915, y = -906.983,  z = 12.326},
		{x = -1487.553, y = -379.107,  z = 40.163},
		{x = -2968.243, y = 390.910,   z = 15.043},
		{x = 1166.024,  y = 2708.930,  z = 38.157},
        {x = 1392.562,  y = 3604.684,  z = 34.980},
        {x = -48.519,   y = -1757.514, z = 29.421},
		{x = 1163.373,  y = -323.801,  z = 69.205},
		{x = -707.501,  y = -914.260,  z = 19.215},
		{x = -1820.523, y = 792.518,   z = 138.118},
		{x = 1698.388,  y = 4924.404,  z = 42.063},
        {x = 25.82,  y = -1345.22,  z = 29.5},
        {x = -864.2,  y = -2409.29,  z = 14.03},
        {x = 967.74,  y = -1867.96,  z = 31.3}
	},
	
    Apuz = {
        {x = -865.03,  y = -2408.89,  z = 13.03,  a = 237.50},
        {x = 967.78,  y = -1867.07,  z = 30.45,  a = 171.09}
	},

    Items = {

		Manger = {
			{Label = 'Pain', Value = 'pain', Price = 2},
			{Label = 'Chips', Value = 'chips', Price = 3},	
			{Label = 'Hamburger', Value = 'hamburger', Price = 3},
            {Label = 'Saucisson', Value = 'saucisson', Price = 3},
            {Label = 'Pizza', Value = 'pizza', Price = 3},
		},

		Boire = {
			{Label = 'Eau', Value = 'eau', Price = 2},
			{Label = 'Sprite', Value = 'sprite', Price = 3},
            {Label = 'Coca', Value = 'coca', Price = 3},
            {Label = 'Oasis', Value = 'oasis', Price = 3},
            {Label = 'Fanta', Value = 'fanta', Price = 3},
            {Label = 'Ice-Tea', Value = 'icetea', Price = 3},
		},

        Alcool = {
			{Label = 'Whisky', Value = 'whisky', Price = 100},
			{Label = 'Rhum', Value = 'rhum', Price = 100},
		}
    }
}

Citizen.CreateThread(function()
	for k, v in pairs(ConfShopp.Shop.Posdeouf) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		SetBlipSprite(blip, 52)
		SetBlipScale (blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Magasin')
		EndTextCommandSetBlipName(blip)
	end
end)

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- spawn de Apu

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	for k,v in pairs(ConfShopp.Shop.Apuz) do
	ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_shopkeep_01", v.x, v.y, v.z, v.a, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k, v in pairs(ConfShopp.Shop.Posdeouf) do
			local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

            if distance < 5.0 then
                actualZone = v

                zoneDistance = GetDistanceBetweenCoords(playerCoords, actualZone.x, actualZone.y, actualZone.z, true)

				DrawMarker(29, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 16, 192, 37, 100, false, true, 2, false, nil, nil, false)
            end
            
            if distance <= 1.5 then
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour parler à Apu')

                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get('enos_shop', 'main'), not RageUI.Visible(RMenu:Get('enos_shop', 'main')))
                end
            end

            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    RageUI.CloseAll()
                end
            end
		end
	end
end)

local index = {
    items = 1
}

local index2 = {
     items = 1
}

local percent = 100
local a = 255
local nombre = {}

local max = 20 -- number of items that can be selected
Numbers = {}

Citizen.CreateThread(function()
    for i = 1, max do
        table.insert(Numbers, i)
    end
end)

RMenu.Add('enos_shop', 'main', RageUI.CreateMenu("Superette", "Superette"))
RMenu.Add('enos_shop', 'faim', RageUI.CreateSubMenu(RMenu:Get('enos_shop', 'main'), "Superette", "Voici nos produits."))
RMenu.Add('enos_shop', 'soif', RageUI.CreateSubMenu(RMenu:Get('enos_shop', 'main'), "Superette", "Voici nos produits."))
RMenu.Add('enos_shop', 'alcool', RageUI.CreateSubMenu(RMenu:Get('enos_shop', 'main'), "Superette", "Voici nos produits."))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('enos_shop', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Nourritures", nil, {RigtLabel = "→"},true, function()
            end, RMenu:Get('enos_shop', 'faim')) 

			RageUI.ButtonWithStyle("Boissons", nil, {RigtLabel = "→"},true, function()
            end, RMenu:Get('enos_shop', 'soif')) 

            RageUI.ButtonWithStyle("Boissons Alcoolisé", nil, {RigtLabel = "→"},true, function()
            end, RMenu:Get('enos_shop', 'alcool')) 


        end, function()
        end)

		RageUI.IsVisible(RMenu:Get('enos_shop', 'faim'), true, true, true, function()

			for k, v in pairs(ConfShopp.Shop.Items.Manger) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index

                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('enos_shop:giveItem', v, count)
                    end
                end)
            end


        end, function()
        end)

		RageUI.IsVisible(RMenu:Get('enos_shop', 'soif'), true, true, true, function()

			for k, v in pairs(ConfShopp.Shop.Items.Boire) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('enos_shop:giveItem', v, count)
                    end
                end)
            end


        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('enos_shop', 'alcool'), true, true, true, function()

			for k, v in pairs(ConfShopp.Shop.Items.Alcool) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('enos_shop:giveItem', v, count)
                    end
                end)
            end


        end, function()
        end)

        Citizen.Wait(0)
    end
end)

