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

RMenu.Add('nehco', 'vmeca', RageUI.CreateMenu("Vestaire", "Karting"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('nehco', 'vmeca'), true, true, true, function()

            RageUI.ButtonWithStyle("S'équiper de sa tenue | ~b~Civile",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                if Selected then
                    vcivil()
                end
            end)

            RageUI.ButtonWithStyle("S'équiper de la tenue | ~r~Travaille",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                if Selected then
                    vkarting()
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------


local position = {
    {x = -1042.87, y = -3464.02, z = 14.33}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'karting' then 
                    DrawMarker(20, -1042.87, -3464.02, 13.33+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('nehco', 'vmeca'), not RageUI.Visible(RMenu:Get('nehco', 'vmeca')))
                end
            end
        end
    end
    end
end)

function vkarting()
                local model = GetEntityModel(GetPlayerPed(-1))
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if model == GetHashKey("mp_m_freemode_01") then
                        clothesSkin = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 2,
                            ['torso_1'] = 65, ['torso_2'] = 0,
                            ['arms'] = 31,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 12, ['shoes_2'] = 6,
                        }
                    else
                        clothesSkin = {
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
