ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

------------------------------------------------------------Shops-----------------------------------------------------------------

RMenu.Add('example', 'main', RageUI.CreateMenu("E.M.S", "Pharmacie"))

------ Variable Sous Menu

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('example', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Kit de soin", "Continue a sauvé des vies !", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('kaiiroz:BuyKit')
                end
            end)
            RageUI.ButtonWithStyle("Bandage", "Continue a sauvé des vies !", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('kaiiroz:BuyBandage')
                end
            end)
        end, function()
        end)

        Citizen.Wait(0)
    end
end)



--------------------------------------- Position du Menu --------------------------------------------

local position = {
    {x = 311.54, y = -563.98, z = 43.28 }
}
    
    
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
    
        for k in pairs(position) do
    
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
            if dist <= 1.0 then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance'  then
                RageUI.Text({
                    message = "Appuyez sur ~r~[E] ~w~pour ouvrir la ~r~Pharmacie",
                    time_display = 1
                })
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('example', 'main'), not RageUI.Visible(RMenu:Get('example', 'main')))
                end
            end
        end
		end
    end
end)

----------------------------------------------------------------------------------
--------------------------- Création du Tuto byKaiiroz ---------------------------
----------------------------------------------------------------------------------