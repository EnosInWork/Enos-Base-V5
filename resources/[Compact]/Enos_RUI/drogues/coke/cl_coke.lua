ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


RMenu.Add('coke', 'recolte', RageUI.CreateMenu("Coke", "Récolte"))
RMenu.Add('coke', 'traitement', RageUI.CreateMenu("Coke", "Emballage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('coke', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter de la coke", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        recoltecoke()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('coke', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre de la coke en sachet", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            traitementcoke()
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
                    if IsEntityAtCoord(PlayerPedId(), 1090.46, -3196.56, -38.99, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        
                              RageUI.Text({
                                message = "[~b~E~w~] Récolter de la coke",
                                time_display = 1
                            })
                                if IsControlJustPressed(1, 51) then
                                    RageUI.Visible(RMenu:Get('coke', 'recolte'), not RageUI.Visible(RMenu:Get('coke', 'recolte')))
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
                        if IsEntityAtCoord(PlayerPedId(), 1097.08, -3195.7, -38.99, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre la coke en sachet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('coke', 'traitement'), not RageUI.Visible(RMenu:Get('coke', 'traitement')))
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

function recoltecoke()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('rcoke')
    end
    else
        recoltepossible = false
    end
end

function traitementcoke()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            TriggerServerEvent('tcoke')
    end
    else
        traitementpossible = false
    end
end
