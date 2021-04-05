ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


RMenu.Add('opium', 'recolte', RageUI.CreateMenu("Opium", "Récolte"))
RMenu.Add('opium', 'traitement', RageUI.CreateMenu("Opium", "Emballage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('opium', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolter de l'opium", " ", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        recolteopium()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('opium', 'traitement'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mettre l'opium en sachet", " ", {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            traitementopium()
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
                if IsEntityAtCoord(PlayerPedId(), 1135.23, -3194.23, -40.4, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    
                          RageUI.Text({
                            message = "[~b~E~w~] Récolter de l'opium",
                            time_display = 1
                        })
                            if IsControlJustPressed(1, 51) then
                                RageUI.Visible(RMenu:Get('opium', 'recolte'), not RageUI.Visible(RMenu:Get('opium', 'recolte')))
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
                        if IsEntityAtCoord(PlayerPedId(), 1129.11, -3194.22, -40.4, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "[~b~E~w~] Mettre l'opium en sachet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('opium', 'traitement'), not RageUI.Visible(RMenu:Get('opium', 'traitement')))
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

function recolteopium()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Citizen.Wait(2000)
            TriggerServerEvent('ropium')
    end
    else
        recoltepossible = false
    end
end

function traitementopium()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            TriggerServerEvent('topium')
    end
    else
        traitementpossible = false
    end
end


