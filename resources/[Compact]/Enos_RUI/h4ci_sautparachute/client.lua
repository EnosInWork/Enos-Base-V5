ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

ConfPara              = {}
ConfPara.DrawDistance = 100
ConfPara.Size         = {x = 1.5, y = 1.5, z = 1.5}
ConfPara.Color        = {r = 0, g = 128, b = 255}
ConfPara.Type         = 40

local position = {
        {x = -119.17 , y = -977.16, z = 304.25},
        {x = -521.73 , y = 4427.68, z = 89.63},
        {x = 424.23 , y = 5614.0, z = 766.62},
        {x = -663.2 , y = 229.83, z = 165.09},
        {x = 777.03 , y = 1175.71, z = 345.96},
        {x = 128.28 , y = -348.94, z = 110.59},
}  

Citizen.CreateThread(function()
     for k in pairs(position) do
        local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
        SetBlipSprite(blip, 94)
        SetBlipColour(blip, 60)
        SetBlipScale(blip, 0.75)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Saut en parachute")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (ConfPara.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < ConfPara.DrawDistance) then
                DrawMarker(ConfPara.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfPara.Size.x, ConfPara.Size.y, ConfPara.Size.z, ConfPara.Color.r, ConfPara.Color.g, ConfPara.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('parachute', 'main', RageUI.CreateMenu("Parachute", "Activité parachute"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('parachute', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Parachute", "Pour obtenir un parachute", {RightLabel = "~r~1000$"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('h4ci:giveparachute')
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)




    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour obtenir un ~b~parachute")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('parachute', 'main'), not RageUI.Visible(RMenu:Get('parachute', 'main')))
                    end   
                end
            end
        end
    end)

