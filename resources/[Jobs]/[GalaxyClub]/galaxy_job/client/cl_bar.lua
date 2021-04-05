ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RMenu.Add('bargalaxy', 'main', RageUI.CreateMenu("Bar", "Pour la consommation des clients"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('bargalaxy', 'main'), true, true, true, function()    
         
        for k, v in pairs(Config.baritem) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = " ~g~$"..v.prix},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('galaxy:achatbar', v, quantite)
            end
            end)

        end
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.bar.position.x, Config.pos.bar.position.y, Config.pos.bar.position.z)
                DrawMarker(20, -1577.73, -3016.74, -80.01+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'galaxy' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au bar")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('bargalaxy', 'main'), not RageUI.Visible(RMenu:Get('bargalaxy', 'main')))
                    end   
                end
               end 
        end
end)