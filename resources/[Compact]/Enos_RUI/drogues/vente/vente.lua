ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

Config              = {}
Config.DrawDistance = 50
Config.Size         = {x = 1.0, y = 1.0, z = 1.0}
Config.Color        = {r = 255, g = 0, b = 0}
Config.Type         = 20

local position = {
    {x = 1240.06, y = -3239.09,  z = 6.03}        
}  

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < Config.DrawDistance) then
                DrawMarker(Config.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('vente', 'main', RageUI.CreateMenu("Drogues", "Vente"))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('vente', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Vendre pochon de weed", nil, {RightLabel = "~r~25$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('sellweedpooch')
                end
            end)


            RageUI.ButtonWithStyle("Vendre pochon de meth", nil, {RightLabel = "~r~30$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('sellmethpooch')
                end
            end)


            RageUI.ButtonWithStyle("Vendre pochon de coke", nil, {RightLabel = "~r~38$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('sellcokepooch')
                end
            end)

            RageUI.ButtonWithStyle("Vendre pochon d'opium", nil, {RightLabel = "~r~40$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('sellopiumpooch')
                end
            end)

            RageUI.ButtonWithStyle("Vendre pochon d'LSD", nil, {RightLabel = "~r~45$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('selllsdpooch')
                end
            end)

            RageUI.ButtonWithStyle("Vendre pochon d'ecstasy", nil, {RightLabel = "~r~50$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('sellecstasypooch')
                end
            end)


        end, function()
        end)

        Citizen.Wait(0)
    end
end)



Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~r~E~w~] pour accéder à la vente de drogue")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('vente', 'main'), not RageUI.Visible(RMenu:Get('vente', 'main')))
                    end   
                end
            end
        end
    end)
