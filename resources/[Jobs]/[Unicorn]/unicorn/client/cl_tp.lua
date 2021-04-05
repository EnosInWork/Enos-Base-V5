
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.tpentrer.position.x, Config.pos.tpentrer.position.y, Config.pos.tpentrer.position.z)
        if dist2 <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then   
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au bar")
                if IsControlJustPressed(1,51) then
                    DoScreenFadeOut(100)
                    Citizen.Wait(750)
                    ESX.Game.Teleport(PlayerPedId(), {x = Config.pos.tpsortie.position.x, y = Config.pos.tpsortie.position.y, z = Config.pos.tpsortie.position.z})
                    DoScreenFadeIn(100)
                end   
            end
           end 
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.tpsortie.position.x, Config.pos.tpsortie.position.y, Config.pos.tpsortie.position.z)
        if dist2 <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then   
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour sortir du bar")
                if IsControlJustPressed(1,51) then
                    DoScreenFadeOut(100)
                    Citizen.Wait(750)
                    ESX.Game.Teleport(PlayerPedId(), {x = Config.pos.tpentrer.position.x, y = Config.pos.tpentrer.position.y, z = Config.pos.tpentrer.position.z})
                    DoScreenFadeIn(100)
                end   
            end
           end 
    end
end)

--------------------------------------------------

RMenu.Add('barunicorn', 'main', RageUI.CreateMenu("Bar", "Pour la consommation des clients"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('barunicorn', 'main'), true, true, true, function()    
         
        for k, v in pairs(Config.baritem) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = " ~g~$"..v.prix},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('unicorn:achatbar', v, quantite)
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
                DrawMarker(20, -1387.78, -612.2, 30.33+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au bar")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('barunicorn', 'main'), not RageUI.Visible(RMenu:Get('barunicorn', 'main')))
                    end   
                end
               end 
        end
end)