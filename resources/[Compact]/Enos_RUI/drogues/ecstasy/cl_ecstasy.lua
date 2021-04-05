ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


RMenu.Add('ecstasy', 'recolte', RageUI.CreateMenu("Ecstasy", "Récolte"))
RMenu.Add('ecstasy', 'traitement', RageUI.CreateMenu("Ecstasy", "Emballage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('ecstasy', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter de l\'Ecstasy", " ", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then                  
                        recolteecstasy()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('ecstasy', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre l\'Ecstasy en sachet", " ", {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            traitementecstasy()
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
                    if IsEntityAtCoord(PlayerPedId(), 1117.36, -3145.03, -37.06, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        
                              RageUI.Text({
                                message = "[~b~E~w~] Récolter de l\'Ecstasy",
                                time_display = 1
                            })
                                if IsControlJustPressed(1, 51) then
                                    RageUI.Visible(RMenu:Get('ecstasy', 'recolte'), not RageUI.Visible(RMenu:Get('ecstasy', 'recolte')))
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
                        if IsEntityAtCoord(PlayerPedId(), 1111.76, -3145.18, -37.06, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre l\'Ecstasy en sachet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('ecstasy', 'traitement'), not RageUI.Visible(RMenu:Get('ecstasy', 'traitement')))
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

function recolteecstasy()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Citizen.Wait(2000)
            TriggerServerEvent('recstasy')
    end
    else
        recoltepossible = false
    end
end

function traitementecstasy()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            TriggerServerEvent('tecstasy')
    end
    else
        traitementpossible = false
    end
end
