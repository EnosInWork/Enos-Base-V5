ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


RMenu.Add('weed', 'recolte', RageUI.CreateMenu("Weed", "Récolte"))
RMenu.Add('weed', 'traitement', RageUI.CreateMenu("Weed", "Emballage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('weed', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter des Oranges", "Obscura", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        recolteweed()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('weed', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre Oranges en Sachet", "Obscura", {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            traitementweed()
                            RageUI.CloseAll()
                        end
                    end)
                        
            end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)



    ---------------------------------------- Position du Menu --------------------------------------------

    local recoltepossible = false
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            Wait(0)
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                if IsEntityAtCoord(PlayerPedId(), 1057.77, -3196.36, -39.16, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    
                          RageUI.Text({
                            message = "[~b~E~w~] Récolter de l'herbe de canabis",
                            time_display = 1
                        })
                            if IsControlJustPressed(1, 51) then
                                RageUI.Visible(RMenu:Get('weed', 'recolte'), not RageUI.Visible(RMenu:Get('weed', 'recolte')))
                            end
                        else
                       recoltepossible = false
                           end
                   end    
           end)
    
           local traitementpossible = false
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), 1035.93, -3206.14, -38.17, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre en l'herbe en sachet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('weed', 'traitement'), not RageUI.Visible(RMenu:Get('weed', 'traitement')))
                                    end
                                else
                                    traitementpossible = false
                                end
                            end    
                    end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function recolteweed()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Citizen.Wait(2000)
            TriggerServerEvent('rweed')
    end
    else
        recoltepossible = false
    end
end

function traitementweed()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            TriggerServerEvent('tweed')
    end
    else
        traitementpossible = false
    end
end
