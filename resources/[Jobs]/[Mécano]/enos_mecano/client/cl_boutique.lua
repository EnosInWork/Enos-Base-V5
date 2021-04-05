ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
---------------- FONCTIONS ------------------

RMenu.Add('fazer', 'Boutique', RageUI.CreateMenu("Boutique", "Outils"))
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('fazer', 'Boutique'), true, true, true, function()


            RageUI.ButtonWithStyle("Kits de réparations",nil, {RightLabel = "20€"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('méca:kit')
                end
            end)


            RageUI.ButtonWithStyle("Kits de carosserie",nil, {RightLabel = "5€"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('méca:caro')
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = -196.44, y = -1315.19, z = 31.09}---point ls custom à déplacer selon vos besoin.
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 

                DrawMarker(2, -196.44, -1315.19, 31.09, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder à la Boutique du Mécano")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('fazer', 'Boutique'), not RageUI.Visible(RMenu:Get('fazer', 'Boutique')))
                end
            end
        end
    end
    end
end)

