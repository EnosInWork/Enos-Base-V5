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

RMenu.Add('enos', 'vestiaire', RageUI.CreateMenu("Vestaire", "Vestiaire"))
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('enos', 'vestiaire'), true, true, true, function()

            RageUI.ButtonWithStyle("Tenue ~r~Civile",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    vcivil()
                end
            end)

            RageUI.ButtonWithStyle("Tenue ~b~Ambulancier",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    vambulance()
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------


local position = {
    {x = 298.96, y = -598.14, z = 43.27}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then 
                DrawMarker(2, 284.70, -612.92, 43.33, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)

                DrawMarker(2, 298.96, -598.14, 43.27, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire de l'hôpital")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('enos', 'vestiaire'), not RageUI.Visible(RMenu:Get('enos', 'vestiaire')))
                end
            end
        end
    end
    end
end)

function vambulance()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 13, ['torso_2'] = 3,
                ['arms'] = 92,
                ['pants_1'] = 24, ['pants_2'] = 5,
                ['shoes_1'] = 8, ['shoes_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15,['tshirt_2'] = 2,
                ['torso_1'] = 65, ['torso_2'] = 2,
                ['arms'] = 36, ['arms_2'] = 0,
                ['pants_1'] = 38, ['pants_2'] = 2,
                ['shoes_1'] = 12, ['shoes_2'] = 6,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end


function vcivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

