ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

---------------- FONCTIONS ------------------

RMenu.Add('tenue', 'vpolice', RageUI.CreateMenu("Vestaire", "~b~Vestiaire"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('tenue', 'vpolice'), true, true, true, function()

            RageUI.ButtonWithStyle("Reprendre sa tenue civile",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            end)

            RageUI.ButtonWithStyle("Tenue Cadet",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 87, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 2, 0)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 0, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.ButtonWithStyle("Tenue Officier",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 105, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 92, 0)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 1, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.ButtonWithStyle("Tenue Lieutenant - Unité Gang",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 129, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 92, 3)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 17, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.ButtonWithStyle("Tenue Sergent - Henri Support",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 105, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 65, 0)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 28, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.ButtonWithStyle("Tenue Commandant",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 122, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 101, 0)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 26, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.ButtonWithStyle("Tenue - Unité K-9",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 8, 105, 0) --tshirt 
                    SetPedComponentVariation(GetPlayerPed(-1) , 11, 101, 3)  --torse
                    SetPedComponentVariation(GetPlayerPed(-1) , 3, 26, 0)  -- bras
                    SetPedComponentVariation(GetPlayerPed(-1) , 4, 24, 0)   --pants
                    SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
                end
            end)

            RageUI.Separator("↓ ~o~Gestion GPB~s~ ↓")

            RageUI.ButtonWithStyle("Mettre",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 9, 1, 0)   --bulletwear
                end
            end)

            RageUI.ButtonWithStyle("Enlever",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedComponentVariation(GetPlayerPed(-1) , 9, 0, 0)   --bulletwear
                end
            end)

        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------


local position = {
    {x = 451.61, y = -993.35, z = 30.69}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                DrawMarker(20, 451.61, -993.35, 29.69+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)



            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('tenue', 'vpolice'), not RageUI.Visible(RMenu:Get('tenue', 'vpolice')))
                end
            end
        end
    end
    end
end)
