ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


RMenu.Add('lsd', 'recolte', RageUI.CreateMenu("LSD", "Récolte"))
RMenu.Add('lsd', 'traitement', RageUI.CreateMenu("LSD", "Emballage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('lsd', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter de la LSD", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then                  
                        recoltelsd()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('lsd', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre de la LSD en sachet", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            traitementlsd()
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
                    if IsEntityAtCoord(PlayerPedId(), 1005.14, -3151.12, -38.91, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        
                              RageUI.Text({
                                message = "[~b~E~w~] Récolter de la LSD",
                                time_display = 1
                            })
                                if IsControlJustPressed(1, 51) then
                                    RageUI.Visible(RMenu:Get('lsd', 'recolte'), not RageUI.Visible(RMenu:Get('lsd', 'recolte')))
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
                        if IsEntityAtCoord(PlayerPedId(), 1010.59, -3150.92, -38.91, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre la LSD en sachet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('lsd', 'traitement'), not RageUI.Visible(RMenu:Get('lsd', 'traitement')))
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

function recoltelsd()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Citizen.Wait(2000)
            TriggerServerEvent('rlsd')
    end
    else
        recoltepossible = false
    end
end

function traitementlsd()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            TriggerServerEvent('tlsd')
    end
    else
        traitementpossible = false
    end
end
