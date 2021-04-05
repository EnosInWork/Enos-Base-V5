ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


RMenu.Add('vented', 'main', RageUI.CreateMenu("Vente", "Drogues"))

    Citizen.CreateThread(function()
        while true do
            RageUI.IsVisible(RMenu:Get('vented', 'main'), true, true, true, function()
    
                    RageUI.ButtonWithStyle("Essayer de lui vendre de la Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            VenteWeed()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Essayer de lui vendre de la coke", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            VenteCoke()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
        
                Citizen.Wait(0)
            end
        end)


function OpenVente()
    RageUI.Visible(RMenu:Get('vented', 'main'), not RageUI.Visible(RMenu:Get('vented', 'main')))
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    local ped = NetworkGetEntityFromNetworkId(npc)
    TaskTurnPedToFaceEntity(ped, GetPlayerPed(-1), 5000)
    TargetNpc = npc
end