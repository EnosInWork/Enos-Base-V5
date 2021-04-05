ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

ConfOrange = {}

ConfOrange.EnableBlips = true

ConfOrange.Zones = {
    { x = 354.65, y = 6517.87, z = 28.26},
    { x = 2059.47, y = 4841.28, z = 41.82},
    { x = -1500.24, y = -892.45, z = 10.107}
}

ConfOrange.Blip = {
    Sprite  = 1,
    Display = 4,
    Scale   = 0.85,
    Colour  = 17,
    Text = "Circuit d'Orange"
}


RMenu.Add('orange', 'recolte', RageUI.CreateMenu("Orange", "Récolte"))
RMenu.Add('orange', 'traitement', RageUI.CreateMenu("Orange", "Emballage"))
RMenu.Add('orange', 'vente', RageUI.CreateMenu("Orange", "Vente"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('orange', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter des Oranges", " ", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        notify('~g~Récolte d\'Oranges en cours')
            FreezeEntityPosition(GetPlayerPed(-1),true) 
            Wait(5000)
            TriggerServerEvent('recoOrange')
            FreezeEntityPosition(GetPlayerPed(-1),false) 
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('orange', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre Oranges en Sachet", " ", {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            notify('~g~Emaballage des Oranges en cours')
           FreezeEntityPosition(GetPlayerPed(-1),true)
            Wait(7000)
            TriggerServerEvent('schOrange')
           FreezeEntityPosition(GetPlayerPed(-1),false) 
                        end
                    end)
                end, function()
                end)

                    RageUI.IsVisible(RMenu:Get('orange', 'vente'), true, true, true, function()

                        RageUI.ButtonWithStyle("Vendre mes Sachets", " ", {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                notify('~g~Vente de vos sachets en cours')
            FreezeEntityPosition(GetPlayerPed(-1),true)
            Wait(2000)
            TriggerServerEvent('vendreOrange')
            FreezeEntityPosition(GetPlayerPed(-1),false)
                            end
                        end)
                        
            end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)



    ---------------------------------------- Position du Menu --------------------------------------------

    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            Wait(0)
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                if IsEntityAtCoord(PlayerPedId(), 354.65, 6517.87, 28.26, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    
                          RageUI.Text({
                            message = "[~b~E~w~] Récolter des ~o~Oranges",
                            time_display = 1
                        })
                            if IsControlJustPressed(1, 51) then
                                RageUI.Visible(RMenu:Get('orange', 'recolte'), not RageUI.Visible(RMenu:Get('orange', 'recolte')))
                            end
                        end
                    end    
            end)
    
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), 2059.47, 4841.28, 41.82, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre en Sachet des ~o~Oranges",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('orange', 'traitement'), not RageUI.Visible(RMenu:Get('orange', 'traitement')))
                                    end
                                end
                            end    
                    end)
    
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        while true do
                            Wait(0)
                    
                                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                                if IsEntityAtCoord(PlayerPedId(), -1500.24, -892.45, 10.107, 1.5, 1.5, 1.5, 0, 1, 0) then 
    
                                          RageUI.Text({
                                            message = "[~b~E~w~] Vente ~o~d'Oranges",
                                            time_display = 1
                                        })
                                            if IsControlJustPressed(1, 51) then
                                                RageUI.Visible(RMenu:Get('orange', 'vente'), not RageUI.Visible(RMenu:Get('orange', 'vente')))
                                            end
                                        end
                                    end    
                            end)
    
            function notify(text)
                SetNotificationTextEntry('STRING')
                AddTextComponentString(text)
                DrawNotification(false, false)
            end
    
            -- Blips
    
    Citizen.CreateThread(function()
    
        if ConfOrange.EnableBlips then
            for _, info in pairs(ConfOrange.Zones) do
                local blip = AddBlipForCoord(info.x, info.y, info.z)
    
                SetBlipSprite(blip, ConfOrange.Blip.Sprite)
                SetBlipDisplay(blip, ConfOrange.Blip.Display)
                SetBlipScale(blip, ConfOrange.Blip.Scale)
                SetBlipColour(blip, ConfOrange.Blip.Colour)
                SetBlipAsShortRange(blip, true)
            
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(ConfOrange.Blip.Text)
                EndTextCommandSetBlipName(blip)
            
            end
        end
    end)