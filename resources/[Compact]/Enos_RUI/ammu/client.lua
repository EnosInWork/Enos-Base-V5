ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

ConfAmmu = {
    Posdebz = {
		{x = -3171.70, y = 1087.66, z = 19.83},
		{x = 2567.6, y = 294.3, z = 108.7},
		{x = 22.0, y = -1107.2, z = 29.8},
		{x = 252.3, y = -50.0, z = 69.9},
		{x = -330.2, y = 6083.8, z  =31.4},
		{x = 1693.4, y = 3759.5, z = 34.7},
		{x = -662.1, y = -935.3, z = 21.8}
	},
	
    Apunir = {
		{x = 23.17, y = -1105.32, z = 28.8, a = 160.2},
		{x = -3173.81, y = 1088.71, z = 19.83, a = 246.79},
		{x = -331.92, y = 6085.38, z = 30.45, a = 223.21},
		{x = 1692.01, y = 3761.31, z = 33.70, a = 228.42},
		{x = 2567.77, y = 292.12, z = 107.73, a = 357.27},
		{x = 254.20, y = -50.88, z = 68.94, a = 72.29}
	},

    Type = {

		Blanche = {
			{Label = 'Couteau', Value = 'WEAPON_KNIFE', Price = 150},
			{Label = 'Lampe Torche', Value = 'WEAPON_FLASHLIGHT', Price = 90},
			{Label = 'Batte de baseball', Value = 'WEAPON_BAT', Price = 200},
			{Label = 'Poing américain', Value = 'WEAPON_KNUCKLE', Price = 120}
		},

		Armes = {
			{Label = 'Pistolet Pétoire', Value = 'WEAPON_SNSPISTOL', Price = 5000},
			{Label = 'Tazer', Value = 'WEAPON_STUNGUN', Price = 500}
		}
	}
}

Citizen.CreateThread(function()
	for k, v in pairs(ConfAmmu.Posdebz) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		SetBlipSprite(blip, 110)
		SetBlipScale (blip, 0.75)
		SetBlipColour(blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Armurerie')
		EndTextCommandSetBlipName(blip)
	end
end)

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_ammucity_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	for k,v in pairs(ConfAmmu.Apunir) do
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_ammucity_01", v.x, v.y, v.z, v.a, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k, v in pairs(ConfAmmu.Posdebz) do
			local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

            if distance < 10.0 then
                actualZone = v

                zoneDistance = GetDistanceBetweenCoords(playerCoords, actualZone.x, actualZone.y, actualZone.z, true)

				DrawMarker(29, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)
            end
            
            if distance <= 1.5 then
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l\'armurerie')

                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get('enos_ammu', 'main'), not RageUI.Visible(RMenu:Get('enos_ammu', 'main')))
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


RMenu.Add('enos_ammu', 'main', RageUI.CreateMenu("Ammunation", "Armurerie"))
RMenu.Add('enos_ammu', 'armurerie', RageUI.CreateSubMenu(RMenu:Get('enos_ammu', 'main'), "Armurerie", "Voici nos armes blanche."))
RMenu.Add('enos_ammu', 'aces', RageUI.CreateSubMenu(RMenu:Get('enos_ammu', 'main'), "Armurerie", "Voici nos accessoires."))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('enos_ammu', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Armes blanche", "Pour accéder aux armes.", {RigtLabel = "→"},true, function()
            end, RMenu:Get('enos_ammu', 'armurerie')) 

			RageUI.ButtonWithStyle("Accessoires", "Pour accéder aux accessoires.", {RigtLabel = "→"},true, function()
            end, RMenu:Get('enos_ammu', 'aces')) 


        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('enos_ammu', 'armurerie'), true, true, true, function()

            for k, v in pairs(ConfAmmu.Type.Blanche) do
                RageUI.ButtonWithStyle(v.Label.. ' (Prix: ' .. v.Price .. '$)', nil, { }, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('weaponshops:giveWeapon', v)
                    end
                end)
            end

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('enos_ammu', 'aces'), true, true, true, function()

			RageUI.ButtonWithStyle("Chargeur", nil, {RightLabel = "~g~250$"},true, function(Hovered, Active, Selected)
				if (Selected) then   
					local item = "clip"
					local prix = 250
					TriggerServerEvent('item:acheter', item, prix)
				end
			end)
			RageUI.ButtonWithStyle("Jumelle", nil, {RightLabel = "~g~300$"},true, function(Hovered, Active, Selected)
				if (Selected) then   
					local item = "jumelles"
					local prix = 300
					TriggerServerEvent('item:acheter', item, prix)
				end
			end)
			RageUI.ButtonWithStyle("Kevlar", nil, {RightLabel = "~g~2000$"},true, function(Hovered, Active, Selected)
				if (Selected) then   
					local item = "kevlar"
					local prix = 2000
					TriggerServerEvent('item:acheter', item, prix)
				end
			end)
			
        end, function()
        end)

        Citizen.Wait(0)
    end
end)


